import Foundation

struct Photo: Identifiable {
    let id: UUID
    let title: String
    let category: PhotoCategory
    let imageURL: URL
    let likes: Int
    let author: String

    init(
        id: UUID = UUID(),
        title: String,
        category: PhotoCategory,
        imageURLString: String,
        likes: Int = 0,
        author: String = ""
    ) {
        self.id = id
        self.title = title
        self.category = category
        self.imageURL = URL(string: imageURLString)!
        self.likes = likes
        self.author = author
    }
}

enum PhotoCategory: String, CaseIterable, Identifiable {
    case all = "すべて"
    case nature = "自然"
    case city = "都市"
    case food = "食べ物"
    case travel = "旅行"

    var id: String { rawValue }
}

extension Photo {
    // Picsum Photos API を使ったサンプルデータ（実際のURLから画像取得）
    static let samples: [Photo] = [
        Photo(title: "山の夕暮れ", category: .nature, imageURLString: "https://picsum.photos/seed/mtn1/400/400", likes: 234, author: "Towa"),
        Photo(title: "森の朝霧", category: .nature, imageURLString: "https://picsum.photos/seed/forest/400/400", likes: 189, author: "Hana"),
        Photo(title: "夜の渋谷", category: .city, imageURLString: "https://picsum.photos/seed/city1/400/400", likes: 512, author: "Kenji"),
        Photo(title: "東京タワー", category: .city, imageURLString: "https://picsum.photos/seed/tower/400/400", likes: 801, author: "Yuki"),
        Photo(title: "ラーメン", category: .food, imageURLString: "https://picsum.photos/seed/ramen/400/400", likes: 671, author: "Sato"),
        Photo(title: "抹茶パフェ", category: .food, imageURLString: "https://picsum.photos/seed/matcha/400/400", likes: 445, author: "Aoi"),
        Photo(title: "京都の神社", category: .travel, imageURLString: "https://picsum.photos/seed/kyoto/400/400", likes: 923, author: "Ryo"),
        Photo(title: "沖縄の海", category: .travel, imageURLString: "https://picsum.photos/seed/okinawa/400/400", likes: 1102, author: "Miku"),
        Photo(title: "富士山", category: .nature, imageURLString: "https://picsum.photos/seed/fuji/400/400", likes: 2041, author: "Towa"),
        Photo(title: "大阪の夜景", category: .city, imageURLString: "https://picsum.photos/seed/osaka/400/400", likes: 387, author: "Hana"),
        Photo(title: "寿司", category: .food, imageURLString: "https://picsum.photos/seed/sushi/400/400", likes: 560, author: "Kenji"),
        Photo(title: "北海道の雪景色", category: .travel, imageURLString: "https://picsum.photos/seed/hokkaido/400/400", likes: 778, author: "Yuki"),
    ]
}
