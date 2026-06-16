import SwiftUI

struct ExploreView: View {
    let trendingTopics = ["#SwiftUI", "#iOS開発", "#Swift", "#Xcode", "#WWDC", "#CoreData", "#SwiftData", "#UIKit"]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("トレンドトピック")
                    .font(.headline)
                    .padding(.horizontal)

                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                    ForEach(trendingTopics, id: \.self) { topic in
                        Text(topic)
                            .font(.subheadline.bold())
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue.opacity(0.1))
                            .foregroundStyle(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                .padding(.horizontal)

                Text("おすすめユーザー")
                    .font(.headline)
                    .padding(.horizontal)

                ForEach(SNSUser.suggestions) { user in
                    HStack(spacing: 12) {
                        Image(systemName: user.avatarIcon)
                            .font(.title2)
                            .foregroundStyle(.purple)
                        VStack(alignment: .leading) {
                            Text(user.name).font(.subheadline.bold())
                            Text(user.bio).font(.caption).foregroundStyle(.secondary)
                        }
                        Spacer()
                        Text("\(user.followersCount)人")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
        .navigationTitle("探索")
    }
}

struct NotificationsView: View {
    let notifications = [
        "Hana Tanaka があなたの投稿にいいねしました",
        "Kenji Suzuki があなたをフォローしました",
        "Yuki Kobayashi があなたの投稿にコメントしました",
    ]

    var body: some View {
        List(notifications, id: \.self) { notification in
            HStack(spacing: 12) {
                Image(systemName: "bell.fill")
                    .foregroundStyle(.orange)
                Text(notification)
                    .font(.subheadline)
            }
        }
        .navigationTitle("通知")
    }
}

#Preview {
    NavigationStack {
        ExploreView()
    }
}
