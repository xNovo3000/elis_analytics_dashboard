class WeatherDaily implements Comparable<WeatherDaily> {

  factory WeatherDaily.fromMap(final Map<String, dynamic> map) => WeatherDaily(
    timestamp: DateTime.fromMillisecondsSinceEpoch(map['ts'], isUtc: true).toLocal(),
    ambientTemperatureMin: map['ambient_temperature_min'],
    ambientTemperatureMax: map['ambient_temperature_max'],
    windSpeedMean: map['wind_speed_mean'],
    rainfall: map['rainfall']
  );

  const WeatherDaily({
    required this.timestamp,
    required this.ambientTemperatureMin,
    required this.ambientTemperatureMax,
    required this.windSpeedMean,
    required this.rainfall,
  });

  final DateTime timestamp;
  final double ambientTemperatureMin;
  final double ambientTemperatureMax;
  final double windSpeedMean;
  final double rainfall;

  @override String toString() => 'WeatherDaily(timestamp: $timestamp, ambientTemperatureMin: $ambientTemperatureMin, '
    'ambientTemperatureMax: $ambientTemperatureMax, windSpeedMean: $windSpeedMean, rainfall: $rainfall)';
  @override bool operator ==(Object other) => other is WeatherDaily ? timestamp.isAtSameMomentAs(other.timestamp) : false;
  @override int get hashCode => timestamp.hashCode;
  @override int compareTo(WeatherDaily other) => timestamp.compareTo(other.timestamp);

}