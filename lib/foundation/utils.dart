import 'package:elis_analytics_dashboard/model/container/vodafone_daily.dart';
import 'package:elis_analytics_dashboard/model/data/vodafone_cluster.dart';
import 'package:elis_analytics_dashboard/model/enum/region.dart';
import 'package:elis_analytics_dashboard/model/enum/thingsboard_device.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

abstract class Utils {

  /* Non-instantiable, only static members */
  const Utils._();

  /* Dispatch from Map response to List of Maps response */
  static List<Map<String, dynamic>> dispatchThingsboardResponse(final Map<String, dynamic> map) {
    // check if map is empty
    if (map.isEmpty) {
      return <Map<String, dynamic>>[];
    }
    // generate supported data format
    List<Map<String, dynamic>> dispatched = List<Map<String, dynamic>>.generate(
        map.values.first.length, (_) => <String, dynamic>{}, growable: true
    );
    // dispatch
    map.forEach((key, value) {
      List<Map<String, dynamic>> values = List.generate(
        value.length, (index) => value[index], growable: false
      );
      if (dispatched.length < values.length) {
        dispatched.addAll(List.generate(values.length - dispatched.length, (index) => <String, dynamic>{}));
      }
      for (int i = 0; i < values.length; i++) {
        dispatched[i]['ts'] = values[i]['ts'];
        dispatched[i][key] = double.tryParse(values[i]['value']) ?? values[i]['value'];
      }
    });
    // return the dispatched data
    return dispatched;
  }

  /* Get occupancy number from G-move data */
  static int? getOccupancy(dynamic data) {
    if (data is double) {
      return data.round();
    } else if (data is int) {
      return data;
    } else {
      return null;
    }
  }

  /* Common URIs */
  static Uri getVodafoneUriFromDay(ThingsboardDevice device, DateTime begin, DateTime end) =>
    Uri.parse('plugins/telemetry/DEVICE/$device/values/timeseries')
    .replace(queryParameters: {
      'startTs': '${begin.toUtc().millisecondsSinceEpoch}',
      'endTs': '${end.toUtc().millisecondsSinceEpoch}',
      'keys': 'age,country,gender,homeDistance,workDistance,nationality,region,province,municipality,totalDwellTime,visitors,visits'
    });

  /* Realtime URIs */
  static final realtimeWeatherUri = Uri.parse('plugins/telemetry/DEVICE/${ThingsboardDevice.weatherStation}/values/timeseries');
  static final realtimeSensorAttendanceUri = Uri.parse('plugins/telemetry/DEVICE/${ThingsboardDevice.sensorsRealtimeAttendance}/values/timeseries');
  static final realtimeSensorVisitsUri = Uri.parse('plugins/telemetry/DEVICE/${ThingsboardDevice.sensorsRealtimeVisits}/values/timeseries');

  /* Daily URIs */
  static Uri getDailyCompleteWeatherUri(DateTime day) =>
    Uri.parse('plugins/telemetry/DEVICE/${ThingsboardDevice.weatherStation}/values/timeseries')
    .replace(queryParameters: {
      'startTs': '${day.toUtc().millisecondsSinceEpoch}',
      'endTs': '${day.toUtc().add(Duration(days: 1)).millisecondsSinceEpoch}',
      'keys': 'humidity,ambient_temperature,pressure,wind_speed_mean,wind_direction_average,wind_gust,ground_temperature',
      'interval': '21600000',
      'agg': 'AVG'
    });

  static Uri getDailyRainfallWeatherUri(DateTime day) =>
    Uri.parse('plugins/telemetry/DEVICE/${ThingsboardDevice.weatherStation}/values/timeseries')
    .replace(queryParameters: {
      'startTs': '${day.toUtc().millisecondsSinceEpoch}',
      'endTs': '${day.toUtc().add(Duration(days: 1)).millisecondsSinceEpoch}',
      'keys': 'rainfall',
      'interval': '21600000',
      'agg': 'SUM'
    });

  static Uri getDailySensorsAttendanceUri(DateTime day) =>
    Uri.parse('plugins/telemetry/DEVICE/${ThingsboardDevice.sensorsRealtimeAttendance}/values/timeseries')
    .replace(queryParameters: {
      'startTs': '${day.toUtc().millisecondsSinceEpoch}',
      'endTs': '${day.toUtc().add(Duration(days: 1)).millisecondsSinceEpoch}',
      'keys': 'presenze_lagrange,presenze_tesla',
      'interval': '1800000',
      'agg': 'AVG'
    });

  static Uri getDailySensorsVisitsUri(DateTime day) =>
    Uri.parse('plugins/telemetry/DEVICE/${ThingsboardDevice.sensorsRealtimeVisits}/values/timeseries')
    .replace(queryParameters: {
      'startTs': '${day.toUtc().millisecondsSinceEpoch}',
      'endTs': '${day.toUtc().add(Duration(days: 1)).millisecondsSinceEpoch}',
      'keys': 'tasso_di_ritorno,tempo_medio_permanenza,visitatori_corridoio,visitatori_hall,visitatori_openspace,visitatori_pascal,visitatori_Pinnhub',
      'interval': '1800000',
      'agg': 'AVG'
    });

  /* Region map shape generator */
  static final _mapNumberFormat = NumberFormat('###,###,##0');

  static void onRegionOriginMapClick(BuildContext context, VodafoneDaily vodafoneByRegion) {
    Navigator.of(context).pushNamed(
      '/daily/region_map',
      arguments: {
        'title': 'Mappa delle provenienze',
        'map_shape_source': generateMapShapeSourceFromVodafoneRegionData(vodafoneByRegion),
      }
    );
  }

  static MapShapeSource generateMapShapeSourceFromVodafoneRegionData(VodafoneDaily vodafoneByRegion) {
    return MapShapeSource.asset(
      'asset/map/italy.geojson',
      shapeDataField: 'reg_name',
      dataCount: 20,
      primaryValueMapper: (index) => Region.values[index].name,
      dataLabelMapper: (index) => _mapNumberFormat.format(
        vodafoneByRegion.singleWhere(
          (cluster) => cluster.region == Region.values[index],
          orElse: () => VodafoneCluster.empty(),
        ).visitors
      ),
      shapeColorValueMapper: (index) => _getRegionColorByPercentage(
        visitors: vodafoneByRegion.singleWhere(
          (cluster) => cluster.region == Region.values[index],
          orElse: () => VodafoneCluster.empty(),
        ).visitors,
        total: vodafoneByRegion.visitors,
      ),
    );
  }

  static Color? _getRegionColorByPercentage({
    required int visitors,
    required int total,
  }) {
    // Cache percentage
    final percentage = visitors / total;
    // Generate color
    if (percentage > 0.9) {
      return Colors.red[200];
    } else if (percentage > 0.75) {
      return Colors.yellow[200];
    } else if (percentage > 0.5) {
      return Colors.green[200];
    } else if (percentage > 0) {
      return Colors.blue[200];
    }
  }

}