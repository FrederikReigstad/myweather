import 'wethercode.dart';


class DailyForecast {
  static const timeKey = 'time';
  static const weatherCodeKey = 'weathercode';
  static const temperatureMaxKey = 'temperature_2m_max';
  static const temperatureMinKey = 'temperature_2m_min';
  static const windspeed_10m_maxKey = 'windspeed_10m_max';
  static const windgusts_10m_maxKey = 'windgusts_10m_max';

  static const fields = [
    weatherCodeKey,
    temperatureMaxKey,
    temperatureMinKey,
    windspeed_10m_maxKey,
    windgusts_10m_maxKey
  ];

  final DateTime time;
  final WeatherCode weathercode;
  final double temperature_2m_max;
  final double temperature_2m_min;
  final double windspeed_10m_max;
  final double windgusts_10m_max;

  DailyForecast(
      {required this.time,
      required this.weathercode,
      required this.temperature_2m_max,
      required this.temperature_2m_min,
      required this.windspeed_10m_max,
      required this.windgusts_10m_max
      });

  String getWeekday() {
    switch (time.weekday) {
      case DateTime.monday:
        return 'Monday';
      case DateTime.tuesday:
        return 'Tuesday';
      case DateTime.wednesday:
        return 'Wednesday';
      case DateTime.thursday:
        return 'Thursday';
      case DateTime.friday:
        return 'Friday';
      case DateTime.saturday:
        return 'Saturday';
      case DateTime.sunday:
        return 'Sunday';
      default:
        return '';
    }
  }

  static List<DailyForecast> fromJson(Map<String, dynamic> daily) {
    final times = daily[timeKey] as List<dynamic>;
    final weathercodes = daily[weatherCodeKey] as List<dynamic>;
    final temperature_2m_max = daily[temperatureMaxKey] as List<dynamic>;
    final temperature_2m_min = daily[temperatureMinKey] as List<dynamic>;

    final windspeed_10m_max = daily[windspeed_10m_maxKey] as List<dynamic>;

    final windgusts_10m_max = daily[windgusts_10m_maxKey] as List<dynamic>;

    return List.generate(
        times.length,
        (index) => DailyForecast(
            time: DateTime.parse(times[index]),
            weathercode: WeatherCode.fromNumeric(weathercodes[index]),
            temperature_2m_max: temperature_2m_max[index],
            temperature_2m_min: temperature_2m_min[index],
            windspeed_10m_max: windspeed_10m_max[index],
            windgusts_10m_max: windgusts_10m_max[index]
        ));
  }
}
