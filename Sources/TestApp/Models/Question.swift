import Foundation

enum Difficulty: String, CaseIterable {
    case easy = "簡単"
    case medium = "普通"
    case hard = "難しい"
}

struct Question: Identifiable {
    let id = UUID()
    let prompt: String
    let expectedFactors: (a: Int, b: Int, c: Int, d: Int)
    let difficulty: Difficulty
}

struct FactorizationGenerator {
    static func makeQuestion(difficulty: Difficulty) -> Question {
        switch difficulty {
        case .easy:
            // a = c = 1, roots r1,r2 in 0...9
            let r1 = Int.random(in: 0...9)
            let r2 = Int.random(in: 0...9)
            let a = 1, c = 1
            let b = r1
            let d = r2
            let prompt = quadraticString(a: a, b: a*(b+d), c: b*d) // but we'll format as x^2 + (r1+r2)x + r1*r2
            let quad = "x^2 + \(r1 + r2)x + \(r1 * r2)"
            return Question(prompt: "因数分解: " + quad, expectedFactors: (a: a, b: b, c: c, d: d), difficulty: .easy)
        case .medium:
            // a = c = 1, distinct roots, slightly larger sums
            var r1 = Int.random(in: 0...9)
            var r2 = Int.random(in: 0...9)
            while r1 == r2 { r2 = Int.random(in: 0...9) }
            let quad = "x^2 + \(r1 + r2)x + \(r1 * r2)"
            return Question(prompt: "因数分解: " + quad, expectedFactors: (a: 1, b: r1, c: 1, d: r2), difficulty: .medium)
        case .hard:
            // Leading coefficient a in 2...9. Build (A x + m)(x + n) => a = A, c = 1
            let A = Int.random(in: 2...9)
            let m = Int.random(in: 0...9)
            let n = Int.random(in: 0...9)
            // quadratic: A x^2 + (A*n + m) x + m*n
            let quad = "\(A)x^2 + \(A * n + m)x + \(m * n)"
            return Question(prompt: "因数分解: " + quad, expectedFactors: (a: A, b: m, c: 1, d: n), difficulty: .hard)
        }
    }

    private static func quadraticString(a: Int, b: Int, c: Int) -> String {
        return "\(a)x^2 + \(b)x + \(c)"
    }
}
