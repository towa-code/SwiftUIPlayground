import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State private var showNewPost = false

    var body: some View {
        List(viewModel.posts) { post in
            NavigationLink(destination: PostDetailView(post: post, viewModel: viewModel)) {
                PostRowView(post: post, viewModel: viewModel)
            }
            .listRowInsets(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .navigationTitle("ホーム")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showNewPost = true
                } label: {
                    Image(systemName: "square.and.pencil")
                }
            }
        }
        .sheet(isPresented: $showNewPost) {
            NewPostView(viewModel: viewModel)
        }
    }
}

struct PostRowView: View {
    let post: Post
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: post.authorAvatarIcon)
                .font(.title)
                .foregroundStyle(.blue)

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(post.authorName).font(.subheadline.bold())
                    Text(post.authorHandle).font(.caption).foregroundStyle(.secondary)
                    Spacer()
                    Text(viewModel.timeAgo(post.timestamp)).font(.caption).foregroundStyle(.secondary)
                }

                Text(post.content)
                    .font(.body)
                    .fixedSize(horizontal: false, vertical: true)

                HStack(spacing: 24) {
                    Button {
                        viewModel.toggleLike(post)
                    } label: {
                        Label("\(post.likesCount)", systemImage: post.isLiked ? "heart.fill" : "heart")
                            .foregroundStyle(post.isLiked ? .red : .secondary)
                    }
                    .buttonStyle(.plain)

                    Label("\(post.commentsCount)", systemImage: "bubble.left")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .font(.caption)
                .padding(.top, 4)
            }
        }
        .padding(12)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct NewPostView: View {
    @ObservedObject var viewModel: HomeViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var content = ""

    var body: some View {
        NavigationStack {
            TextEditor(text: $content)
                .padding()
                .navigationTitle("新規投稿")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("キャンセル") { dismiss() }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("投稿") {
                            viewModel.addPost(content: content)
                            dismiss()
                        }
                        .bold()
                        .disabled(content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    }
                }
        }
    }
}

struct PostDetailView: View {
    let post: Post
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 12) {
                    Image(systemName: post.authorAvatarIcon)
                        .font(.title)
                        .foregroundStyle(.blue)
                    VStack(alignment: .leading) {
                        Text(post.authorName).font(.headline)
                        Text(post.authorHandle).font(.subheadline).foregroundStyle(.secondary)
                    }
                }

                Text(post.content)
                    .font(.body)

                Text(post.timestamp.formatted(date: .long, time: .shortened))
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Divider()

                HStack(spacing: 24) {
                    Button {
                        viewModel.toggleLike(post)
                    } label: {
                        Label("\(post.likesCount) いいね", systemImage: post.isLiked ? "heart.fill" : "heart")
                            .foregroundStyle(post.isLiked ? .red : .secondary)
                    }
                    Label("\(post.commentsCount) コメント", systemImage: "bubble.left")
                        .foregroundStyle(.secondary)
                }
            }
            .padding()
        }
        .navigationTitle("投稿詳細")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        HomeView(viewModel: HomeViewModel())
    }
}
