class DailyForecast {
  final DateTime time;
  final WeatherCode weathercode;
  final double temperature_2m_max;
  final double temperature_2m_min;
  final double windspeed_max;
  final double windspeed_min;

  DailyForecast({
    required this.time,
    required this.weathercode,
    required this.temperature_2m_max,
    required this.temperature_2m_min,
    required this.windspeed_max,
    required this.windspeed_min,
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
    final times = daily['time'] as List<dynamic>;
    final weathercodes = daily['weathercode'] as List<dynamic>;
    final temperature_2m_max = daily['temperature_2m_max'] as List<dynamic>;
    final temperature_2m_min = daily['temperature_2m_min'] as List<dynamic>;
    final windspeed_max = daily['windspeed_10m_max'] as List<dynamic>;
    final windspeed_min = daily['windgusts_10m_max'] as List<dynamic>;
    return List.generate(
        times.length,
        (index) => DailyForecast(
              time: DateTime.parse(times[index]),
              weathercode: WeatherCode.fromNumeric(weathercodes[index]),
              temperature_2m_max: temperature_2m_max[index],
              temperature_2m_min: temperature_2m_min[index],
              windspeed_max: windspeed_max[index],
              windspeed_min: windspeed_min[index],
            ));
  }
}

class HourlyForecast {
  final DateTime time;
  final double temperature_2m;
  final double apparent_temperature;
  final double precipitation;
  final int precipitation_probability;
  final double windspeed_10m;
  final int winddirection_10m;

  HourlyForecast({
    required this.time,
    required this.temperature_2m,
    required this.apparent_temperature,
    required this.precipitation,
    required this.precipitation_probability,
    required this.windspeed_10m,
    required this.winddirection_10m,
  });

  static List<HourlyForecast> fromJson(Map<String, dynamic> hourly) {
    final times = hourly['time'] as List<dynamic>;
    final temperature_2m = hourly['temperature_2m'] as List<dynamic>;
    final apparent_temperature =
        hourly['apparent_temperature'] as List<dynamic>;
    final precipitation_probability =
        hourly['precipitation_probability'] as List<dynamic>;
    final precipitation = hourly['precipitation'] as List<dynamic>;
    final windspeed_10m = hourly['windspeed_10m'] as List<dynamic>;
    final winddirection_10m = hourly['winddirection_10m'] as List<dynamic>;
    return List.generate(
      times.length,
      (index) => HourlyForecast(
        time: DateTime.parse(times[index]),
        temperature_2m: temperature_2m[index],
        apparent_temperature: apparent_temperature[index],
        precipitation: precipitation[index],
        precipitation_probability: precipitation_probability[index],
        windspeed_10m: windspeed_10m[index],
        winddirection_10m: winddirection_10m[index],
      ),
    );
  }
}



// 0 	Clear sky
// 1, 2, 3 	Mainly clear, partly cloudy, and overcast
// 45, 48 	Fog and depositing rime fog
// 51, 53, 55 	Drizzle: Light, moderate, and dense intensity
// 56, 57 	Freezing Drizzle: Light and dense intensity
// 61, 63, 65 	Rain: Slight, moderate and heavy intensity
// 66, 67 	Freezing Rain: Light and heavy intensity
// 71, 73, 75 	Snow fall: Slight, moderate, and heavy intensity
// 77 	Snow grains
// 80, 81, 82 	Rain showers: Slight, moderate, and violent
// 85, 86 	Snow showers slight and heavy
// 95 * 	Thunderstorm: Slight or moderate
// 96, 99 * 	Thunderstorm with slight and heavy hail
enum WeatherCode {
  ClearSky(0, 'Clear sky', 'assets/clearsky.jpg'),
  MainlyClear(1, 'Mainly clear', 'Mainlyclear.jpg'),
  PartlyCloudy(2, 'Partly cloudy', 'Partlycloudy.jpg'),
  Overcast(3, 'Overcast', 'Overcast.jpg'),
  Fog(45, 'Fog', 'Fog.jpg'),
  DepositingRimeFog(48, 'Depositing rime fog', 'DepositingRimeFog.jpg'),
  DrizzleLight(51, 'Drizzle: Light intensity', 'DrizzleLight.jpg'),
  DrizzleModerate(53, 'Drizzle: Moderate intensity', 'DrizzleModerate.jpg'),
  DrizzleDense(55, 'Drizzle: Dense intensity', 'DrizzleDense.jpg'),
  FreezingDrizzleLight(
      56, 'Freezing Drizzle: Light intensity', 'FreezingDrizzleLight.jpg'),
  FreezingDrizzleDense(
      57, 'Freezing Drizzle: dense intensity', 'FreezingDrizzleDense.jpg'),
  RainSlight(61, 'Rain: Slight intensity', 'RainSlight.jpg'),
  RainModerate(63, 'Rain: Moderate intensity', 'RainModerate.jpg'),
  RainHeavy(65, 'Rain: Heavy intensity', 'RainHeavy.jpg'),
  FreezingRainLight(
      66, 'Freezing Rain: Light intensity', 'FreezingRainLight.jpg'),
  FreezingRainHeavy(
      66, 'Freezing Rain: Heavy intensity', 'FreezingRainHeavy.jpg'),
  SnowFallSlight(71, 'Snow fall: Slight intensity', 'SnowFallSlight.jpg'),
  SnowFallModerate(73, 'Snow fall: Moderate intensity', 'SnowFallModerate.jpg'),
  SnowFallHeavy(75, 'Snow fall: Heavy intensity', 'SnowFallHeavy.jpg'),
  SnowGrains(77, 'Snow grains', 'SnowGrains.jpg'),
  RainShowersSlight(80, 'Rain showers: Slight', 'RainShowersSlight.jpg'),
  RainShowersModerate(81, 'Rain showers: Moderate', 'RainShowersModerate.jpg'),
  RainShowersVoilent(82, 'Rain showers: Violent', 'RainShowersVoilent.jpg'),
  SnowShowersSlight(85, 'Snow showers: Slight', 'SnowShowersSlight.jpg'),
  SnowShowersHeavy(86, 'Snow showers: Heavy', 'SnowShowersHeavy.jpg'),
  Thunerstorm(95, 'Thunderstorm: Slight or moderate', 'Thunerstorm.jpg'),
  ThunderstormSlightHail(
      96, 'Thunderstorm with slight hail', 'ThunderstormSlightHail.jpg'),
  ThunderstormHeavyHail(
      99, 'Thunderstorm with heavy hail', 'ThunderstormHeavyHail.jpg'),
  ;

  final int numeric;
  final String description;
  final String image;

  const WeatherCode(this.numeric, this.description, this.image);

  static final _map =
      Map.fromEntries(WeatherCode.values.map((e) => MapEntry(e.numeric, e)));

  factory WeatherCode.fromNumeric(int numeric) {
    return WeatherCode._map[numeric]!;
  }
}
