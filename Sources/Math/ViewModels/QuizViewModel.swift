import Foundation
import SwiftUI

@MainActor
public final class QuizViewModel: ObservableObject {
    @Published private(set) var question: Question
    @Published public var problemType: ProblemType = .factorization {
        didSet { newQuestion() }
    }
    @Published public var inputA: String = ""
    @Published public var inputB: String = ""
    @Published public var inputC: String = ""
    @Published public var inputD: String = ""
    @Published public var feedback: String = ""
    @Published public var isCorrect: Bool = false
    @Published public var difficulty: Difficulty = .easy {
        didSet { newQuestion() }
    }

    public init() {
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
