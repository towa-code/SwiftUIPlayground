import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @State private var showResetAlert = false
    @State private var showExportAlert = false

    var body: some View {
        NavigationStack {
            Form {
                // MARK: - アカウント
                Section("アカウント") {
                    HStack(spacing: 12) {
                        Image(systemName: "person.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.blue)
                        VStack(alignment: .leading, spacing: 4) {
                            TextField("ユーザー名", text: $viewModel.username)
                                .font(.headline)
                            Text("プロフィールを編集")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(.vertical, 6)
                }

                // MARK: - 外観
                Section("外観") {
                    // Picker: 複数の選択肢から1つを選ぶ
                    Picker("テーマ", selection: $viewModel.theme) {
                        ForEach(AppTheme.allCases) { theme in
                            Text(theme.rawValue).tag(theme)
                        }
                    }

                    Picker("フォントサイズ", selection: $viewModel.fontSize) {
                        ForEach(FontSize.allCases) { size in
                            Text(size.rawValue).tag(size)
                        }
                    }

                    Picker("言語", selection: $viewModel.language) {
                        ForEach(Language.allCases) { lang in
                            Text(lang.rawValue).tag(lang)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }

                // MARK: - 通知
                Section("通知") {
                    // Toggle: ON/OFFを切り替えるスイッチ
                    Toggle("通知を受け取る", isOn: $viewModel.notificationsEnabled)

                    if viewModel.notificationsEnabled {
                        Toggle("サウンド", isOn: $viewModel.soundEnabled)
                        Toggle("バイブレーション", isOn: $viewModel.hapticsEnabled)
                    }
                }

                // MARK: - セキュリティ
                Section("セキュリティ") {
                    Toggle("自動ロック", isOn: $viewModel.autoLock)
                    NavigationLink("パスワードを変更") {
                        PasswordPlaceholderView()
                    }
                }

                // MARK: - アプリ情報
                Section("アプリ情報") {
                    LabeledContent("バージョン", value: "1.0.0")
                    LabeledContent("ビルド", value: "42")
                    Link("プライバシーポリシー", destination: URL(string: "https://example.com")!)
                    Button("設定をエクスポート") {
                        showExportAlert = true
                    }
                }

                // MARK: - リセット
                Section {
                    Button("すべての設定をリセット", role: .destructive) {
                        showResetAlert = true
                    }
                }
            }
            .navigationTitle("設定")
            .preferredColorScheme(viewModel.theme.colorScheme)
            .dynamicTypeSize(viewModel.fontSize.dynamicTypeSize)
            .alert("設定をリセット", isPresented: $showResetAlert) {
                Button("リセット", role: .destructive) {
                    viewModel.resetAllSettings()
                }
                Button("キャンセル", role: .cancel) {}
            } message: {
                Text("すべての設定がデフォルトに戻ります。")
            }
            .alert("設定のエクスポート", isPresented: $showExportAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(viewModel.exportSettings())
            }
        }
    }
}

#Preview {
    SettingsView()
}
