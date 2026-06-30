import SwiftUI

struct PhotoGalleryView: View {
    @StateObject private var viewModel = PhotoViewModel()

    // グリッドの列定義: 2列、間隔2pt
    private let columns = [
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2),
    ]

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // カテゴリフィルター
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(PhotoCategory.allCases) { category in
                            CategoryChip(
                                title: category.rawValue,
                                isSelected: viewModel.selectedCategory == category
                            ) {
                                viewModel.selectedCategory = category
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                }

                // ScrollView + LazyVGrid でフォトグリッド
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 2) {
                        ForEach(viewModel.filteredPhotos) { photo in
                            NavigationLink(destination: PhotoDetailView(photo: photo)) {
                                PhotoGridCell(photo: photo)
                            }
                        }
                    }
                }
            }
            .navigationTitle("フォトギャラリー")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    PhotoGalleryView()
}
