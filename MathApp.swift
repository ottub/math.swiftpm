import SwiftUI
import PlaygroundSupport

// MARK: - Models

enum Difficulty: String, CaseIterable {
    case easy = "簡単"
    case medium = "普通"
    case hard = "難しい"
}

enum ProblemType: String, CaseIterable {
    case factorization = "因数分解"
    case expansion = "展開"
}

struct Question: Identifiable {
    let id = UUID()
    let prompt: String
    let kind: ProblemType
    let expectedAnswers: [Int]
    let difficulty: Difficulty
}

// MARK: - Question Generator

struct QuestionGenerator {
    static func makeQuestion(kind: ProblemType, difficulty: Difficulty) -> Question {
        switch kind {
        case .factorization:
            return makeFactorizationQuestion(difficulty: difficulty)
        case .expansion:
            return makeExpansionQuestion(difficulty: difficulty)
        }
    }

    private static func makeFactorizationQuestion(difficulty: Difficulty) -> Question {
        switch difficulty {
        case .easy:
            let r1 = Int.random(in: 0...9)
            let r2 = Int.random(in: 0...9)
            let quad = "x^2 + \(r1 + r2)x + \(r1 * r2)"
            return Question(
                prompt: "因数分解: " + quad,
                kind: .factorization,
                expectedAnswers: [1, r1, 1, r2],
                difficulty: .easy
            )
        case .medium:
            var r1 = Int.random(in: 0...9)
            var r2 = Int.random(in: 0...9)
            while r1 == r2 { r2 = Int.random(in: 0...9) }
            let quad = "x^2 + \(r1 + r2)x + \(r1 * r2)"
            return Question(
                prompt: "因数分解: " + quad,
                kind: .factorization,
                expectedAnswers: [1, r1, 1, r2],
                difficulty: .medium
            )
        case .hard:
            let A = Int.random(in: 2...9)
            let m = Int.random(in: 0...9)
            let n = Int.random(in: 0...9)
            let quad = "\(A)x^2 + \(A * n + m)x + \(m * n)"
            return Question(
                prompt: "因数分解: " + quad,
                kind: .factorization,
                expectedAnswers: [A, m, 1, n],
                difficulty: .hard
            )
        }
    }

    private static func makeExpansionQuestion(difficulty: Difficulty) -> Question {
        switch difficulty {
        case .easy:
            let r1 = Int.random(in: 0...9)
            let r2 = Int.random(in: 0...9)
            let prompt = "展開: (x + \(r1))(x + \(r2))"
            return Question(
                prompt: prompt,
                kind: .expansion,
                expectedAnswers: [1, r1 + r2, r1 * r2],
                difficulty: .easy
            )
        case .medium:
            let a = Int.random(in: 2...5)
            let b = Int.random(in: 0...9)
            let c = Int.random(in: 0...9)
            let prompt = "展開: (\(a)x + \(b))(x + \(c))"
            return Question(
                prompt: prompt,
                kind: .expansion,
                expectedAnswers: [a, a * c + b, b * c],
                difficulty: .medium
            )
        case .hard:
            let a = Int.random(in: 2...5)
            let c = Int.random(in: 2...5)
            let b = Int.random(in: 0...9)
            let d = Int.random(in: 0...9)
            let prompt = "展開: (\(a)x + \(b))(\(c)x + \(d))"
            return Question(
                prompt: prompt,
                kind: .expansion,
                expectedAnswers: [a * c, a * d + b * c, b * d],
                difficulty: .hard
            )
        }
    }
}

// MARK: - ViewModel

@MainActor
class QuizViewModel: ObservableObject {
    @Published private(set) var question: Question
    @Published var problemType: ProblemType = .factorization {
        didSet { newQuestion() }
    }
    @Published var inputA: String = ""
    @Published var inputB: String = ""
    @Published var inputC: String = ""
    @Published var inputD: String = ""
    @Published var feedback: String = ""
    @Published var isCorrect: Bool = false
    @Published var difficulty: Difficulty = .easy {
        didSet { newQuestion() }
    }

    init() {
        self.question = QuestionGenerator.makeQuestion(kind: .factorization, difficulty: .easy)
    }

    func newQuestion() {
        self.question = QuestionGenerator.makeQuestion(kind: problemType, difficulty: difficulty)
        self.inputA = ""
        self.inputB = ""
        self.inputC = ""
        self.inputD = ""
        self.feedback = ""
        self.isCorrect = false
    }

    func checkAnswer() {
        let values = [inputA, inputB, inputC, inputD]
        let count = question.expectedAnswers.count
        let answerTexts = Array(values.prefix(count))
        let parsed = answerTexts.map { Int($0.trimmingCharacters(in: .whitespacesAndNewlines)) }
        guard parsed.count == count, parsed.allSatisfy({ $0 != nil }) else {
            feedback = "すべての欄に整数を入力してください。"
            isCorrect = false
            return
        }
        let vals = parsed.map { $0! }
        let expected = question.expectedAnswers

        let isMatch: Bool
        if question.kind == .factorization {
            let attempt1 = [vals[0], vals[1], vals[2], vals[3]]
            let attempt2 = [vals[2], vals[3], vals[0], vals[1]]
            isMatch = attempt1 == expected || attempt2 == expected
        } else {
            isMatch = vals == expected
        }

        if isMatch {
            feedback = "正解！"
            isCorrect = true
        } else {
            feedback = "不正解です。もう一度試してください。"
            isCorrect = false
        }
    }
}

// MARK: - Views

struct QuestionView: View {
    @ObservedObject var vm: QuizViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text(vm.question.prompt)
                .font(.title2)
                .multilineTextAlignment(.center)

            if vm.question.kind == .factorization {
                HStack(spacing: 12) {
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
            } else {
                VStack(spacing: 12) {
                    HStack(spacing: 4) {
                        TextField("a", text: $vm.inputA)
                            .keyboardType(.numbersAndPunctuation)
                            .frame(width: 44)
                            .textFieldStyle(.roundedBorder)
                        Text("x² +")
                        TextField("b", text: $vm.inputB)
                            .keyboardType(.numbersAndPunctuation)
                            .frame(width: 44)
                            .textFieldStyle(.roundedBorder)
                    }
                    HStack(spacing: 4) {
                        Text("x +")
                        TextField("c", text: $vm.inputC)
                            .keyboardType(.numbersAndPunctuation)
                            .frame(width: 44)
                            .textFieldStyle(.roundedBorder)
                    }
                }
                .font(.title3)
            }

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

// MARK: - Playground Setup

PlaygroundPage.current.setLiveView(ContentView())
