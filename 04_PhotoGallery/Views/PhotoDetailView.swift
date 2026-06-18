import SwiftUI

struct PhotoDetailView: View {
    let photo: Photo
    @ObservedObject var viewModel: PhotoViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // 大きな画像表示
                AsyncImage(url: photo.imageURL) { phase in
                    switch phase {
                    case .empty:
                        Rectangle()
                            .fill(Color(.systemGray5))
                            .frame(height: 300)
                            .overlay { ProgressView() }
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                    case .failure:
                        Rectangle()
                            .fill(Color(.systemGray4))
                            .frame(height: 300)
                            .overlay {
                                Image(systemName: "photo")
                                    .font(.largeTitle)
                                    .foregroundStyle(.secondary)
                            }
                    @unknown default:
                        EmptyView()
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
                        Label(viewModel.formattedLikes(photo.likes), systemImage: "heart.fill")
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
        PhotoDetailView(photo: Photo.samples[0], viewModel: PhotoViewModel())
    }
}
