import SwiftUI

struct ProfileListView: View {
    @StateObject private var viewModel = ProfileViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(viewModel.profiles) { profile in
                        ProfileCardView(profile: profile, viewModel: viewModel)
                            .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("プロフィール")
        }
    }
}

#Preview {
    ProfileListView()
}
