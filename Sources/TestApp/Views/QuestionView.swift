import SwiftUI

struct QuestionView: View {
    @ObservedObject var vm: QuizViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text(vm.question.prompt)
                .font(.title2)
                .multilineTextAlignment(.center)

            HStack(spacing: 12) {
                // Factor 1: (a x + b)
                HStack(spacing: 4) {
                    TextField("a", text: $vm.inputA)
                        .keyboardType(.numbersAndPunctuation)
                        .frame(width: 44)
                        .textFieldStyle(.roundedBorder)
                    Text("x +")
                    TextField("b", text: $vm.inputB)
                        .keyboardType(.numbersAndPunctuation)
                        .frame(width: 44)
                        .textFieldStyle(.roundedBorder)
                }
                Text("×")
                // Factor 2: (c x + d)
                HStack(spacing: 4) {
                    TextField("c", text: $vm.inputC)
                        .keyboardType(.numbersAndPunctuation)
                        .frame(width: 44)
                        .textFieldStyle(.roundedBorder)
                    Text("x +")
                    TextField("d", text: $vm.inputD)
                        .keyboardType(.numbersAndPunctuation)
                        .frame(width: 44)
                        .textFieldStyle(.roundedBorder)
                }
            }
            .font(.title3)

            HStack(spacing: 12) {
                Button("チェック") {
                    vm.checkAnswer()
                }
                .buttonStyle(.borderedProminent)

                Button("次の問題") {
                    vm.newQuestion()
                }
                .buttonStyle(.bordered)
                .disabled(!vm.isCorrect)
            }

            Text(vm.feedback)
                .foregroundColor(vm.isCorrect ? .green : .red)
        }
        .padding()
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(vm: QuizViewModel())
    }
}
