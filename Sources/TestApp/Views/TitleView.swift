import SwiftUI

struct TitleView: View {
    @Binding var isStarted: Bool

    var body: some View {
        VStack(spacing: 40) {
            Spacer()

            VStack(spacing: 16) {
                Text("因数分解練習")
                    .font(.system(size: 48, weight: .bold))
                    .multilineTextAlignment(.center)

                Text("高校数学の因数分解問題を\n練習できます")
                    .font(.system(size: 18, weight: .regular))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }

            Spacer()

            Button(action: {
                isStarted = true
            }) {
                Text("始める")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(Color.blue)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}

struct TitleView_Previews: PreviewProvider {
    @State static var isStarted = false

    static var previews: some View {
        TitleView(isStarted: $isStarted)
    }
}
