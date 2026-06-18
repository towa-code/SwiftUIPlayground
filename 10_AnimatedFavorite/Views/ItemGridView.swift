import SwiftUI

struct ItemGridView: View {
    @ObservedObject var viewModel: ItemViewModel

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
                        ItemCell(item: item, viewModel: viewModel)
                    }
                }
                .padding()
            }
            .navigationTitle("Appleフレームワーク")
        }
    }
}

#Preview {
    ItemGridView(viewModel: ItemViewModel())
}
