import Foundation
import Combine

class ItemViewModel: ObservableObject {
    @Published var items: [FavoriteItem] = FavoriteItem.samples

    var favoritedItems: [FavoriteItem] {
        items.filter(\.isFavorited)
    }

    func toggleFavorite(_ item: FavoriteItem) {
        guard let index = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[index].isFavorited.toggle()
    }
}
