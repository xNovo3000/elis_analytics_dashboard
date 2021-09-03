import 'package:elis_analytics_dashboard/model/enum/wind_direction.dart';

class WeatherInstant implements Comparable<WeatherInstant> {

  factory WeatherInstant.fromMapAndDuration(
    final Map<String, dynamic> map, [Duration duration = const Duration(seconds: 0)]
  ) => WeatherInstant(
    timestamp: DateTime.fromMillisecondsSinceEpoch(map['ts'], isUtc: true).toLocal(),
    duration: duration,
    ambientTemperature: map['ambient_temperature'],
    groundTemperature: map['ground_temperature'],
    pressure: map['pressure'],
    windDirection: WindDirection.fromDegrees(map['wind_direction_average'].floor()),
    windSpeed: map['wind_speed_mean'],
    windGust: map['wind_gust'],
    humidity: map['humidity'],
    rainfall: map['rainfall']
  );

  const WeatherInstant({
    required this.timestamp,
    required this.duration,
    required this.ambientTemperature,
    required this.groundTemperature,
    required this.pressure,
    required this.windDirection,
    required this.windSpeed,
    required this.windGust,
    required this.humidity,
    required this.rainfall,
  });

  final DateTime timestamp;
  final Duration duration;
  final double ambientTemperature;
  final double groundTemperature;
  final double pressure;
  final WindDirection windDirection;
  final double windSpeed;
  final double windGust;
  final double humidity;
  final double rainfall;

  DateTime get beginTimestamp => timestamp.subtract(Duration(microseconds: (duration.inMicroseconds / 2).floor()));
  DateTime get endTimestamp => timestamp.add(Duration(microseconds: (duration.inMicroseconds / 2).floor()));

  @override String toString() => 'WeatherDaily(timestamp: $timestamp, duration: $duration, '
    'ambientTemperature: $ambientTemperature, groundTemperature: $groundTemperature, '
    'pressure: $pressure, windDirection: $windDirection, windSpeed: $windSpeed, '
    'windGust: $windGust, humidity: $humidity, rainfall: $rainfall)';
  @override bool operator ==(Object other) => other is WeatherInstant ? timestamp.isAtSameMomentAs(other.timestamp) : false;
  @override int get hashCode => timestamp.hashCode;
  @override int compareTo(WeatherInstant other) => timestamp.compareTo(other.timestamp);

}