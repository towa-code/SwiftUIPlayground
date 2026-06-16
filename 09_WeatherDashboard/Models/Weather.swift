import Foundation
import SwiftUI

struct WeatherCondition: Identifiable {
    let id: UUID
    let cityName: String
    let temperature: Double
    let feelsLike: Double
    let humidity: Int
    let windSpeed: Double
    let condition: WeatherType
    let hourlyForecast: [HourlyForecast]
    let weeklyForecast: [DailyForecast]

    init(
        id: UUID = UUID(),
        cityName: String,
        temperature: Double,
        feelsLike: Double,
        humidity: Int,
        windSpeed: Double,
        condition: WeatherType,
        hourlyForecast: [HourlyForecast] = [],
        weeklyForecast: [DailyForecast] = []
    ) {
        self.id = id
        self.cityName = cityName
        self.temperature = temperature
        self.feelsLike = feelsLike
        self.humidity = humidity
        self.windSpeed = windSpeed
        self.condition = condition
        self.hourlyForecast = hourlyForecast
        self.weeklyForecast = weeklyForecast
    }

    var formattedTemp: String { "\(Int(temperature))°" }
    var backgroundColors: [Color] { condition.backgroundColors }
}

enum WeatherType: String {
    case sunny = "晴れ"
    case cloudy = "曇り"
    case rainy = "雨"
    case snowy = "雪"
    case stormy = "嵐"
    case partlyCloudy = "晴れ時々曇り"

    var icon: String {
        switch self {
        case .sunny: return "sun.max.fill"
        case .cloudy: return "cloud.fill"
        case .rainy: return "cloud.rain.fill"
        case .snowy: return "cloud.snow.fill"
        case .stormy: return "cloud.bolt.rain.fill"
        case .partlyCloudy: return "cloud.sun.fill"
        }
    }

    var backgroundColors: [Color] {
        switch self {
        case .sunny: return [Color(red: 0.25, green: 0.6, blue: 0.95), Color(red: 0.4, green: 0.75, blue: 1.0)]
        case .cloudy: return [Color(red: 0.55, green: 0.6, blue: 0.7), Color(red: 0.7, green: 0.74, blue: 0.82)]
        case .rainy: return [Color(red: 0.3, green: 0.4, blue: 0.55), Color(red: 0.4, green: 0.5, blue: 0.65)]
        case .snowy: return [Color(red: 0.55, green: 0.7, blue: 0.85), Color(red: 0.75, green: 0.85, blue: 0.95)]
        case .stormy: return [Color(red: 0.2, green: 0.25, blue: 0.38), Color(red: 0.35, green: 0.4, blue: 0.52)]
        case .partlyCloudy: return [Color(red: 0.3, green: 0.55, blue: 0.85), Color(red: 0.55, green: 0.72, blue: 0.92)]
        }
    }
}

struct HourlyForecast: Identifiable {
    let id = UUID()
    let hour: String
    let temperature: Double
    let condition: WeatherType
}

struct DailyForecast: Identifiable {
    let id = UUID()
    let dayName: String
    let condition: WeatherType
    let highTemp: Double
    let lowTemp: Double
}

