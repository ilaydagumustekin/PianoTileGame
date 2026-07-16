import SwiftUI

struct ScoreView: View {

    let score: Int
    let highScore: Int

    var body: some View {

        VStack(spacing: 8) {

            Text("DON'T TAP RED")
                .font(.largeTitle.bold())

            HStack(spacing: 40) {

                VStack {

                    Text("Score")
                        .font(.headline)
                        .foregroundStyle(.secondary)

                    Text("\(score)")
                        .font(.system(size: 34, weight: .bold))
                }

                VStack {

                    Text("High Score")
                        .font(.headline)
                        .foregroundStyle(.secondary)

                    Text("\(highScore)")
                        .font(.system(size: 34, weight: .bold))
                }
            }
        }
        .padding()
    }
}

    #Preview {
        ScoreView(
            score: 25,
            highScore: 80
        )
    }
