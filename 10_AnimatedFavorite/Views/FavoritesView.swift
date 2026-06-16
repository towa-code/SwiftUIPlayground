import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: ItemViewModel
    @Namespace private var animation

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.favoritedItems.isEmpty {
                    ContentUnavailableView(
                        "お気に入りなし",
                        systemImage: "heart.slash",
                        description: Text("グリッドでハートをタップして追加しましょう")
                    )
                } else {
                    ScrollView {
                        VStack(spacing: 0) {
                            // お気に入りカウントバナー
                            HStack {
                                Text("\(viewModel.favoritedItems.count) 件のお気に入り")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                Spacer()
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 8)

                            // お気に入りリスト
                            LazyVStack(spacing: 12) {
                                ForEach(viewModel.favoritedItems) { item in
                                    FavoriteRow(
                                        item: item,
                                        namespace: animation
                                    ) {
                                        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                                            viewModel.toggleFavorite(item)
                                        }
                                    }
                                    // .transition: Viewが追加/削除される際のアニメーション
                                    .transition(.asymmetric(
                                        insertion: .move(edge: .trailing).combined(with: .opacity),
                                        removal: .move(edge: .leading).combined(with: .opacity)
                                    ))
                                }
                            }
                            .padding()
                        }
                        // .animation: @Publishedの変化を自動的にアニメーション
                        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: viewModel.favoritedItems.map(\.id))
                    }
                }
            }
            .navigationTitle("お気に入り")
        }
    }
}

struct FavoriteRow: View {
    let item: FavoriteItem
    let namespace: Namespace.ID
    let onRemove: () -> Void

    // ハート拡大アニメーション状態
    @State private var heartScale: CGFloat = 1.0

    var body: some View {
        HStack(spacing: 16) {
            // アイコン
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(item.color.opacity(0.15))
                    .frame(width: 56, height: 56)
                Text(item.emoji)
                    .font(.title2)
            }

            Text(item.name)
                .font(.headline)

            Spacer()

            // 削除ボタン（ハートをタップで解除）
            Button(action: {
                // スプリングアニメーションで縮小後に状態変更
                withAnimation(.spring(response: 0.2, dampingFraction: 0.4)) {
                    heartScale = 1.4
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                    withAnimation(.spring(response: 0.3)) {
                        heartScale = 0.0
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    onRemove()
                    heartScale = 1.0
                }
            }) {
                Image(systemName: "heart.fill")
                    .font(.title2)
                    .foregroundStyle(.red)
                    .scaleEffect(heartScale)
                    // matchedGeometryEffect: グリッドのハートと同じIDで対応付け
                    .matchedGeometryEffect(id: "heart-\(item.id)", in: namespace)
            }
        }
        .padding(12)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    FavoritesView(viewModel: ItemViewModel())
}
