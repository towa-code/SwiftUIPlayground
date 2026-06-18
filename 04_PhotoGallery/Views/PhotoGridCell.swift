import SwiftUI

struct PhotoGridCell: View {
    let photo: Photo
    @ObservedObject var viewModel: PhotoViewModel

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // AsyncImage: URLから非同期で画像を読み込む
            AsyncImage(url: photo.imageURL) { phase in
                switch phase {
                case .empty:
                    // 読み込み中
                    Rectangle()
                        .fill(Color(.systemGray5))
                        .overlay {
                            ProgressView()
                        }
                case .success(let image):
                    // 読み込み成功
                    image
                        .resizable()
                        .scaledToFill()
                case .failure:
                    // 読み込み失敗
                    Rectangle()
                        .fill(Color(.systemGray4))
                        .overlay {
                            Image(systemName: "photo")
                                .foregroundStyle(.secondary)
                        }
                @unknown default:
                    EmptyView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .clipped()

            // いいね数オーバーレイ
            HStack(spacing: 4) {
                Image(systemName: "heart.fill")
                    .font(.footnote)
                Text(viewModel.formattedLikes(photo.likes))
                    .font(.footnote.bold())
            }
            .foregroundStyle(.white)
            .padding(6)
            .background(.black.opacity(0.4))
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .padding(6)
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

#Preview {
    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
        PhotoGridCell(photo: Photo.samples[0], viewModel: PhotoViewModel())
        PhotoGridCell(photo: Photo.samples[1], viewModel: PhotoViewModel())
    }
}
