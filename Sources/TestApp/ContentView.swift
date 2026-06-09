import SwiftUI

struct ContentView: View {
    @StateObject private var vm = QuizViewModel()
    @State private var isStarted = false

    var body: some View {
        if isStarted {
            quizView
        } else {
            TitleView(isStarted: $isStarted)
        }
    }

    private var quizView: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Picker("問題タイプ", selection: $vm.problemType) {
                    ForEach(ProblemType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)

                Picker("難易度", selection: $vm.difficulty) {
                    ForEach(Difficulty.allCases, id: \.self) { d in
                        Text(d.rawValue).tag(d)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)

                QuestionView(vm: vm)

                Spacer()
            }
            .navigationTitle("因数分解練習")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("戻る") {
                        isStarted = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
