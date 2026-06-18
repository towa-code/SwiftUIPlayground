import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: ItemViewModel

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
                                    FavoriteRow(item: item, viewModel: viewModel)
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

#Preview {
    FavoritesView(viewModel: ItemViewModel())
}
