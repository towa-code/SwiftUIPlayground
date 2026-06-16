import SwiftUI

struct WeatherDashboardView: View {
    // @EnvironmentObject: 親から注入されたViewModelを受け取る
    // .environmentObject() で注入されていないと実行時エラーになる
    @EnvironmentObject var viewModel: WeatherViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // 都市選択ピッカー
                    CityPickerView()

                    // メイン天気カード
                    WeatherMainCard()

                    // 時間別予報
                    HourlyForecastRow()

                    // 週間予報
                    WeeklyForecastCard()

                    // 詳細情報
                    WeatherDetailGrid()
                }
                .padding()
            }
            .background(
                LinearGradient(
                    colors: viewModel.selectedCity.backgroundColors,
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            )
            .navigationTitle("天気")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.refreshWeather()
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .foregroundStyle(.white)
                    }
                }
            }
        }
    }
}

// 都市選択
struct CityPickerView: View {
    @EnvironmentObject var viewModel: WeatherViewModel

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(viewModel.weatherList) { city in
                    Button {
                        viewModel.selectCity(city)
                    } label: {
                        Text(city.cityName)
                            .font(.subheadline.bold())
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(
                                viewModel.selectedCity.id == city.id
                                ? Color.white.opacity(0.3)
                                : Color.white.opacity(0.1)
                            )
                            .foregroundStyle(.white)
                            .clipShape(Capsule())
                            .overlay(
                                Capsule().stroke(
                                    viewModel.selectedCity.id == city.id ? Color.white : Color.clear,
                                    lineWidth: 1.5
                                )
                            )
                    }
                }
            }
        }
    }
}

// メイン天気カード
struct WeatherMainCard: View {
    @EnvironmentObject var viewModel: WeatherViewModel

    var city: WeatherCondition { viewModel.selectedCity }

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: city.condition.icon)
                .font(.system(size: 72))
                .symbolRenderingMode(.multicolor)
                .foregroundStyle(.white)

            Text(city.cityName)
                .font(.title2)
                .foregroundStyle(.white.opacity(0.9))

            Text(city.formattedTemp)
                .font(.system(size: 80, weight: .thin))
                .foregroundStyle(.white)

            Text(city.condition.rawValue)
                .font(.title3)
                .foregroundStyle(.white.opacity(0.8))

            Text("体感 \(Int(city.feelsLike))°")
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.7))
        }
        .padding()
    }
}

#Preview {
    WeatherDashboardView()
        .environmentObject(WeatherViewModel())
}
