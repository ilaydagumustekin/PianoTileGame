import SwiftUI

struct GameOverView: View {

    let score: Int
    let highScore: Int
    let playAgain: () -> Void

    var body: some View {

        VStack(spacing: 24) {

            Image(systemName: "xmark.circle.fill")
                .font(.system(size: 70))
                .foregroundStyle(.red)

            Text("GAME OVER")
                .font(.largeTitle.bold())

            VStack(spacing: 12) {

                HStack {

                    Text("Score")

                    Spacer()

                    Text("\(score)")
                        .bold()
                }

                HStack {

                    Text("High Score")

                    Spacer()

                    Text("\(highScore)")
                        .bold()
                }

            }
            .padding()
            .background(Color.gray.opacity(0.12))
            .clipShape(RoundedRectangle(cornerRadius: 12))

            Button {

                playAgain()

            } label: {

                Text("Play Again")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
            }
        }
        .padding(30)
        .frame(maxWidth: 340)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(radius: 15)
    }
}

#Preview {

    ZStack {

        Color.black.opacity(0.5)
            .ignoresSafeArea()

        GameOverView(
            score: 18,
            highScore: 62
        ) {

        }
    }
}
