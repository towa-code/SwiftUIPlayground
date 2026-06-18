import SwiftUI

enum AppTheme: String, CaseIterable, Identifiable {
    case system = "システム"
    case light = "ライト"
    case dark = "ダーク"

    var id: String { rawValue }

    /// .preferredColorScheme に渡す値。systemの場合はnilでOS設定に追従させる
    var colorScheme: ColorScheme? {
        switch self {
        case .system: return nil
        case .light: return .light
        case .dark: return .dark
        }
    }
}

enum FontSize: String, CaseIterable, Identifiable {
    case small = "小"
    case medium = "中"
    case large = "大"

    var id: String { rawValue }

    /// .dynamicTypeSize に渡す値。SwiftUIは任意倍率指定ができないため段階的なサイズへマッピングする
    var dynamicTypeSize: DynamicTypeSize {
        switch self {
        case .small: return .medium
        case .medium: return .large
        case .large: return .xxxLarge
        }
    }
}

enum Language: String, CaseIterable, Identifiable {
    case japanese = "日本語"
    case english = "English"

    var id: String { rawValue }
}
