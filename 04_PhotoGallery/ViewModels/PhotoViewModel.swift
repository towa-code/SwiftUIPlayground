import Foundation
import Combine

class PhotoViewModel: ObservableObject {
    @Published var allPhotos: [Photo] = Photo.samples
    @Published var selectedCategory: PhotoCategory = .all

    var filteredPhotos: [Photo] {
        if selectedCategory == .all {
            return allPhotos
        }
        return allPhotos.filter { $0.category == selectedCategory }
    }

    func formattedLikes(_ count: Int) -> String {
        if count >= 1000 {
            return String(format: "%.1fK", Double(count) / 1000.0)
        }
        return "\(count)"
    }
}
