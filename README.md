# SwiftUI 写経学習教材

SwiftUIを実践的に学ぶための10教材セット。
各教材は独立して動作し、1〜3時間で完成できる規模です。

## 使い方

1. Xcodeで **新規 SwiftUI プロジェクト** を作成
2. 各教材の Swift ファイルをプロジェクトに追加
3. 各教材の `README.md` の「セットアップ」に従い起動ポイントを設定
4. Previewで確認しながら動作を理解する

## 教材一覧

| # | 教材 | 学習テーマ |
|---|------|-----------|
| 01 | [TodoApp](01_TodoApp/) | `List` / `NavigationStack` / `SwipeActions` |
| 02 | [SettingsApp](02_SettingsApp/) | `Form` / `Toggle` / `Picker` / `AppStorage` |
| 03 | [ProfileCard](03_ProfileCard/) | `ZStack` / `overlay` / `Sheet` |
| 04 | [PhotoGallery](04_PhotoGallery/) | `ScrollView` / `LazyVGrid` / `AsyncImage` |
| 05 | [TabSNS](05_TabSNS/) | `TabView` / `NavigationStack` |
| 06 | [PostModal](06_PostModal/) | `Sheet` / `FullScreenCover` / `@Binding` |
| 07 | [HabitTracker](07_HabitTracker/) | `ObservableObject` / `@StateObject` / `ProgressView` |
| 08 | [ProductSearch](08_ProductSearch/) | `.searchable` / フィルタリング |
| 09 | [WeatherDashboard](09_WeatherDashboard/) | `EnvironmentObject` / MVVM |
| 10 | [AnimatedFavorite](10_AnimatedFavorite/) | `Animation` / `matchedGeometryEffect` |

## 推奨学習順序

初めてSwiftUIを学ぶ場合は 01 → 02 → 03 の順がおすすめ。
各教材の `README.md` に詳細な学習ポイントと発展課題があります。

## MVVM 構成（全教材共通）

```
教材名/
├── Models/         # データの形（struct）
├── ViewModels/     # ビジネスロジック（ObservableObject）
└── Views/          # 画面UI（SwiftUI View）
```
