import SwiftUI

/// パスワード変更画面のプレースホルダー（学習用ダミー画面）
struct PasswordPlaceholderView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "lock.shield")
                .font(.largeTitle)
                .foregroundStyle(.secondary)
            Text("パスワード変更画面")
                .font(.headline)
        }
        .navigationTitle("パスワード変更")
    }
}

#Preview {
    NavigationStack {
        PasswordPlaceholderView()
    }
}
