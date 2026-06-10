import SwiftUI
import PlaygroundSupport

struct TitleView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()

            VStack(spacing: 28) {
                Spacer()

                VStack(spacing: 12) {
                    Text("Math Practice")
                        .font(.system(size: 42, weight: .bold))
                        .multilineTextAlignment(.center)

                    Text("A simple SwiftUI title screen for Swift Playgrounds")
                        .font(.title3)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal, 32)

                Button(action: {}) {
                    Text("Start")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(16)
                        .padding(.horizontal, 32)
                }

                Spacer()

                Text("iOS 16+ / SwiftUI")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            .padding(.bottom, 40)
        }
    }
}

PlaygroundPage.current.setLiveView(TitleView())
