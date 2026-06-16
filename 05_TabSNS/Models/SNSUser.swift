import Foundation

struct SNSUser: Identifiable {
    let id: UUID
    var name: String
    var handle: String
    var bio: String
    var avatarIcon: String
    var postsCount: Int
    var followersCount: Int
    var followingCount: Int

    init(
        id: UUID = UUID(),
        name: String,
        handle: String,
        bio: String = "",
        avatarIcon: String = "person.circle.fill",
        postsCount: Int = 0,
        followersCount: Int = 0,
        followingCount: Int = 0
    ) {
        self.id = id
        self.name = name
        self.handle = handle
        self.bio = bio
        self.avatarIcon = avatarIcon
        self.postsCount = postsCount
        self.followersCount = followersCount
        self.followingCount = followingCount
    }
}

extension SNSUser {
    static let currentUser = SNSUser(
        name: "Towa Yamamoto",
        handle: "@towa_dev",
        bio: "iOSエンジニア / SwiftUI学習中 🍎",
        avatarIcon: "person.crop.circle.fill",
        postsCount: 42,
        followersCount: 312,
        followingCount: 87
    )

    static let suggestions: [SNSUser] = [
        SNSUser(name: "Hana Tanaka", handle: "@hana_design", bio: "UIデザイナー", avatarIcon: "person.crop.circle.fill.badge.checkmark", followersCount: 1200),
        SNSUser(name: "Kenji Suzuki", handle: "@kenji_backend", bio: "Swift Server-Side", avatarIcon: "person.crop.circle.badge.fill", followersCount: 890),
        SNSUser(name: "Yuki Kobayashi", handle: "@yuki_ios", bio: "iOS Dev", avatarIcon: "person.circle.fill", followersCount: 2100),
    ]
}
