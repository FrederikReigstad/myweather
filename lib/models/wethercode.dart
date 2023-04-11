
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
  ClearSky(0, 'Clear sky', 'clearsky.jpg'),
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
