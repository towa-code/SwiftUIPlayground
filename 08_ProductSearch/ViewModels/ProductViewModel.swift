import Foundation
import Combine

enum SortOrder: String, CaseIterable, Identifiable {
    case nameAsc = "名前順（昇順）"
    case priceAsc = "価格順（安い順）"
    case priceDesc = "価格順（高い順）"
    case ratingDesc = "評価順"

    var id: String { rawValue }
}

class ProductViewModel: ObservableObject {
    @Published var allProducts: [Product] = Product.samples
    @Published var searchText: String = ""
    @Published var selectedCategory: ProductCategory = .all
    @Published var sortOrder: SortOrder = .nameAsc
    @Published var showFavoritesOnly: Bool = false

    // searchText / selectedCategory / sortOrder が変わると自動的に再計算
    var filteredProducts: [Product] {
        var result = allProducts

        // カテゴリフィルター
        if selectedCategory != .all {
            result = result.filter { $0.category == selectedCategory }
        }

        // お気に入りフィルター
        if showFavoritesOnly {
            result = result.filter(\.isFavorite)
        }

        // テキスト検索（名前・ブランドに部分一致）
        if !searchText.isEmpty {
            result = result.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.brand.localizedCaseInsensitiveContains(searchText)
            }
        }

        // ソート
        switch sortOrder {
        case .nameAsc:
            result.sort { $0.name < $1.name }
        case .priceAsc:
            result.sort { $0.price < $1.price }
        case .priceDesc:
            result.sort { $0.price > $1.price }
        case .ratingDesc:
            result.sort { $0.rating > $1.rating }
        }

        return result
    }

    func toggleFavorite(_ product: Product) {
        guard let index = allProducts.firstIndex(where: { $0.id == product.id }) else { return }
        allProducts[index].isFavorite.toggle()
    }

    func starsString(for rating: Double) -> String {
        let filled = Int(rating)
        return String(repeating: "★", count: filled) + String(repeating: "☆", count: 5 - filled)
    }
}
