import SwiftUI

struct TodoListView: View {
    @StateObject private var viewModel = TodoViewModel()

    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack(spacing: 16) {
                        Label("\(viewModel.pendingCount) 件残り", systemImage: "circle")
                            .foregroundStyle(.orange)
                        Label("\(viewModel.completedCount) 件完了", systemImage: "checkmark.circle.fill")
                            .foregroundStyle(.green)
                    }
                    .font(.caption)
                }

                ForEach(viewModel.items) { item in
                    NavigationLink(destination: TodoDetailView(item: item, viewModel: viewModel)) {
                        TodoRowView(item: item) {
                            viewModel.toggleItem(item)
                        }
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            if let index = viewModel.items.firstIndex(where: { $0.id == item.id }) {
                                viewModel.deleteItems(at: IndexSet([index]))
                            }
                        } label: {
                            Label("削除", systemImage: "trash")
                        }
                    }
                    .swipeActions(edge: .leading) {
                        Button {
                            viewModel.toggleItem(item)
                        } label: {
                            Label(
                                item.isCompleted ? "未完了" : "完了",
                                systemImage: item.isCompleted ? "arrow.uturn.backward" : "checkmark"
                            )
                        }
                        .tint(item.isCompleted ? .orange : .green)
                    }
                }
                .onDelete(perform: viewModel.deleteItems)
            }
            .navigationTitle("TODO")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            .safeAreaInset(edge: .bottom) {
                AddTodoView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    TodoListView()
}
