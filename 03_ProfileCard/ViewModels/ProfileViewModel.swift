import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    @Published var profiles: [Profile] = Profile.samples
    @Published var selectedProfile: Profile? = nil
    @Published var isFollowing: [UUID: Bool] = [:]

    init() {
        for profile in profiles {
            isFollowing[profile.id] = false
        }
    }

    func toggleFollow(_ profile: Profile) {
        isFollowing[profile.id, default: false].toggle()
    }

    func followStatus(for profile: Profile) -> Bool {
        isFollowing[profile.id, default: false]
    }

    func formattedCount(_ count: Int) -> String {
        if count >= 1000 {
            let k = Double(count) / 1000.0
            return String(format: "%.1fK", k)
        }
        return "\(count)"
    }
}
