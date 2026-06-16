import SwiftUI

struct AnimatedMainView: View {
    @StateObject private var viewModel = ItemViewModel()
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            ItemGridView(viewModel: viewModel)
                .tabItem { Label("すべて", systemImage: "square.grid.2x2.fill") }
                .tag(0)

            FavoritesView(viewModel: viewModel)
                .tabItem { Label("お気に入り", systemImage: "heart.fill") }
                .badge(viewModel.favoritedItems.count)
                .tag(1)
        }
    }
}

#Preview {
    AnimatedMainView()
}
