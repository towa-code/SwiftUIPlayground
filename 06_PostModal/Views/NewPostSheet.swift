import SwiftUI

struct NewPostSheet: View {
    // @Binding ではなく @ObservedObject でViewModelを受け取る
    @ObservedObject var viewModel: FeedViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var title = ""
    @State private var bodyText = ""

    var isFormValid: Bool {
        !title.trimmingCharacters(in: .whitespaces).isEmpty &&
        !bodyText.trimmingCharacters(in: .whitespaces).isEmpty
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("タイトル") {
                    TextField("投稿のタイトル", text: $title)
                }

                Section("本文") {
                    // TextEditor: 複数行テキスト入力
                    TextEditor(text: $bodyText)
                        .frame(minHeight: 120)
                }

                Section {
                    // @Binding の使い方サンプル
                    CharacterCountView(text: $bodyText, limit: 200)
                }
            }
            .navigationTitle("新規投稿")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("キャンセル") {
                        // @Environment(\.dismiss) でシートを閉じる
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("投稿する") {
                        viewModel.addPost(title: title, body: bodyText)
                        dismiss()
                    }
                    .bold()
                    .disabled(!isFormValid)
                }
            }
        }
        // presentationDetents: シートの高さを制御
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
    }
}

// @Binding の学習用: 親からテキストのBindingを受け取って文字数カウント
struct CharacterCountView: View {
    @Binding var text: String  // 親Viewのstateへの参照
    let limit: Int

    var count: Int { text.count }
    var isOverLimit: Bool { count > limit }

    var body: some View {
        HStack {
            Text("文字数")
            Spacer()
            Text("\(count) / \(limit)")
                .foregroundStyle(isOverLimit ? .red : .secondary)
                .fontWeight(isOverLimit ? .bold : .regular)
        }
        .font(.subheadline)
    }
}

#Preview {
    NewPostSheet(viewModel: FeedViewModel())
}
