import 'dart:math';

import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherDaily implements Comparable<WeatherDaily> {

  factory WeatherDaily.test() {
    final random = Random();
    return WeatherDaily(
      timestamp: DateTime.now(),
      ambientTemperatureMin: random.nextInt(5) + 15,
      ambientTemperatureMax: random.nextInt(3) + 22,
      windSpeedMean: random.nextDouble() * 5,
      rainfall: random.nextDouble() * 4,
    );
  }

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

  @override String toString() =>
    'WeatherDaily(timestamp: $timestamp, ambientTemperatureMin: $ambientTemperatureMin, '
    'ambientTemperatureMax: $ambientTemperatureMax, windSpeedMean: $windSpeedMean, rainfall: $rainfall)';
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