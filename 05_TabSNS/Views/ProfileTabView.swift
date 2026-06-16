import SwiftUI

struct ProfileTabView: View {
    let user = SNSUser.currentUser

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // アバター
                Image(systemName: user.avatarIcon)
                    .font(.system(size: 72))
                    .foregroundStyle(.blue)
                    .padding(.top)

                VStack(spacing: 4) {
                    Text(user.name).font(.title2.bold())
                    Text(user.handle).font(.subheadline).foregroundStyle(.secondary)
                    Text(user.bio).font(.body).multilineTextAlignment(.center)
                        .padding(.top, 4)
                }
                .padding(.horizontal)

                // 統計
                HStack(spacing: 40) {
                    ProfileStat(value: "\(user.postsCount)", title: "投稿")
                    ProfileStat(value: "\(user.followersCount)", title: "フォロワー")
                    ProfileStat(value: "\(user.followingCount)", title: "フォロー中")
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal)

                // フォロワーサジェスチョン
                VStack(alignment: .leading, spacing: 12) {
                    Text("おすすめユーザー")
                        .font(.headline)
                        .padding(.horizontal)

                    ForEach(SNSUser.suggestions) { suggestion in
                        SuggestionRow(user: suggestion)
                            .padding(.horizontal)
                    }
                }
            }
        }
        .navigationTitle("プロフィール")
    }
}

struct ProfileStat: View {
    let value: String
    let title: String

    var body: some View {
        VStack(spacing: 4) {
            Text(value).font(.title3.bold())
            Text(title).font(.caption).foregroundStyle(.secondary)
        }
    }
}

struct SuggestionRow: View {
    let user: SNSUser
    @State private var isFollowing = false

    var body: some View {
        HStack {
            Image(systemName: user.avatarIcon)
                .font(.title2)
                .foregroundStyle(.purple)
            VStack(alignment: .leading, spacing: 2) {
                Text(user.name).font(.subheadline.bold())
                Text(user.handle).font(.caption).foregroundStyle(.secondary)
            }
            Spacer()
            Button(isFollowing ? "フォロー中" : "フォロー") {
                isFollowing.toggle()
            }
            .font(.caption.bold())
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(isFollowing ? Color(.secondarySystemBackground) : .blue)
            .foregroundStyle(isFollowing ? .primary : .white)
            .clipShape(Capsule())
        }
    }
}

#Preview {
    NavigationStack {
        ProfileTabView()
    }
}
