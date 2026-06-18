import SwiftUI

struct ItemCell: View {
    let item: FavoriteItem
    @ObservedObject var viewModel: ItemViewModel

    // 弾むアニメーションの発火タイミングはVMが管理する（toggleFavoriteWithBounce）。
    // Viewはその状態を見て見た目（scaleEffect）を反映するだけ。
    private var isBouncing: Bool {
        viewModel.bouncingItemID == item.id
    }

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
                            .scaleEffect(isBouncing ? 1.2 : 1.0)
                    }

                // ハートボタン（右上オーバーレイ）
                Button {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                        viewModel.toggleFavoriteWithBounce(item)
                    }
                } label: {
                    Image(systemName: item.isFavorited ? "heart.fill" : "heart")
                        .font(.title3)
                        .foregroundStyle(item.isFavorited ? .red : .secondary)
                        .padding(6)
                        .background(.regularMaterial, in: Circle())
                }
                .padding(6)
            }

            Text(item.name)
                .font(.subheadline.bold())
                .foregroundStyle(.primary)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
        .padding(8)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}

#Preview {
    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
        ItemCell(item: FavoriteItem.samples[0], viewModel: ItemViewModel())
        ItemCell(item: FavoriteItem.samples[1], viewModel: ItemViewModel())
    }
    .padding()
}
