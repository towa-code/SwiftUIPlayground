import Foundation

struct Post: Identifiable {
    let id: UUID
    let authorName: String
    let authorHandle: String
    let authorAvatarIcon: String
    let content: String
    let timestamp: Date
    var likesCount: Int
    var isLiked: Bool
    var commentsCount: Int
    let imageName: String?

    init(
        id: UUID = UUID(),
        authorName: String,
        authorHandle: String,
        authorAvatarIcon: String = "person.circle.fill",
        content: String,
        timestamp: Date = Date(),
        likesCount: Int = 0,
        isLiked: Bool = false,
        commentsCount: Int = 0,
        imageName: String? = nil
    ) {
        self.id = id
        self.authorName = authorName
        self.authorHandle = authorHandle
        self.authorAvatarIcon = authorAvatarIcon
        self.content = content
        self.timestamp = timestamp
        self.likesCount = likesCount
        self.isLiked = isLiked
        self.commentsCount = commentsCount
        self.imageName = imageName
    }
}

extension Post {
    static let samples: [Post] = [
        Post(
            authorName: "Towa Yamamoto",
            authorHandle: "@towa_dev",
            authorAvatarIcon: "person.crop.circle.fill",
            content: "SwiftUIのTabViewを学習中！NavigationStackとの組み合わせが面白い 🍎",
            timestamp: Date().addingTimeInterval(-3600),
            likesCount: 42,
            commentsCount: 7
        ),
        Post(
            authorName: "Hana Tanaka",
            authorHandle: "@hana_design",
            authorAvatarIcon: "person.crop.circle.fill.badge.checkmark",
            content: "UIデザインとコードの橋渡しが楽しくなってきた。SwiftUIのPreviewが最高 ✨",
            timestamp: Date().addingTimeInterval(-7200),
            likesCount: 128,
            commentsCount: 23
        ),
        Post(
            authorName: "Kenji Suzuki",
            authorHandle: "@kenji_backend",
            authorAvatarIcon: "person.crop.circle.badge.fill",
            content: "Swift Concurrencyとasync/awaitで非同期処理がスッキリした。おすすめ！",
            timestamp: Date().addingTimeInterval(-14400),
            likesCount: 89,
            commentsCount: 12
        ),
        Post(
            authorName: "Yuki Kobayashi",
            authorHandle: "@yuki_ios",
            authorAvatarIcon: "person.circle.fill",
            content: "Core Dataより SwiftData の方が直感的だと感じる今日この頃。みんなはどう？",
            timestamp: Date().addingTimeInterval(-86400),
            likesCount: 201,
            commentsCount: 45
        ),
    ]
}
