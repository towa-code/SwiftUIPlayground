import SwiftUI

struct ProductRowView: View {
    let product: Product
    @ObservedObject var viewModel: ProductViewModel

    var body: some View {
        HStack(spacing: 12) {
            // 商品アイコン（カテゴリ別）
            RoundedRectangle(cornerRadius: 10)
                .fill(categoryColor(for: product.category).opacity(0.15))
                .frame(width: 60, height: 60)
                .overlay {
                    Text(categoryEmoji(for: product.category))
                        .font(.title2)
                }

            VStack(alignment: .leading, spacing: 4) {
                Text(product.name)
                    .font(.subheadline.bold())
                    .lineLimit(1)
                Text(product.brand)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                HStack(spacing: 4) {
                    Text(viewModel.starsString(for: product.rating))
                        .font(.caption)
                        .foregroundStyle(.orange)
                    Text("(\(product.reviewCount))")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text(product.formattedPrice)
                    .font(.subheadline.bold())

                Button {
                    viewModel.toggleFavorite(product)
                } label: {
                    Image(systemName: product.isFavorite ? "heart.fill" : "heart")
                        .foregroundStyle(product.isFavorite ? .red : .secondary)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(12)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    private func categoryColor(for category: ProductCategory) -> Color {
        switch category {
        case .electronics: return .blue
        case .books: return .orange
        case .clothing: return .purple
        case .food: return .green
        case .sports: return .red
        case .all: return .gray
        }
    }

    private func categoryEmoji(for category: ProductCategory) -> String {
        switch category {
        case .electronics: return "📱"
        case .books: return "📚"
        case .clothing: return "👔"
        case .food: return "🍵"
        case .sports: return "🏃"
        case .all: return "🛍"
        }
    }
}

#Preview {
    List {
        ProductRowView(product: Product.samples[0], viewModel: ProductViewModel())
            .listRowInsets(EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12))
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
    }
    .listStyle(.plain)
}
