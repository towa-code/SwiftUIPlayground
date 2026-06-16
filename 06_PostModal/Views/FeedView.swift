import SwiftUI

struct FeedView: View {
    @StateObject private var viewModel = FeedViewModel()

    // Sheet と FullScreenCover の表示状態をそれぞれ管理
    @State private var showNewPostSheet = false
    @State private var selectedPostForDetail: FeedPost? = nil

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.posts) { post in
                    FeedPostCard(post: post, viewModel: viewModel) {
                        selectedPostForDetail = post
                    }
                    .listRowInsets(EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12))
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }
                .onDelete { indexSet in
                    indexSet.forEach { i in
                        viewModel.deletePost(viewModel.posts[i])
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("フィード")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showNewPostSheet = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                    }
                }
            }
            // sheet: 下からスライドアップするモーダル
            .sheet(isPresented: $showNewPostSheet) {
                NewPostSheet(viewModel: viewModel)
            }
            // fullScreenCover: 画面全体を覆うモーダル（Bindingでアイテムを渡す）
            .fullScreenCover(item: $selectedPostForDetail) { post in
                PostDetailFullScreen(post: post, viewModel: viewModel)
            }
        }
    }
}

struct FeedPostCard: View {
    let post: FeedPost
    @ObservedObject var viewModel: FeedViewModel
    let onTapDetail: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: post.authorIcon)
                    .font(.title2)
                    .foregroundStyle(.blue)
                VStack(alignment: .leading, spacing: 2) {
                    Text(post.authorName).font(.subheadline.bold())
                    Text(post.createdAt.formatted(date: .abbreviated, time: .omitted))
                        .font(.caption).foregroundStyle(.secondary)
                }
            }

            Text(post.title).font(.headline)
            Text(post.body).font(.body).lineLimit(3).foregroundStyle(.secondary)

            HStack {
                Button {
                    viewModel.toggleLike(post)
                } label: {
                    Label("\(post.likesCount)", systemImage: post.isLiked ? "heart.fill" : "heart")
                        .foregroundStyle(post.isLiked ? .red : .secondary)
                        .font(.caption)
                }
                .buttonStyle(.plain)

                Spacer()

                // FullScreenCoverを開くボタン
                Button("全画面で見る") {
                    onTapDetail()
                }
                .font(.caption)
                .foregroundStyle(.blue)
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    FeedView()
}
