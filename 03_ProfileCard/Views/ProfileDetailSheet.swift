import SwiftUI

struct ProfileDetailSheet: View {
    let profile: Profile
    @ObservedObject var viewModel: ProfileViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // ヘッダー (ZStack + overlay の組み合わせ)
                    ZStack(alignment: .bottom) {
                        // バナー背景
                        Rectangle()
                            .fill(
                                LinearGradient(
                                    colors: [profile.accentColor, profile.accentColor.opacity(0.5)],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(height: 120)

                        // アバター (ZStackで重ねる)
                        Image(systemName: profile.avatarSystemImage)
                            .font(.system(size: 80))
                            .foregroundStyle(.white)
                            .background(Circle().fill(profile.accentColor).frame(width: 100, height: 100))
                            .overlay(Circle().stroke(Color.white, lineWidth: 3))
                            .offset(y: 40)
                    }
                    .padding(.bottom, 40)

                    // プロフィール情報
                    VStack(spacing: 8) {
                        Text(profile.name)
                            .font(.title2.bold())
                        Text(profile.handle)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Text(profile.bio)
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }

                    // 統計
                    HStack(spacing: 40) {
                        DetailStatView(
                            value: viewModel.formattedCount(profile.postsCount),
                            title: "投稿"
                        )
                        DetailStatView(
                            value: viewModel.formattedCount(profile.followersCount),
                            title: "フォロワー"
                        )
                        DetailStatView(
                            value: viewModel.formattedCount(profile.followingCount),
                            title: "フォロー中"
                        )
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal)

                    // 詳細情報
                    VStack(alignment: .leading, spacing: 12) {
                        if !profile.location.isEmpty {
                            Label(profile.location, systemImage: "mappin.circle.fill")
                        }
                        if !profile.website.isEmpty {
                            Label(profile.website, systemImage: "link.circle.fill")
                                .foregroundStyle(.blue)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)

                    // フォローボタン
                    Button {
                        viewModel.toggleFollow(profile)
                    } label: {
                        Text(viewModel.followStatus(for: profile) ? "フォロー中" : "フォローする")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(viewModel.followStatus(for: profile) ? Color.secondary.opacity(0.2) : profile.accentColor)
                            .foregroundStyle(viewModel.followStatus(for: profile) ? .primary : .white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 40)
            }
            .navigationTitle("プロフィール")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("閉じる") { dismiss() }
                }
            }
        }
    }
}

struct DetailStatView: View {
    let value: String
    let title: String

    var body: some View {
        VStack(spacing: 4) {
            Text(value).font(.title3.bold())
            Text(title).font(.caption).foregroundStyle(.secondary)
        }
    }
}

#Preview {
    ProfileDetailSheet(profile: Profile.sample, viewModel: ProfileViewModel())
}
