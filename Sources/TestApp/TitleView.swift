import SwiftUI

struct TitleView: View {
    @State private var isStarted = false

    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()

            VStack(spacing: 24) {
                Spacer()

                VStack(spacing: 12) {
                    Text("Math Practice")
                        .font(.system(size: 44, weight: .bold))
                        .multilineTextAlignment(.center)

                    Text("A SwiftUI title screen for Swift Playgrounds")
                        .font(.title3)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal, 24)

                Button(action: {
                    isStarted = true
                }) {
                    Text("Start")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(16)
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 24)

                Spacer()

                Text("iOS 16+ / SwiftUI")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            .padding(.bottom, 32)
        }
        .sheet(isPresented: $isStarted) {
            VStack(spacing: 16) {
                Text("Title screen test")
                    .font(.title)
                    .bold()
                Text("This is a placeholder for the next screen.")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding()
            }
            .presentationDetents([.medium])
        }
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView()
            .previewDevice("iPad (10th generation)")
    }
}
