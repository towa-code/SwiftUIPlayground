import Foundation
import Combine

class FeedViewModel: ObservableObject {
    @Published var posts: [FeedPost] = FeedPost.samples

    func toggleLike(_ post: FeedPost) {
        guard let index = posts.firstIndex(where: { $0.id == post.id }) else { return }
        posts[index].isLiked.toggle()
        posts[index].likesCount += posts[index].isLiked ? 1 : -1
    }

    func addPost(title: String, body: String) {
        let post = FeedPost(
            title: title,
            body: body,
            authorName: "自分",
            authorIcon: "person.crop.circle.fill"
        )
        posts.insert(post, at: 0)
    }

    func deletePost(_ post: FeedPost) {
        posts.removeAll { $0.id == post.id }
    }
}
