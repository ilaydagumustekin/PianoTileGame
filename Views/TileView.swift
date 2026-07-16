import SwiftUI

struct TileView: View {
    let tile: Tile
    
    var body: some View {
        Rectangle()
            .fill(tileColor)
            .border(Color.gray.opacity(0.3), width: 1)
    }
    
    private var tileColor: Color {
        if tile.isError {
            return .red // Yanlışa tıklandıysa kırmızı
        } else if tile.isBlack {
            return tile.isTapped ? Color.gray.opacity(0.4) : .black // Tıklandıysa soluk gri, aksi halde siyah
        } else {
            return .white // Normal boşluk
        }
    }
}

#Preview {
    // Önizleme için örnek bir siyah karo
    TileView(tile: Tile(isBlack: true, isTapped: false, isError: false))
}
