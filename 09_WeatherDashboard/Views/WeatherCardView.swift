import SwiftUI

// 時間別予報
struct HourlyForecastRow: View {
    @EnvironmentObject var viewModel: WeatherViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("時間ごとの予報", systemImage: "clock")
                .font(.caption.bold())
                .foregroundStyle(.white.opacity(0.8))

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(viewModel.selectedCity.hourlyForecast) { forecast in
                        VStack(spacing: 8) {
                            Text(forecast.hour)
                                .font(.caption)
                                .foregroundStyle(.white.opacity(0.8))
                            Image(systemName: forecast.condition.icon)
                                .symbolRenderingMode(.multicolor)
                                .font(.title3)
                            Text("\(Int(forecast.temperature))°")
                                .font(.subheadline.bold())
                                .foregroundStyle(.white)
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background(.white.opacity(0.15))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
            }
        }
        .padding()
        .background(.white.opacity(0.12))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

// 週間予報
struct WeeklyForecastCard: View {
    @EnvironmentObject var viewModel: WeatherViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("7日間の予報", systemImage: "calendar")
                .font(.caption.bold())
                .foregroundStyle(.white.opacity(0.8))

            VStack(spacing: 8) {
                ForEach(viewModel.selectedCity.weeklyForecast) { forecast in
                    HStack {
                        Text(forecast.dayName)
                            .font(.subheadline)
                            .foregroundStyle(.white)
                            .frame(width: 40, alignment: .leading)

                        Image(systemName: forecast.condition.icon)
                            .symbolRenderingMode(.multicolor)
                            .frame(width: 24)

                        Text(forecast.condition.rawValue)
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.7))

                        Spacer()

                        Text("\(Int(forecast.lowTemp))°")
                            .font(.subheadline)
                            .foregroundStyle(.white.opacity(0.6))
                            .frame(width: 36, alignment: .trailing)

                        Text("\(Int(forecast.highTemp))°")
                            .font(.subheadline.bold())
                            .foregroundStyle(.white)
                            .frame(width: 36, alignment: .trailing)
                    }
                }
            }
        }
        .padding()
        .background(.white.opacity(0.12))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

// 詳細グリッド
struct WeatherDetailGrid: View {
    @EnvironmentObject var viewModel: WeatherViewModel

    var city: WeatherCondition { viewModel.selectedCity }

    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
            WeatherDetailCell(icon: "humidity.fill", title: "湿度", value: viewModel.formattedHumidity(city.humidity))
            WeatherDetailCell(icon: "wind", title: "風速", value: viewModel.formattedWind(city.windSpeed))
            WeatherDetailCell(icon: "thermometer.low", title: "体感気温", value: "\(Int(city.feelsLike))°")
            WeatherDetailCell(icon: "location.fill", title: "都市", value: city.cityName)
        }
    }
}

struct WeatherDetailCell: View {
    let icon: String
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label(title, systemImage: icon)
                .font(.caption.bold())
                .foregroundStyle(.white.opacity(0.8))
            Text(value)
                .font(.title3.bold())
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.white.opacity(0.12))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    VStack(spacing: 16) {
        HourlyForecastRow()
        WeeklyForecastCard()
        WeatherDetailGrid()
    }
    .padding()
    .background(Color.blue.gradient)
    .environmentObject(WeatherViewModel())
}
