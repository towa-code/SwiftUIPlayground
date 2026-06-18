import Foundation
import Combine

class ItemViewModel: ObservableObject {
    @Published var items: [FavoriteItem] = FavoriteItem.samples

    // グリッド側でハートをタップした瞬間に弾むアイテムのID。
    // 弾むアニメーションのタイミング（いつ始まり、いつ終わるか）はVMが一元管理する。
    @Published var bouncingItemID: UUID? = nil

    var favoritedItems: [FavoriteItem] {
        items.filter(\.isFavorited)
    }

    func toggleFavorite(_ item: FavoriteItem) {
        guard let index = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[index].isFavorited.toggle()
    }

    // グリッドでハートをタップした時: お気に入り状態を切り替えつつ弾むアニメーションを発火
    func toggleFavoriteWithBounce(_ item: FavoriteItem) {
        toggleFavorite(item)
        bouncingItemID = item.id
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            if self?.bouncingItemID == item.id {
                self?.bouncingItemID = nil
            }
        }
    }

    // お気に入りリストでハートをタップした時: 縮小アニメーション分だけ遅らせて実際に削除する
    func removeFavoriteAfterShrink(_ item: FavoriteItem, delay: TimeInterval = 0.25) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            self?.toggleFavorite(item)
        }
    }
}
