import SwiftUI

struct SettingsView: View {
    // AppStorage: UserDefaultsと自動同期するプロパティラッパー
    @AppStorage("app_theme") private var appTheme: String = AppTheme.system.rawValue
    @AppStorage("font_size") private var fontSize: String = FontSize.medium.rawValue
    @AppStorage("language") private var language: String = Language.japanese.rawValue
    @AppStorage("notifications_enabled") private var notificationsEnabled: Bool = true
    @AppStorage("sound_enabled") private var soundEnabled: Bool = true
    @AppStorage("haptics_enabled") private var hapticsEnabled: Bool = true
    @AppStorage("auto_lock") private var autoLock: Bool = false
    @AppStorage("username") private var username: String = ""

    @StateObject private var viewModel = SettingsViewModel()
    @State private var showResetAlert = false

    var body: some View {
        NavigationStack {
            Form {
                // MARK: - アカウント
                Section("アカウント") {
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.blue)
                        VStack(alignment: .leading) {
                            TextField("ユーザー名", text: $username)
                                .font(.headline)
                            Text("プロフィールを編集")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(.vertical, 4)
                }

                // MARK: - 外観
                Section("外観") {
                    // Picker: 複数の選択肢から1つを選ぶ
                    Picker("テーマ", selection: $appTheme) {
                        ForEach(AppTheme.allCases) { theme in
                            Text(theme.rawValue).tag(theme.rawValue)
                        }
                    }

                    Picker("フォントサイズ", selection: $fontSize) {
                        ForEach(FontSize.allCases) { size in
                            Text(size.rawValue).tag(size.rawValue)
                        }
                    }

                    Picker("言語", selection: $language) {
                        ForEach(Language.allCases) { lang in
                            Text(lang.rawValue).tag(lang.rawValue)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }

                // MARK: - 通知
                Section("通知") {
                    // Toggle: ON/OFFを切り替えるスイッチ
                    Toggle("通知を受け取る", isOn: $notificationsEnabled)

                    if notificationsEnabled {
                        Toggle("サウンド", isOn: $soundEnabled)
                        Toggle("バイブレーション", isOn: $hapticsEnabled)
                    }
                }

                // MARK: - セキュリティ
                Section("セキュリティ") {
                    Toggle("自動ロック", isOn: $autoLock)
                    NavigationLink("パスワードを変更") {
                        PasswordPlaceholderView()
                    }
                }

                // MARK: - アプリ情報
                Section("アプリ情報") {
                    LabeledContent("バージョン", value: "1.0.0")
                    LabeledContent("ビルド", value: "42")
                    Link("プライバシーポリシー", destination: URL(string: "https://example.com")!)
                }

                // MARK: - リセット
                Section {
                    Button("すべての設定をリセット", role: .destructive) {
                        showResetAlert = true
                    }
                }
            }
            .navigationTitle("設定")
            .alert("設定をリセット", isPresented: $showResetAlert) {
                Button("リセット", role: .destructive) {
                    viewModel.resetAllSettings()
                }
                Button("キャンセル", role: .cancel) {}
            } message: {
                Text("すべての設定がデフォルトに戻ります。")
            }
        }
    }
}

struct PasswordPlaceholderView: View {
    var body: some View {
        Text("パスワード変更画面")
            .navigationTitle("パスワード変更")
    }
}

#Preview {
    SettingsView()
}
