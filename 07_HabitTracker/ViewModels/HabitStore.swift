import Foundation
import Combine

// ObservableObject: 変更を@StateObject/@ObservedObjectで購読できるクラス
class HabitStore: ObservableObject {
    // @Published: 値が変更されるとViewが自動的に再描画される
    @Published var habits: [Habit] = Habit.samples

    var totalCompleted: Int {
        habits.filter(\.isCompleted).count
    }

    var overallProgress: Double {
        guard !habits.isEmpty else { return 0 }
        return habits.reduce(0) { $0 + $1.progress } / Double(habits.count)
    }

    func increment(_ habit: Habit) {
        guard let index = habits.firstIndex(where: { $0.id == habit.id }) else { return }
        if habits[index].completedCount < habits[index].targetCount {
            habits[index].completedCount += 1
        }
    }

    func decrement(_ habit: Habit) {
        guard let index = habits.firstIndex(where: { $0.id == habit.id }) else { return }
        if habits[index].completedCount > 0 {
            habits[index].completedCount -= 1
        }
    }

    func complete(_ habit: Habit) {
        guard let index = habits.firstIndex(where: { $0.id == habit.id }) else { return }
        habits[index].completedCount = habits[index].targetCount
        habits[index].streak += 1
    }

    func reset(_ habit: Habit) {
        guard let index = habits.firstIndex(where: { $0.id == habit.id }) else { return }
        habits[index].completedCount = 0
    }

    func addHabit(name: String, emoji: String, target: Int, color: Color) {
        let habit = Habit(name: name, emoji: emoji, targetCount: target, color: color)
        habits.append(habit)
    }

    func deleteHabit(_ habit: Habit) {
        habits.removeAll { $0.id == habit.id }
    }
}
