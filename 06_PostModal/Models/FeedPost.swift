import Foundation

struct FeedPost: Identifiable {
    let id: UUID
    var title: String
    var body: String
    var authorName: String
    var authorIcon: String
    var createdAt: Date
    var likesCount: Int
    var isLiked: Bool

    init(
        id: UUID = UUID(),
        title: String,
        body: String,
        authorName: String,
        authorIcon: String = "person.circle.fill",
        createdAt: Date = Date(),
        likesCount: Int = 0,
        isLiked: Bool = false
    ) {
        self.id = id
        self.title = title
        self.body = body
        self.authorName = authorName
        self.authorIcon = authorIcon
        self.createdAt = createdAt
        self.likesCount = likesCount
        self.isLiked = isLiked
    }
}

extension FeedPost {
    static let samples: [FeedPost] = [
        FeedPost(
            title: "SwiftUIのシート活用術",
            body: "`.sheet`と`.fullScreenCover`を使い分けることで、UXが大幅に向上します。シートはモーダルダイアログ的な用途に、フルスクリーンカバーは没入体験に最適です。",
            authorName: "Towa",
            authorIcon: "person.crop.circle.fill",
            createdAt: Date().addingTimeInterval(-3600),
            likesCount: 34
        ),
        FeedPost(
            title: "@Bindingで親子データを繋ぐ",
            body: "子Viewから親のデータを変更するには`@Binding`を使います。`$`プレフィックスでBindingを渡すのがポイント。",
            authorName: "Hana",
            authorIcon: "person.crop.circle.fill.badge.checkmark",
            createdAt: Date().addingTimeInterval(-7200),
            likesCount: 56
        ),
        FeedPost(
            title: "FullScreenCoverとSheet",
            body: "どちらも`isPresented: $bool`で表示を制御します。`@Environment(\\.dismiss)`でViewの中から閉じることができます。",
            authorName: "Kenji",
            authorIcon: "person.crop.circle.badge.fill",
            createdAt: Date().addingTimeInterval(-14400),
            likesCount: 89
        ),
    ]
}
