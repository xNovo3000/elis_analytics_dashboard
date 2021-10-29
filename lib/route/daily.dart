import 'dart:convert';

import 'package:elis_analytics_dashboard/component/managed_future_builder.dart';
import 'package:elis_analytics_dashboard/component/responsive_layout.dart';
import 'package:elis_analytics_dashboard/foundation/fetcher.dart';
import 'package:elis_analytics_dashboard/foundation/utils.dart';
import 'package:elis_analytics_dashboard/model/container/vodafone_daily.dart';
import 'package:elis_analytics_dashboard/model/container/weather_instant_list.dart';
import 'package:elis_analytics_dashboard/model/data/sensor_attendance.dart';
import 'package:elis_analytics_dashboard/model/data/sensor_visits.dart';
import 'package:elis_analytics_dashboard/model/enum/area.dart';
import 'package:elis_analytics_dashboard/model/exception/invalid_token.dart';
import 'package:elis_analytics_dashboard/model/inherited/daily_data.dart';
import 'package:elis_analytics_dashboard/model/inherited/error.dart';
import 'package:elis_analytics_dashboard/view/daily_smartphone.dart';
import 'package:flutter/material.dart';

class RouteDaily extends StatelessWidget {

  static const _underConstruction = false;

  final fetcher = Fetcher();

  @override
  Widget build(BuildContext context) {
    // Build the child widget
    // TODO: create the second view
    final child = ResponsiveLayout(
      smartphoneWidget: ViewDailySmartphone(),
    );
    // TODO: unfinished
    if (_underConstruction) {
      return ModelInheritedError(
        child: child,
        error: 'Questa visualizzazione è ancora in fase di costruzione',
      );
    }
    // Get specific day from route arguments dispatch
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args == null || !(args is Map<String, dynamic>) || !args.containsKey('day') || !(args['day'] is DateTime)) {
      return ModelInheritedError(
        child: child,
        error: 'Si è verificato un errore sconosciuto',
      );
    }
    // Build UI
    return ComponentManagedFutureBuilder<Map<String, dynamic>>(
      future: _getDailyData(args['day']),
      onSuccess: (context, data) => ModelInheritedDailyData(
        child: child,
        weathers: data['weathers'],
        attendance: data['attendance'],
        visits: data['visits'],
        campusVodafone: data['campus_vodafone'],
        neighborhoodVodafone: data['neighborhood_vodafone'],
      ),
      onError: (context, error) => ModelInheritedError(
        child: child,
        error: '$error',
      ),
      onWait: (context) => child,
    );
  }

  // generate REAL data
  Future<Map<String, dynamic>> _getDailyData(DateTime day) async => {
    'weathers': await _getWeatherData(day),
    'attendance': await _getSensorAttendanceData(day),
    'visits': await _getSensorVisitsData(day),
    'campus_vodafone': await _getVodafoneData(day, Area.campus),
    'neighborhood_vodafone': await _getVodafoneData(day, Area.neighborhood),
  };

  Future<WeatherInstantList> _getWeatherData(DateTime day) async {
    // Make requests and check them
    final completeResponse = await fetcher.get(Utils.getDailyCompleteWeatherUri(day));
    switch (completeResponse.statusCode) {
      case 200:
        break;
      case 401:
        throw InvalidTokenException('');
      default:
        throw completeResponse.statusCode;
    }
    final rainfallResponse = await fetcher.get(Utils.getDailyRainfallWeatherUri(day));
    switch (rainfallResponse.statusCode) {
      case 200:
        break;
      case 401:
        throw InvalidTokenException('');
      default:
        throw rainfallResponse.statusCode;
    }
    // Generate complete result
    final result = json.decode(completeResponse.body)..addAll(json.decode(rainfallResponse.body));
    // Return data
    return WeatherInstantList.fromListAndTotalDuration(Utils.dispatchThingsboardResponse(result), Duration(days: 1));
  }

  // sti sensori mandano solo se ci sono aggiornamenti,
  // bisogna fare un lavoro differente a livello di dati
  Future<List<SensorAttendance>> _getSensorAttendanceData(DateTime day) async {
    final response = await fetcher.get(Utils.getDailySensorsAttendanceUri(day));
    switch (response.statusCode) {
      case 200:
        // Generate things
        final dispatchedResponse = Utils.dispatchThingsboardResponse(json.decode(response.body));
        // final temporaryAttendances = <SensorAttendance>[];
        // dispatchedResponse.forEach((cluster) => temporaryAttendances.add(SensorAttendance.fromMap(cluster)));
        // final attendances = <SensorAttendance>[];
        // for (var temp in temporaryAttendances) {
        //   final deltaTime = temp.timestamp.difference(day);
        //   final position = (deltaTime.inMinutes / 30).floor();
        //   while (attendances.length <= position) {
        //     attendances.add(SensorAttendance.fromTimestamp(day.add(Duration(minutes: 30 * (position + 1))).subtract(Duration(minutes: 15))));
        //   }
        //   final tempAttendance = attendances.last;
        //   final attendanceResult = SensorAttendance(
        //     timestamp: tempAttendance.timestamp,
        //     roomsData: List.generate(RoomAttendance.values.length, (index) => RoomAttendanceData(
        //       room: RoomAttendance.values[index],
        //       occupancy: max((tempAttendance.roomsData.singleWhere((roomAttendance) => roomAttendance.room == RoomAttendance.values[index]).occupancy ?? 0),
        //           (temp.roomsData.singleWhere((roomAttendance) => roomAttendance.room == RoomAttendance.values[index]).occupancy ?? 0))
        //     ))
        //   );
        //   attendances.add(attendanceResult);
        // }
        final result = List.generate(
          dispatchedResponse.length,
          (index) => SensorAttendance.fromMap(dispatchedResponse[index]),
          growable: true
        );
        if (result.length < 48) {
          for (int i = 0; i < 48; i++) {
            final date = day.add(Duration(minutes: 30 * (i + 1))).subtract(Duration(minutes: 15));
            try {
              result.singleWhere((j) => j.timestamp.isAtSameMomentAs(date));
            } catch (e) {
              result.add(SensorAttendance.fromTimestamp(date));
            }
          }
          result.sort();
        }
        return result;
      case 401:
        throw InvalidTokenException('');
      default:
        throw response.statusCode;
    }
  }

  Future<List<SensorVisits>> _getSensorVisitsData(DateTime day) async {
    final response = await fetcher.get(Utils.getDailySensorsVisitsUri(day));
    switch (response.statusCode) {
      case 200:
        final dispatchedResponse = Utils.dispatchThingsboardResponse(json.decode(response.body));
        return List.generate(
          dispatchedResponse.length,
          (index) => SensorVisits.fromMap(dispatchedResponse[index]),
          growable: false
        );
      case 401:
        throw InvalidTokenException('');
      default:
        throw response.statusCode;
    }
  }

  Future<VodafoneDaily?> _getVodafoneData(DateTime day, Area area) async {
    final response = await fetcher.get(Utils.getVodafoneUriFromDay(area.device, day, day.add(Duration(days: 1))));
    switch (response.statusCode) {
      case 200:
        final result = Utils.dispatchThingsboardResponse(json.decode(response.body));
        return result.length > 0
          ? VodafoneDaily.fromList(
              list: result,
              area: area,
              date: day,
            )
          : null;
      case 401:
        throw InvalidTokenException('');
      default:
        throw response.statusCode;
    }
  }

}
