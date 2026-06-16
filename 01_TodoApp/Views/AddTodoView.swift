import SwiftUI

struct AddTodoView: View {
    @ObservedObject var viewModel: TodoViewModel
    @FocusState private var isFocused: Bool

    var body: some View {
        HStack(spacing: 12) {
            TextField("新しいタスクを入力", text: $viewModel.newTitle)
                .textFieldStyle(.roundedBorder)
                .focused($isFocused)
                .onSubmit {
                    viewModel.addItem()
                    isFocused = true
                }

            Button(action: {
                viewModel.addItem()
                isFocused = true
            }) {
                Image(systemName: "plus.circle.fill")
                    .font(.title2)
                    .foregroundStyle(
                        viewModel.newTitle.trimmingCharacters(in: .whitespaces).isEmpty ? .secondary : .blue
                    )
            }
            .disabled(viewModel.newTitle.trimmingCharacters(in: .whitespaces).isEmpty)
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .background(.regularMaterial)
    }
}

#Preview {
    VStack {
        Spacer()
        AddTodoView(viewModel: TodoViewModel())
    }
}
