import Foundation
import SwiftUI

struct Profile: Identifiable {
    let id: UUID
    var name: String
    var handle: String
    var bio: String
    var location: String
    var website: String
    var followersCount: Int
    var followingCount: Int
    var postsCount: Int
    var accentColor: Color
    var avatarSystemImage: String

    init(
        id: UUID = UUID(),
        name: String,
        handle: String,
        bio: String,
        location: String = "",
        website: String = "",
        followersCount: Int = 0,
        followingCount: Int = 0,
        postsCount: Int = 0,
        accentColor: Color = .blue,
        avatarSystemImage: String = "person.circle.fill"
    ) {
        self.id = id
        self.name = name
        self.handle = handle
        self.bio = bio
        self.location = location
        self.website = website
        self.followersCount = followersCount
        self.followingCount = followingCount
        self.postsCount = postsCount
        self.accentColor = accentColor
        self.avatarSystemImage = avatarSystemImage
    }
}

extension Profile {
    static let sample = Profile(
        name: "Towa Yamamoto",
        handle: "@towa_dev",
        bio: "iOSエンジニア / SwiftUI愛好家 🍎\nオープンソース活動中",
        location: "Tokyo, Japan",
        website: "https://example.com",
        followersCount: 1_204,
        followingCount: 387,
        postsCount: 82,
        accentColor: .purple,
        avatarSystemImage: "person.crop.circle.fill"
    )

    static let samples: [Profile] = [
        sample,
        Profile(
            name: "Hana Tanaka",
            handle: "@hana_design",
            bio: "UIデザイナー & SwiftUI修行中 ✏️",
            location: "Osaka, Japan",
            followersCount: 543,
            followingCount: 210,
            postsCount: 34,
            accentColor: .pink,
            avatarSystemImage: "person.crop.circle.fill.badge.checkmark"
        ),
        Profile(
            name: "Kenji Suzuki",
            handle: "@kenji_backend",
            bio: "バックエンドエンジニア | Swift Server-Side",
            location: "Fukuoka, Japan",
            followersCount: 2_891,
            followingCount: 150,
            postsCount: 195,
            accentColor: .green,
            avatarSystemImage: "person.crop.circle.badge.fill"
        ),
    ]
}
