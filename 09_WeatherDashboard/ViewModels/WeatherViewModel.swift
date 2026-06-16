import Foundation
import Combine

// EnvironmentObject として使用するために ObservableObject に準拠
class WeatherViewModel: ObservableObject {
    @Published var weatherList: [WeatherCondition] = WeatherCondition.samples
    @Published var selectedCity: WeatherCondition

    init() {
        self.selectedCity = WeatherCondition.samples[0]
    }

    func selectCity(_ city: WeatherCondition) {
        selectedCity = city
    }

    func formattedHumidity(_ value: Int) -> String {
        "\(value)%"
    }

    func formattedWind(_ value: Double) -> String {
        String(format: "%.1f m/s", value)
    }

    // シミュレーション: 天気を更新（実際はAPIコール）
    func refreshWeather() {
        // サンプルなのでシャッフルして変化をシミュレート
        objectWillChange.send()
    }
}
