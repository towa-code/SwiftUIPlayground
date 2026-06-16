import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var posts: [Post] = Post.samples

    func toggleLike(_ post: Post) {
        guard let index = posts.firstIndex(where: { $0.id == post.id }) else { return }
        posts[index].isLiked.toggle()
        posts[index].likesCount += posts[index].isLiked ? 1 : -1
    }

    func addPost(content: String) {
        let newPost = Post(
            authorName: SNSUser.currentUser.name,
            authorHandle: SNSUser.currentUser.handle,
            authorAvatarIcon: SNSUser.currentUser.avatarIcon,
            content: content,
            likesCount: 0
        )
        posts.insert(newPost, at: 0)
    }

    func timeAgo(_ date: Date) -> String {
        let seconds = Int(Date().timeIntervalSince(date))
        if seconds < 60 { return "たった今" }
        if seconds < 3600 { return "\(seconds / 60)分前" }
        if seconds < 86400 { return "\(seconds / 3600)時間前" }
        return "\(seconds / 86400)日前"
    }
}
