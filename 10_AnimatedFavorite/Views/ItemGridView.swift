import SwiftUI

struct ItemGridView: View {
    @ObservedObject var viewModel: ItemViewModel
    // matchedGeometryEffect に必要な namespace
    @Namespace private var animation

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(viewModel.items) { item in
                        ItemCell(
                            item: item,
                            namespace: animation
                        ) {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                                viewModel.toggleFavorite(item)
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Appleフレームワーク")
        }
    }
}

struct ItemCell: View {
    let item: FavoriteItem
    let namespace: Namespace.ID
    let onToggle: () -> Void

    // ハート弾むアニメーション用
    @State private var isAnimating = false

    var body: some View {
        VStack(spacing: 8) {
            ZStack(alignment: .topTrailing) {
                // アイテム背景
                RoundedRectangle(cornerRadius: 16)
                    .fill(item.color.opacity(0.15))
                    .frame(height: 90)
                    .overlay {
                        Text(item.emoji)
                            .font(.system(size: 40))
                            // .scaleEffect でハートタップ時にアイテムが弾む
                            .scaleEffect(isAnimating ? 1.2 : 1.0)
                    }

                // ハートボタン（右上オーバーレイ）
                Button(action: {
                    onToggle()
                    // アニメーションシーケンス: 拡大 → 縮小
                    withAnimation(.spring(response: 0.2, dampingFraction: 0.4)) {
                        isAnimating = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation(.spring(response: 0.3)) {
                            isAnimating = false
                        }
                    }
                }) {
                    // matchedGeometryEffect: 同じIDのViewが別の場所に移動する時にアニメーション
                    Image(systemName: item.isFavorited ? "heart.fill" : "heart")
                        .font(.subheadline)
                        .foregroundStyle(item.isFavorited ? .red : .secondary)
                        .padding(6)
                        .background(.regularMaterial, in: Circle())
                        // matchedGeometryEffect: このViewがFavoritesViewの同IDのViewと対応する
                        .matchedGeometryEffect(id: "heart-\(item.id)", in: namespace)
                }
                .padding(6)
            }

            Text(item.name)
                .font(.caption.bold())
                .foregroundStyle(.primary)
                .lineLimit(1)
        }
    }
}

#Preview {
    ItemGridView(viewModel: ItemViewModel())
}
