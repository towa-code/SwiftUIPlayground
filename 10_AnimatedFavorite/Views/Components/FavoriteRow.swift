import SwiftUI

struct FavoriteRow: View {
    let item: FavoriteItem
    @ObservedObject var viewModel: ItemViewModel

    // ハート縮小アニメーション用（このViewだけの見た目の状態）
    @State private var heartScale: CGFloat = 1.0

    var body: some View {
        HStack(spacing: 16) {
            // アイコン
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(item.color.opacity(0.15))
                    .frame(width: 56, height: 56)
                Text(item.emoji)
                    .font(.title2)
            }

            Text(item.name)
                .font(.headline)

            Spacer()

            // 削除ボタン（ハートをタップで解除）
            Button {
                // ハートを縮小 → 縮小が終わったタイミングでVMに削除を依頼する。
                // 削除後にこのView自体は破棄されるため、scaleを元に戻す処理は不要
                // （以前はここで heartScale = 1.0 にリセットしていたが、リストの
                // 退場アニメーションと競合して一瞬ハートが戻る見た目のバグになっていた）。
                withAnimation(.spring(response: 0.2, dampingFraction: 0.4)) {
                    heartScale = 1.4
                }
                withAnimation(.spring(response: 0.3).delay(0.15)) {
                    heartScale = 0.0
                }
                viewModel.removeFavoriteAfterShrink(item)
            } label: {
                Image(systemName: "heart.fill")
                    .font(.title2)
                    .foregroundStyle(.red)
                    .scaleEffect(heartScale)
            }
        }
        .padding(12)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    FavoriteRow(item: FavoriteItem.samples[0], viewModel: ItemViewModel())
        .padding()
}
