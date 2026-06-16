import Foundation
import SwiftUI

struct Habit: Identifiable {
    let id: UUID
    var name: String
    var emoji: String
    var targetCount: Int        // 1日の目標回数
    var completedCount: Int     // 今日の完了回数
    var streak: Int             // 連続日数
    var color: Color

    init(
        id: UUID = UUID(),
        name: String,
        emoji: String,
        targetCount: Int = 1,
        completedCount: Int = 0,
        streak: Int = 0,
        color: Color = .blue
    ) {
        self.id = id
        self.name = name
        self.emoji = emoji
        self.targetCount = targetCount
        self.completedCount = completedCount
        self.streak = streak
        self.color = color
    }

    var progress: Double {
        guard targetCount > 0 else { return 0 }
        return min(Double(completedCount) / Double(targetCount), 1.0)
    }

    var isCompleted: Bool {
        completedCount >= targetCount
    }
}

extension Habit {
    static let samples: [Habit] = [
        Habit(name: "朝の瞑想", emoji: "🧘", targetCount: 1, completedCount: 1, streak: 7, color: .purple),
        Habit(name: "読書", emoji: "📚", targetCount: 30, completedCount: 12, streak: 3, color: .orange),
        Habit(name: "ウォーキング", emoji: "🚶", targetCount: 10000, completedCount: 6540, streak: 14, color: .green),
        Habit(name: "水を飲む", emoji: "💧", targetCount: 8, completedCount: 5, streak: 21, color: .blue),
        Habit(name: "英語学習", emoji: "🌍", targetCount: 1, completedCount: 0, streak: 0, color: .red),
    ]
}
