import Foundation

struct Tile: Identifiable {
    let id = UUID()
    var isBlack: Bool
    var isTapped: Bool = false // Doğru tıklamayı takip etmek için
    var isError: Bool = false  // Yanlış tıklamada (kırmızı) göstermek için
}

struct TileRow: Identifiable {
    let id = UUID()
    var tiles: [Tile]
    
    static func generateRandom() -> TileRow {
        var tiles = (0..<4).map { _ in Tile(isBlack: false) }
        let randomIndex = Int.random(in: 0..<4)
        tiles[randomIndex].isBlack = true
        return TileRow(tiles: tiles)
    }
}
