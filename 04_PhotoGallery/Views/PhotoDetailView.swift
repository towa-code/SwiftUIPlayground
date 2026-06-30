import SwiftUI

struct PhotoDetailView: View {
    let photo: Photo

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // 大きな画像表示
                AsyncImage(url: photo.imageURL) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                    default:
                        Color.gray.opacity(0.3)
                            .frame(height: 300)
                            .overlay { ProgressView() }
                    }
                }

                VStack(alignment: .leading, spacing: 12) {
                    Text(photo.title)
                        .font(.title2.bold())

                    HStack {
                        Label(photo.category.rawValue, systemImage: "tag.fill")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Spacer()
                        Label(photo.formattedLikes, systemImage: "heart.fill")
                            .font(.subheadline)
                            .foregroundStyle(.pink)
                    }

                    Label("撮影: \(photo.author)", systemImage: "camera.fill")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(.horizontal)
        }
        .navigationTitle(photo.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        PhotoDetailView(photo: Photo.samples[0])
    }
}
