import SwiftUI

struct PostDetailFullScreen: View {
    let post: FeedPost
    @ObservedObject var viewModel: FeedViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // 著者
                    HStack(spacing: 12) {
                        Image(systemName: post.authorIcon)
                            .font(.system(size: 48))
                            .foregroundStyle(.blue)
                        VStack(alignment: .leading) {
                            Text(post.authorName)
                                .font(.title3.bold())
                            Text(post.createdAt.formatted(date: .long, time: .shortened))
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }

                    Divider()

                    // タイトル
                    Text(post.title)
                        .font(.title.bold())

                    // 本文（全文表示）
                    Text(post.body)
                        .font(.body)
                        .lineSpacing(6)

                    Divider()

                    // いいね
                    HStack {
                        Button {
                            viewModel.toggleLike(post)
                        } label: {
                            HStack(spacing: 8) {
                                Image(systemName: post.isLiked ? "heart.fill" : "heart")
                                    .font(.title2)
                                    .foregroundStyle(post.isLiked ? .red : .secondary)
                                Text("\(post.likesCount) いいね")
                                    .font(.headline)
                                    .foregroundStyle(post.isLiked ? .red : .secondary)
                            }
                        }
                        .buttonStyle(.plain)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 12))

                        Spacer()
                    }
                }
                .padding(20)
            }
            .navigationTitle("投稿詳細")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // fullScreenCoverでも @Environment(\.dismiss) で閉じられる
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.secondary)
                            .font(.title3)
                    }
                }
            }
        }
    }
}

#Preview {
    PostDetailFullScreen(post: FeedPost.samples[0], viewModel: FeedViewModel())
}
