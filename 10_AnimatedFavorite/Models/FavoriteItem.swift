import Foundation
import SwiftUI

struct FavoriteItem: Identifiable {
    let id: UUID
    var name: String
    var emoji: String
    var color: Color
    var isFavorited: Bool

    init(
        id: UUID = UUID(),
        name: String,
        emoji: String,
        color: Color,
        isFavorited: Bool = false
    ) {
        self.id = id
        self.name = name
        self.emoji = emoji
        self.color = color
        self.isFavorited = isFavorited
    }
}

extension FavoriteItem {
    static let samples: [FavoriteItem] = [
        FavoriteItem(name: "SwiftUI", emoji: "🍎", color: .blue, isFavorited: true),
        FavoriteItem(name: "Combine", emoji: "🔗", color: .purple),
        FavoriteItem(name: "Swift", emoji: "⚡️", color: .orange, isFavorited: true),
        FavoriteItem(name: "Xcode", emoji: "🛠", color: .cyan),
        FavoriteItem(name: "Core Data", emoji: "🗄", color: .brown),
        FavoriteItem(name: "WidgetKit", emoji: "📱", color: .green, isFavorited: true),
        FavoriteItem(name: "ARKit", emoji: "🥽", color: .indigo),
        FavoriteItem(name: "Metal", emoji: "🎮", color: .red),
        FavoriteItem(name: "CloudKit", emoji: "☁️", color: .teal),
        FavoriteItem(name: "StoreKit", emoji: "💳", color: .mint),
        FavoriteItem(name: "AVFoundation", emoji: "🎵", color: .pink),
        FavoriteItem(name: "MapKit", emoji: "🗺", color: .yellow),
    ]
}
