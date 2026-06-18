import Foundation
import Combine

/// 設定画面の状態を一元管理するViewModel。
/// UserDefaultsへの読み書きはここに集約し、Viewは@Publishedプロパティをbindingするだけにする。
class SettingsViewModel: ObservableObject {
    @Published var theme: AppTheme {
        didSet { defaults.set(theme.rawValue, forKey: Key.theme) }
    }
    @Published var fontSize: FontSize {
        didSet { defaults.set(fontSize.rawValue, forKey: Key.fontSize) }
    }
    @Published var language: Language {
        didSet { defaults.set(language.rawValue, forKey: Key.language) }
    }
    @Published var notificationsEnabled: Bool {
        didSet { defaults.set(notificationsEnabled, forKey: Key.notificationsEnabled) }
    }
    @Published var soundEnabled: Bool {
        didSet { defaults.set(soundEnabled, forKey: Key.soundEnabled) }
    }
    @Published var hapticsEnabled: Bool {
        didSet { defaults.set(hapticsEnabled, forKey: Key.hapticsEnabled) }
    }
    @Published var autoLock: Bool {
        didSet { defaults.set(autoLock, forKey: Key.autoLock) }
    }
    @Published var username: String {
        didSet { defaults.set(username, forKey: Key.username) }
    }

    private let defaults: UserDefaults

    private enum Key {
        static let theme = "app_theme"
        static let fontSize = "font_size"
        static let language = "language"
        static let notificationsEnabled = "notifications_enabled"
        static let soundEnabled = "sound_enabled"
        static let hapticsEnabled = "haptics_enabled"
        static let autoLock = "auto_lock"
        static let username = "username"
    }

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        theme = AppTheme(rawValue: defaults.string(forKey: Key.theme) ?? "") ?? .system
        fontSize = FontSize(rawValue: defaults.string(forKey: Key.fontSize) ?? "") ?? .medium
        language = Language(rawValue: defaults.string(forKey: Key.language) ?? "") ?? .japanese
        notificationsEnabled = defaults.object(forKey: Key.notificationsEnabled) as? Bool ?? true
        soundEnabled = defaults.object(forKey: Key.soundEnabled) as? Bool ?? true
        hapticsEnabled = defaults.object(forKey: Key.hapticsEnabled) as? Bool ?? true
        autoLock = defaults.object(forKey: Key.autoLock) as? Bool ?? false
        username = defaults.string(forKey: Key.username) ?? ""
    }

    /// すべての設定をデフォルト値へ戻す。@Publishedへの代入なのでUIへ即時反映される。
    func resetAllSettings() {
        theme = .system
        fontSize = .medium
        language = .japanese
        notificationsEnabled = true
        soundEnabled = true
        hapticsEnabled = true
        autoLock = false
        username = ""
    }

    func exportSettings() -> String {
        "テーマ: \(theme.rawValue), フォント: \(fontSize.rawValue)"
    }
}
