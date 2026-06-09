import Foundation
import SwiftUI

@MainActor
final class QuizViewModel: ObservableObject {
    @Published private(set) var question: Question
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
        self.question = FactorizationGenerator.makeQuestion(difficulty: .easy)
    }

    func newQuestion() {
        self.question = FactorizationGenerator.makeQuestion(difficulty: difficulty)
        self.inputA = ""
        self.inputB = ""
        self.inputC = ""
        self.inputD = ""
        self.feedback = ""
        self.isCorrect = false
    }

    func checkAnswer() {
        let values = [inputA, inputB, inputC, inputD]
        let parsed = values.map { Int($0.trimmingCharacters(in: .whitespacesAndNewlines)) }
        guard parsed.count == 4, parsed.allSatisfy({ $0 != nil }) else {
            feedback = "すべての欄に整数を入力してください。"
            isCorrect = false
            return
        }
        let vals = parsed.map { $0! }
        let expected = question.expectedFactors
        // Accept either (a,b,c,d) or swapped (c,d,a,b)
        let attempt1 = (a: vals[0], b: vals[1], c: vals[2], d: vals[3])
        let attempt2 = (a: vals[2], b: vals[3], c: vals[0], d: vals[1])
        if attempt1 == expected || attempt2 == expected {
            feedback = "正解！"
            isCorrect = true
        } else {
            feedback = "不正解です。もう一度試してください。"
            isCorrect = false
        }
    }
}
