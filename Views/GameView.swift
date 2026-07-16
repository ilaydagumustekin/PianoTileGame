import SwiftUI

struct GameView: View {
    @StateObject private var engine = GameEngine()
    
    var body: some View {
        ZStack {
            // --- 1. KATMAN: OYUN ALANI (Akan Karolar) ---
            GeometryReader { geo in
                ZStack(alignment: .top) {
                    Color.white
                    
                    VStack(spacing: 0) {
                        ForEach(engine.rows) { row in
                            HStack(spacing: 0) {
                                ForEach(row.tiles) { tile in
                                    TileView(tile: tile)
                                        .onTapGesture {
                                            engine.tapTile(row: row, tile: tile)
                                        }
                                }
                            }
                            .frame(height: engine.rowHeight)
                        }
                    }
                    .offset(y: engine.offset - engine.rowHeight)
                }
                .frame(width: geo.size.width, height: geo.size.height)
                .clipped()
            }
            .ignoresSafeArea()
            
            // --- 2. KATMAN: SKOR GÖSTERGESİ (HUD - Buzlu Cam) ---
            VStack(spacing: 2) {
                Text("\(engine.score)")
                    .font(.system(size: 42, weight: .black, design: .rounded))
                    .foregroundColor(.primary)
                
                Text("Best: \(engine.highScore)")
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 32)
            .padding(.vertical, 12)
            .background(.regularMaterial) // Buzlu cam efekti
            .clipShape(Capsule())
            .shadow(color: .black.opacity(0.15), radius: 10, y: 5)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(.top, 60)
            
            // --- 3. KATMAN: GAME OVER EKRANI (Önceki Tam Ekran Tasarım) ---
            if engine.isGameOver {
                ZStack {
                    Color.black.opacity(0.7).ignoresSafeArea() // Arka planı tamamen karart
                    
                    VStack(spacing: 20) {
                        Text("GAME OVER")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(.red)
                        
                        VStack(spacing: 10) {
                            Text("Skor: \(engine.score)")
                                .font(.title)
                                .foregroundColor(.white)
                            
                            Text("En Yüksek: \(engine.highScore)")
                                .font(.title3)
                                .foregroundColor(.gray)
                        }
                        
                        Button(action: {
                            engine.startGame()
                        }) {
                            Text("Tekrar Oyna")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(10)
                        }
                        .padding(.top, 10)
                    }
                }
            }
        }
    }
}

#Preview {
    GameView()
}
