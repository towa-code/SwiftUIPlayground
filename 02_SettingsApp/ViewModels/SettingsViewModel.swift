import Foundation
import SwiftUI

class SettingsViewModel: ObservableObject {
    // AppStorageはViewのプロパティラッパーだが、ViewModelから UserDefaults を直接操作することもできる
    // ここではロジック部分のみ担当

    func resetAllSettings() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "app_theme")
        defaults.removeObject(forKey: "font_size")
        defaults.removeObject(forKey: "language")
        defaults.removeObject(forKey: "notifications_enabled")
        defaults.removeObject(forKey: "sound_enabled")
        defaults.removeObject(forKey: "haptics_enabled")
        defaults.removeObject(forKey: "auto_lock")
        defaults.removeObject(forKey: "username")
    }

    func exportSettings() -> String {
        let theme = UserDefaults.standard.string(forKey: "app_theme") ?? "システム"
        let font = UserDefaults.standard.string(forKey: "font_size") ?? "中"
        return "テーマ: \(theme), フォント: \(font)"
    }
}
