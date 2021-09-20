import 'dart:math';

import 'package:elis_analytics_dashboard/model/enum/wind_direction.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:flutter/material.dart';

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

  // TEST: used only for testing purposes
  factory WeatherInstant.test() {
    final random = Random();
    return WeatherInstant(
      timestamp: DateTime.now(),
      duration: const Duration(seconds: 0),
      ambientTemperature: 20 + random.nextDouble() * 5,
      groundTemperature: 20 + random.nextDouble() * 5,
      pressure: 1000 + random.nextDouble() * 30,
      windDirection: WindDirection.fromDegrees(random.nextDouble() * 360),
      windSpeed: random.nextDouble() * 7,
      windGust: 7 + random.nextDouble() * 3,
      humidity: 40 + random.nextDouble() * 30,
      rainfall: random.nextDouble(),
    );
  }

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

  /* Flutter icons and colors */
  IconData get icon {
    // set the rainfall threshold
    double rainfallThreshold = duration.inHours / 12;
    // return logic
    if (timestamp.hour < 20 && timestamp.hour > 6) { // day
      if (rainfall > rainfallThreshold) {
        return WeatherIcons.rain;
      } else if (rainfall > 0) {
        return WeatherIcons.cloud;
      } else {
        return WeatherIcons.day_sunny;
      }
    } else { // night
      if (rainfall > rainfallThreshold) {
        return WeatherIcons.rain;
      } else if (rainfall > 0) {
        return WeatherIcons.cloud;
      } else {
        return WeatherIcons.night_clear;
      }
    }
  }

  Color? get iconColor {
    // return logic
    if (timestamp.hour < 20 && timestamp.hour > 6 && rainfall == 0) { // day
      return Colors.yellow;
    }
  }

}