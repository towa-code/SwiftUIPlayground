import SwiftUI

struct PhotoGridCell: View {
    let photo: Photo

    var body: some View {
        AsyncImage(url: photo.imageURL) { phase in
            switch phase {
            case .success(let image):
                // 読み込み成功
                image
                    .resizable()
                    .aspectRatio(1, contentMode: .fill)
                    .clipped()
            default:
                // 読み込み中・失敗
                Color.gray.opacity(0.3)
                    .aspectRatio(1, contentMode: .fit)
                    .overlay { ProgressView() }
            }
        }
        // いいね数オーバーレイ
        .overlay(alignment: .bottomLeading) {
            HStack(spacing: 4) {
                Image(systemName: "heart.fill")
                    .font(.footnote)
                Text(photo.formattedLikes)
                    .font(.footnote.bold())
            }
            .foregroundStyle(.white)
            .padding(6)
            .background(.black.opacity(0.4))
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .padding(6)
        }
    }
}

#Preview {
    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
        PhotoGridCell(photo: Photo.samples[0])
        PhotoGridCell(photo: Photo.samples[1])
    }
}
