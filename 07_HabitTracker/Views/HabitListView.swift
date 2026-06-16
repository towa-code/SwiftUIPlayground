import SwiftUI

struct HabitListView: View {
    // @StateObject: このViewがHabitStoreを所有・管理する
    // Viewが破棄されるまでインスタンスが保持される
    @StateObject private var store = HabitStore()
    @State private var showAddHabit = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    // 全体進捗サマリー
                    SummaryCard(store: store)
                        .padding(.horizontal)

                    // 習慣リスト
                    ForEach(store.habits) { habit in
                        NavigationLink(destination: HabitDetailView(habit: habit, store: store)) {
                            HabitRowView(habit: habit, store: store)
                                .padding(.horizontal)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.vertical)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("習慣トラッカー")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAddHabit = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddHabit) {
                AddHabitView(store: store)
            }
        }
    }
}

struct SummaryCard: View {
    // @ObservedObject: 外部から受け取ったObservableObjectを購読
    @ObservedObject var store: HabitStore

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                VStack(alignment: .leading) {
                    Text("今日の進捗")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text("\(store.totalCompleted) / \(store.habits.count) 完了")
                        .font(.title2.bold())
                }
                Spacer()
                // ProgressView: 進捗を視覚的に表示（円形）
                ProgressView(value: store.overallProgress)
                    .progressViewStyle(CircularProgressStyle())
            }

            // ProgressView: 線形（デフォルト）
            ProgressView(value: store.overallProgress)
                .tint(.green)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

// カスタムProgressViewStyle
struct CircularProgressStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.2), lineWidth: 6)
            Circle()
                .trim(from: 0, to: configuration.fractionCompleted ?? 0)
                .stroke(Color.green, style: StrokeStyle(lineWidth: 6, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut, value: configuration.fractionCompleted)
            Text("\(Int((configuration.fractionCompleted ?? 0) * 100))%")
                .font(.caption2.bold())
        }
        .frame(width: 56, height: 56)
    }
}

#Preview {
    HabitListView()
}
