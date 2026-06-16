import Foundation
import Combine

class TodoViewModel: ObservableObject {
    @Published var items: [TodoItem] = TodoItem.samples
    @Published var newTitle: String = ""

    var completedCount: Int { items.filter(\.isCompleted).count }
    var pendingCount: Int { items.filter { !$0.isCompleted }.count }

    func addItem() {
        let trimmed = newTitle.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else { return }
        items.append(TodoItem(title: trimmed))
        newTitle = ""
    }

    func toggleItem(_ item: TodoItem) {
        guard let index = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[index].isCompleted.toggle()
    }

    func deleteItems(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
}
