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
                    TextField("a", text: Binding(
                        get: { vm.inputs.indices.contains(0) ? vm.inputs[0] : "" },
                        set: { if vm.inputs.indices.contains(0) { vm.inputs[0] = $0 } }
                    ))
                        .keyboardType(.numbersAndPunctuation)
                        .frame(width: 44)
                        .textFieldStyle(.roundedBorder)
                    Text("x +")
                    TextField("b", text: Binding(
                        get: { vm.inputs.indices.contains(1) ? vm.inputs[1] : "" },
                        set: { if vm.inputs.indices.contains(1) { vm.inputs[1] = $0 } }
                    ))
                        .keyboardType(.numbersAndPunctuation)
                        .frame(width: 44)
                        .textFieldStyle(.roundedBorder)
                }
                Text("×")
                // Factor 2: (c x + d)
                HStack(spacing: 4) {
                    TextField("c", text: Binding(
                        get: { vm.inputs.indices.contains(2) ? vm.inputs[2] : "" },
                        set: { if vm.inputs.indices.contains(2) { vm.inputs[2] = $0 } }
                    ))
                        .keyboardType(.numbersAndPunctuation)
                        .frame(width: 44)
                        .textFieldStyle(.roundedBorder)
                    Text("x +")
                    TextField("d", text: Binding(
                        get: { vm.inputs.indices.contains(3) ? vm.inputs[3] : "" },
                        set: { if vm.inputs.indices.contains(3) { vm.inputs[3] = $0 } }
                    ))
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
