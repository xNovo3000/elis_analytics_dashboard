import 'dart:collection';

import 'package:elis_analytics_dashboard/model/data/weather_instant.dart';

class WeatherInstantList extends ListBase<WeatherInstant> {

  factory WeatherInstantList.fromListAndTotalDuration(
    final List<Map<String, dynamic>> list, [Duration duration = const Duration(seconds: 0)]
  ) => WeatherInstantList(
    List.generate(
      list.length,
      (index) => WeatherInstant.fromMapAndDuration(list[index], duration * list.length),
      growable: false
    ),
  );

  WeatherInstantList(this._list);

  final List<WeatherInstant> _list;

  @override int get length => _list.length;
  @override set length(int newLength) => _list.length = newLength;
  @override WeatherInstant operator [](int index) => _list[index];
  @override void operator []=(int index, WeatherInstant value) => _list[index] = value;

  // Find a WeatherInstant within a specific DateTime
  WeatherInstant? fromTimestamp(final DateTime dateTime) {
    for (WeatherInstant weatherInstant in this) {
      if (dateTime.isBefore(weatherInstant.endTimestamp) && dateTime.isAfter(weatherInstant.beginTimestamp)) {
        return weatherInstant;
      }
    }
    return null;
  }

}