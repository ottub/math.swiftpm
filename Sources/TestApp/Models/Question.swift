import Foundation

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
