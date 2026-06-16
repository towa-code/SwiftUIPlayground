import SwiftUI

struct AddHabitView: View {
    @ObservedObject var store: HabitStore
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var emoji = "⭐️"
    @State private var targetCount = 1
    @State private var selectedColor: Color = .blue

    let colorOptions: [Color] = [.blue, .green, .orange, .red, .purple, .pink, .teal]
    let emojiOptions = ["⭐️", "🏃", "📚", "💧", "🧘", "🌍", "🍎", "💪", "🎯", "🎵"]

    var body: some View {
        NavigationStack {
            Form {
                Section("基本情報") {
                    TextField("習慣の名前", text: $name)

                    // 絵文字セレクター
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(emojiOptions, id: \.self) { e in
                                Text(e)
                                    .font(.title2)
                                    .padding(8)
                                    .background(emoji == e ? Color.blue.opacity(0.2) : Color.clear)
                                    .clipShape(Circle())
                                    .onTapGesture { emoji = e }
                            }
                        }
                    }
                }

                Section("目標") {
                    Stepper("目標回数: \(targetCount)", value: $targetCount, in: 1...100)
                }

                Section("カラー") {
                    HStack(spacing: 12) {
                        ForEach(colorOptions, id: \.self) { color in
                            Circle()
                                .fill(color)
                                .frame(width: 32, height: 32)
                                .overlay(
                                    Circle().stroke(Color.white, lineWidth: selectedColor == color ? 3 : 0)
                                )
                                .shadow(color: color.opacity(0.5), radius: selectedColor == color ? 4 : 0)
                                .onTapGesture { selectedColor = color }
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("習慣を追加")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("キャンセル") { dismiss() }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("追加") {
                        store.addHabit(
                            name: name,
                            emoji: emoji,
                            target: targetCount,
                            color: selectedColor
                        )
                        dismiss()
                    }
                    .bold()
                    .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }
}

#Preview {
    AddHabitView(store: HabitStore())
}
