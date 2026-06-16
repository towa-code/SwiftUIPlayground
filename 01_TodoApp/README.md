# 01 TodoApp

## 学習テーマ
- `List` — データを一覧表示する基本コンポーネント
- `NavigationStack` — 画面遷移のスタック管理
- `SwipeActions` — スワイプで操作を表示する

## 完成イメージ
- TODOリストの表示・追加・削除
- 左スワイプで削除、右スワイプで完了トグル
- タップで詳細画面へ遷移

## ファイル構成
```
01_TodoApp/
├── Models/
│   └── TodoItem.swift        # データモデル + サンプルデータ
├── ViewModels/
│   └── TodoViewModel.swift   # リスト操作ロジック
└── Views/
    ├── TodoListView.swift    # メイン画面（List + SwipeActions）
    ├── TodoRowView.swift     # 各行のUI
    ├── TodoDetailView.swift  # 詳細画面
    └── AddTodoView.swift     # 追加フォーム
```

## セットアップ
1. Xcodeで新規 SwiftUI プロジェクト作成
2. デフォルトの `ContentView.swift` を削除
3. このフォルダのSwiftファイルを全てプロジェクトに追加
4. `@main` App struct の `body` を `TodoListView()` に変更

## 学習ポイント

### List
```swift
List {
    ForEach(items) { item in
        Text(item.title)
    }
    .onDelete(perform: deleteItems)
}
```
`ForEach` + `onDelete` でスワイプ削除が自動的に有効になる。

### NavigationStack + NavigationLink
```swift
NavigationStack {
    List {
        NavigationLink(destination: DetailView()) {
            Text("タップで遷移")
        }
    }
    .navigationTitle("タイトル")
}
```

### SwipeActions
```swift
.swipeActions(edge: .trailing) {
    Button(role: .destructive) { /* 削除 */ } label: {
        Label("削除", systemImage: "trash")
    }
}
.swipeActions(edge: .leading) {
    Button { /* 完了 */ } label: {
        Label("完了", systemImage: "checkmark")
    }
    .tint(.green)
}
```
`edge:` で左右を指定。`allowsFullSwipe: true` でフルスワイプ対応。

## 発展課題
- 完了済み / 未完了でセクション分け
- 優先度フィールドの追加
- Core Data との連携
