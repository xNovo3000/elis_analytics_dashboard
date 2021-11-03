import 'dart:math';

import 'package:elis_analytics_dashboard/model/enum/wind_direction.dart';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherDaily implements Comparable<WeatherDaily> {

  factory WeatherDaily.test([int days = 0]) {
    final random = Random();
    return WeatherDaily(
      timestamp: DateTime.now().add(Duration(days: days)),
      ambientTemperatureMin: random.nextInt(5) + 15,
      ambientTemperatureMax: random.nextInt(3) + 22,
      windSpeedMean: random.nextDouble() * 5,
      windDirection: WindDirection.fromDegrees(random.nextDouble() * 360),
      humidity: random.nextDouble() * 50 + 50,
      rainfall: random.nextDouble() * 4,
    );
  }

  factory WeatherDaily.fromMap(final Map<String, dynamic> map) => WeatherDaily(
    timestamp: DateTime.fromMillisecondsSinceEpoch(map['ts'], isUtc: true).toLocal(),
    ambientTemperatureMin: map['ambient_temperature_min'],
    ambientTemperatureMax: map['ambient_temperature_max'],
    windSpeedMean: map['wind_speed_mean'] ?? 0,
    windDirection: WindDirection.fromDegrees((map['wind_direction_average'] ?? 0).floor()),
    humidity: map['humidity'] ?? 0,
    rainfall: map['rainfall']
  );

  const WeatherDaily({
    required this.timestamp,
    required this.ambientTemperatureMin,
    required this.ambientTemperatureMax,
    required this.windSpeedMean,
    required this.windDirection,
    required this.humidity,
    required this.rainfall,
  });

  final DateTime timestamp;
  final double ambientTemperatureMin;
  final double ambientTemperatureMax;
  final double windSpeedMean;
  final WindDirection windDirection;
  final double humidity;
  final double rainfall;

  @override String toString() =>
    'WeatherDaily(timestamp: $timestamp, ambientTemperatureMin: $ambientTemperatureMin, '
    'ambientTemperatureMax: $ambientTemperatureMax, windSpeedMean: $windSpeedMean, '
    'windDirection: $windDirection, humidity: $humidity, rainfall: $rainfall)';
  @override bool operator ==(Object other) => other is WeatherDaily ? timestamp.isAtSameMomentAs(other.timestamp) : false;
  @override int get hashCode => timestamp.hashCode;
  @override int compareTo(WeatherDaily other) => timestamp.compareTo(other.timestamp);

  /* Flutter icons and colors */
  IconData get icon {
    // set the rainfall threshold
    double rainfallThreshold = /* duration.inHours / 12 */ 2;
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