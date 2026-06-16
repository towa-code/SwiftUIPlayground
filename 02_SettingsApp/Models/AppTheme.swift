import Foundation

enum AppTheme: String, CaseIterable, Identifiable {
    case system = "システム"
    case light = "ライト"
    case dark = "ダーク"

    var id: String { rawValue }
}

enum FontSize: String, CaseIterable, Identifiable {
    case small = "小"
    case medium = "中"
    case large = "大"

    var id: String { rawValue }

    var scaleFactor: CGFloat {
        switch self {
        case .small: return 0.85
        case .medium: return 1.0
        case .large: return 1.2
        }
    }
}

enum Language: String, CaseIterable, Identifiable {
    case japanese = "日本語"
    case english = "English"

    var id: String { rawValue }
}
