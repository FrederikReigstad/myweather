import 'package:Weather/widgets/hourly_forecast_list.dart';

class HourlyForecast {
  static const timeKey = 'time';
  static const temperatureKey = 'apparent_temperature';
  static const apparentTemperatureKey = 'apparent_temperature';
  static const precipitationKey = 'precipitation';
  static const precipitationProbabilityKey = 'precipitation_probability';
  static const windspeed_10mKey = 'windspeed_10m';
  static const winddirection_10mKey = 'winddirection_10m';

  static const fields = [
    temperatureKey,
    apparentTemperatureKey,
    precipitationKey,
    precipitationProbabilityKey,
    windspeed_10mKey,
    winddirection_10mKey
  ];

  final DateTime time;
  final double temperature_2m;
  final double apparent_temperature;
  final double precipitation;
  final int precipitation_probability;
  final double windspeed_10m;
  final int winddirection_10m;

  HourlyForecast(
      {required this.time,
      required this.temperature_2m,
      required this.apparent_temperature,
      required this.precipitation,
      required this.precipitation_probability,
      required this.windspeed_10m,
      required this.winddirection_10m
      });

  static List<HourlyForecast> fromJson(Map<String, dynamic> hourly) {
    final times = hourly[timeKey] as List<dynamic>;
    final temperature_2m = hourly[temperatureKey] as List<dynamic>;
    final apparent_temperature =
        hourly[apparentTemperatureKey] as List<dynamic>;
    final precipitation_probability =
        hourly[precipitationProbabilityKey] as List<dynamic>;
    final precipitation = hourly[precipitationKey] as List<dynamic>;

    final windspeed_10m =
        hourly[windspeed_10mKey] as List<dynamic>;

    final winddirection_10m =
        hourly[winddirection_10mKey] as List<dynamic>;

    return List.generate(
        times.length,
        (index) => HourlyForecast(
            time: DateTime.parse(times[index]),
            temperature_2m: temperature_2m[index],
            apparent_temperature: apparent_temperature[index],
            precipitation: precipitation[index],
            precipitation_probability: precipitation_probability[index],
            windspeed_10m: windspeed_10m[index],
            winddirection_10m: winddirection_10m[index]
        ));
  }
}
