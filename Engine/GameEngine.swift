import SwiftUI
import Combine

class GameEngine: ObservableObject {
    @Published var rows: [TileRow] = []
    @Published var offset: CGFloat = 0
    @Published var score: Int = 0
    @Published var isGameOver: Bool = false
    @Published var hasStarted: Bool = false
    
    // ✅ YENİ: En yüksek skoru tutan ve cihaz hafızasına kaydeden değişken
    @Published var highScore: Int {
        didSet {
            UserDefaults.standard.set(highScore, forKey: "HighScore")
        }
    }
    
    private var timer: AnyCancellable?
    private let speed: CGFloat = 6.0
    let rowHeight: CGFloat = 150.0
    
    init() {
        // Uygulama açıldığında kayıtlı skoru yükle
        self.highScore = UserDefaults.standard.integer(forKey: "HighScore")
        startGame()
    }
    
    func startGame() {
        score = 0
        isGameOver = false
        hasStarted = false
        offset = 0
        rows = []
        
        for _ in 0..<7 {
            rows.append(TileRow.generateRandom())
        }
        
        timer = Timer.publish(every: 0.016, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.gameLoop()
            }
    }
    
    private func gameLoop() {
        guard !isGameOver && hasStarted else { return }
        
        offset += speed
        
        if offset >= rowHeight {
            offset = 0
            rows.insert(TileRow.generateRandom(), at: 0)
            
            if rows.count > 7 {
                let removedRow = rows.removeLast()
                
                if removedRow.tiles.contains(where: { $0.isBlack && !$0.isTapped }) {
                    gameOver()
                }
            }
        }
    }
    
    func tapTile(row: TileRow, tile: Tile) {
        guard !isGameOver else { return }
        
        if let rowIndex = rows.firstIndex(where: { $0.id == row.id }),
           let tileIndex = rows[rowIndex].tiles.firstIndex(where: { $0.id == tile.id }) {
            
            if tile.isBlack {
                if !rows[rowIndex].tiles[tileIndex].isTapped {
                    rows[rowIndex].tiles[tileIndex].isTapped = true
                    score += 1
                    
                    if !hasStarted {
                        hasStarted = true
                    }
                }
            } else {
                rows[rowIndex].tiles[tileIndex].isError = true
                gameOver()
            }
        }
    }
    
    private func gameOver() {
        isGameOver = true
        timer?.cancel()
        
        // ✅ YENİ: Oyun bittiğinde rekor kontrolü yap
        if score > highScore {
            highScore = score
        }
    }
}
