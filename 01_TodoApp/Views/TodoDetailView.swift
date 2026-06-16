import SwiftUI

struct TodoDetailView: View {
    let item: TodoItem
    @ObservedObject var viewModel: TodoViewModel

    var body: some View {
        Form {
            Section("タイトル") {
                Text(item.title)
            }

            Section("ステータス") {
                HStack {
                    Text(item.isCompleted ? "完了" : "未完了")
                        .foregroundStyle(item.isCompleted ? .green : .orange)
                    Spacer()
                    Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                        .foregroundStyle(item.isCompleted ? .green : .secondary)
                }
            }

            Section("作成日") {
                Text(item.createdAt.formatted(date: .long, time: .shortened))
                    .foregroundStyle(.secondary)
            }

            Section {
                Button {
                    viewModel.toggleItem(item)
                } label: {
                    Label(
                        item.isCompleted ? "未完了に戻す" : "完了にする",
                        systemImage: item.isCompleted ? "arrow.uturn.backward" : "checkmark.circle"
                    )
                }
                .foregroundStyle(item.isCompleted ? .orange : .green)
            }
        }
        .navigationTitle("詳細")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        TodoDetailView(item: TodoItem.samples[1], viewModel: TodoViewModel())
    }
}
