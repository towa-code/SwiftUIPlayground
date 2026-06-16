import SwiftUI

// EnvironmentObject の注入ポイント
// 通常はアプリの @main App struct で注入する
struct WeatherAppRoot: View {
    // @StateObject でViewModelを生成し、EnvironmentObjectとして子Viewに提供する
    @StateObject private var viewModel = WeatherViewModel()

    var body: some View {
        WeatherDashboardView()
            // .environmentObject: 子View全体でViewModelを共有する
            .environmentObject(viewModel)
    }
}

#Preview {
    WeatherAppRoot()
}