extension WeatherCondition {
    static let samples: [WeatherCondition] = [
        WeatherCondition(
            cityName: "東京",
            temperature: 22,
            feelsLike: 20,
            humidity: 62,
            windSpeed: 3.5,
            condition: .partlyCloudy,
            hourlyForecast: [
                HourlyForecast(hour: "今", temperature: 22, condition: .partlyCloudy),
                HourlyForecast(hour: "13時", temperature: 24, condition: .sunny),
                HourlyForecast(hour: "14時", temperature: 25, condition: .sunny),
                HourlyForecast(hour: "15時", temperature: 24, condition: .partlyCloudy),
                HourlyForecast(hour: "16時", temperature: 22, condition: .cloudy),
                HourlyForecast(hour: "17時", temperature: 20, condition: .cloudy),
            ],
            weeklyForecast: [
                DailyForecast(dayName: "今日", condition: .partlyCloudy, highTemp: 25, lowTemp: 18),
                DailyForecast(dayName: "月", condition: .sunny, highTemp: 27, lowTemp: 19),
                DailyForecast(dayName: "火", condition: .rainy, highTemp: 21, lowTemp: 16),
                DailyForecast(dayName: "水", condition: .rainy, highTemp: 18, lowTemp: 14),
                DailyForecast(dayName: "木", condition: .cloudy, highTemp: 22, lowTemp: 15),
                DailyForecast(dayName: "金", condition: .sunny, highTemp: 26, lowTemp: 18),
                DailyForecast(dayName: "土", condition: .sunny, highTemp: 28, lowTemp: 20),
            ]
        ),
        WeatherCondition(
            cityName: "大阪",
            temperature: 26,
            feelsLike: 28,
            humidity: 70,
            windSpeed: 2.1,
            condition: .sunny,
            hourlyForecast: [
                HourlyForecast(hour: "今", temperature: 26, condition: .sunny),
                HourlyForecast(hour: "13時", temperature: 28, condition: .sunny),
                HourlyForecast(hour: "14時", temperature: 29, condition: .sunny),
                HourlyForecast(hour: "15時", temperature: 28, condition: .partlyCloudy),
                HourlyForecast(hour: "16時", temperature: 26, condition: .partlyCloudy),
                HourlyForecast(hour: "17時", temperature: 24, condition: .cloudy),
            ],
            weeklyForecast: [
                DailyForecast(dayName: "今日", condition: .sunny, highTemp: 29, lowTemp: 21),
                DailyForecast(dayName: "月", condition: .sunny, highTemp: 30, lowTemp: 22),
                DailyForecast(dayName: "火", condition: .partlyCloudy, highTemp: 27, lowTemp: 20),
                DailyForecast(dayName: "水", condition: .cloudy, highTemp: 24, lowTemp: 18),
                DailyForecast(dayName: "木", condition: .rainy, highTemp: 20, lowTemp: 16),
                DailyForecast(dayName: "金", condition: .sunny, highTemp: 28, lowTemp: 20),
                DailyForecast(dayName: "土", condition: .sunny, highTemp: 31, lowTemp: 23),
            ]
        ),
        WeatherCondition(
            cityName: "札幌",
            temperature: 8,
            feelsLike: 5,
            humidity: 78,
            windSpeed: 6.2,
            condition: .snowy,
            hourlyForecast: [
                HourlyForecast(hour: "今", temperature: 8, condition: .snowy),
                HourlyForecast(hour: "13時", temperature: 7, condition: .snowy),
                HourlyForecast(hour: "14時", temperature: 6, condition: .snowy),
                HourlyForecast(hour: "15時", temperature: 5, condition: .stormy),
                HourlyForecast(hour: "16時", temperature: 4, condition: .stormy),
                HourlyForecast(hour: "17時", temperature: 3, condition: .snowy),
            ],
            weeklyForecast: [
                DailyForecast(dayName: "今日", condition: .snowy, highTemp: 8, lowTemp: 1),
                DailyForecast(dayName: "月", condition: .cloudy, highTemp: 10, lowTemp: 3),
                DailyForecast(dayName: "火", condition: .sunny, highTemp: 12, lowTemp: 4),
                DailyForecast(dayName: "水", condition: .sunny, highTemp: 14, lowTemp: 5),
                DailyForecast(dayName: "木", condition: .partlyCloudy, highTemp: 11, lowTemp: 3),
                DailyForecast(dayName: "金", condition: .snowy, highTemp: 7, lowTemp: 0),
                DailyForecast(dayName: "土", condition: .snowy, highTemp: 5, lowTemp: -2),
            ]
        ),
    ]
}
