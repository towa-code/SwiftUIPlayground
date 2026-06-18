import SwiftUI

/// カテゴリフィルター用のカプセル型チップ
struct CategoryChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .padding(.horizontal, 14)
                .padding(.vertical, 6)
                .background(isSelected ? Color.blue : Color(.secondarySystemBackground))
                .foregroundStyle(isSelected ? .white : .primary)
                .clipShape(Capsule())
        }
    }
}

#Preview {
    HStack {
        CategoryChip(title: "すべて", isSelected: true) {}
        CategoryChip(title: "自然", isSelected: false) {}
    }
}
