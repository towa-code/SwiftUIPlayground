# 02 SettingsApp

## 学習テーマ
- `Form` — 設定画面に最適な縦スクロールフォームUI
- `Toggle` — ON/OFFスイッチ
- `Picker` — 複数選択肢からの選択
- `AppStorage` — UserDefaultsとの自動同期

## 完成イメージ
- アカウント / 外観 / 通知 / セキュリティのセクション分け設定画面
- 設定値がアプリ再起動後も保持される
- トグルのON/OFFで関連項目を動的に表示/非表示

## ファイル構成
```
02_SettingsApp/
├── Models/
│   └── AppTheme.swift          # テーマ・フォントサイズ等の列挙型
├── ViewModels/
│   └── SettingsViewModel.swift # リセット等のビジネスロジック
└── Views/
    └── SettingsView.swift      # メイン設定画面
```

## セットアップ
1. Xcodeで新規 SwiftUI プロジェクト作成
2. このフォルダのSwiftファイルをプロジェクトに追加
3. `ContentView` の body を `SettingsView()` に変更

## 学習ポイント

### AppStorage
```swift
@AppStorage("notifications_enabled") private var notificationsEnabled: Bool = true
```
`UserDefaults.standard` と自動的に同期。キー名の文字列で管理する。
アプリを再起動しても値が保持される。

### Form + Section
```swift
Form {
    Section("セクション名") {
        // 行を追加
        Toggle("設定項目", isOn: $binding)
        Picker("選択", selection: $binding) { ... }
    }
}
```

### Picker のスタイル
```swift
Picker("選択", selection: $value) { ... }
    .pickerStyle(.segmented)   // セグメントコントロール
    .pickerStyle(.menu)        // ドロップダウン（デフォルト）
    .pickerStyle(.navigationLink) // 別画面で選択
    .pickerStyle(.wheel)       // スクロールホイール
```

### 条件付き表示
```swift
Toggle("通知", isOn: $notificationsEnabled)
if notificationsEnabled {
    Toggle("サウンド", isOn: $soundEnabled)  // 通知ONの時だけ表示
}
```

## 発展課題
- `@Environment(\.colorScheme)` でテーマを実際に反映
- iCloud同期 (`NSUbiquitousKeyValueStore`)
- カスタムPickerスタイル
