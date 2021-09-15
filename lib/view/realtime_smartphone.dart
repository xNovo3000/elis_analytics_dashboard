import 'package:elis_analytics_dashboard/component/bar_graph.dart';
import 'package:elis_analytics_dashboard/model/container/vodafone_daily_list.dart';
import 'package:elis_analytics_dashboard/model/enum/gender.dart';
import 'package:elis_analytics_dashboard/model/enum/nationality.dart';
import 'package:elis_analytics_dashboard/model/inherited/error.dart';
import 'package:elis_analytics_dashboard/model/inherited/realtime_data.dart';
import 'package:elis_analytics_dashboard/component/modal/fullscreen/error.dart';
import 'package:elis_analytics_dashboard/component/modal/fullscreen/wait.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';

class ViewRealtimeSmartphone extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Check data
    final realtimeData = ModelInheritedRealtimeData.maybeOf(context);
    final error = ModelInheritedError.maybeOf(context);
    // Build the view
    return Scaffold(
      appBar: AppBar(
        title: const Text('ELIS Analytics Dashboard'),
      ),
      body: realtimeData != null
        ? _ViewRealtimeSmartphoneData()
        : error != null
          ? ComponentModalFullscreenError(error: error.error)
          : ComponentModalFullscreenWait(),
    );
  }

}

class _ViewRealtimeSmartphoneData extends StatelessWidget {

  static final DateFormat _weekdayResolver = DateFormat('EEEE', 'it');

  @override
  Widget build(BuildContext context) {
    // Obtain data (always exists)
    final realtimeData = ModelInheritedRealtimeData.of(context);
    // Calculate data only one time
    final isVodafoneDataConsistent = _isVodafoneDataConsistent(
        realtimeData.campusVodafoneData, realtimeData.neighborhoodVodafoneData
    );
    final foreignersPercentage = _getForeignersPercentage(realtimeData.campusVodafoneData);
    final captureRatio = realtimeData.campusVodafoneData.visitors / realtimeData.neighborhoodVodafoneData.visitors * 100;
    // Build the view
    return ListView(
      key: PageStorageKey('_ViewRealtimeSmartphoneDataListView'),
      children: [
        ListTile(
          title: Text(
              'RAPPORTO METEO',
              style: TextStyle(color: Theme.of(context).colorScheme.secondary)
          ),
          trailing: OutlinedButton(
            child: const Text('DETTAGLI'),
            onPressed: () => Navigator.pushNamed(
                context,
                '/weather_report',
                arguments: {
                  'weather_report': realtimeData.weather,
                }
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: Wrap(
            alignment: WrapAlignment.spaceEvenly,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  BoxedIcon(realtimeData.weather.icon, size: 72),
                  SizedBox(width: 16),
                  Text('${realtimeData.weather.ambientTemperature.round()}°C', textScaleFactor: 3),
                ],
              ),
              Wrap(
                direction: Axis.vertical,
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      BoxedIcon(WeatherIcons.raindrop, color: Colors.lightBlue, size: 36),
                      SizedBox(width: 16),
                      Text('${realtimeData.weather.humidity.round()}%', textScaleFactor: 1.5),
                    ],
                  ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      BoxedIcon(WeatherIcons.strong_wind, size: 36),
                      SizedBox(width: 16),
                      Text('${realtimeData.weather.windSpeed.round()} km/h ${realtimeData.weather.windDirection}', textScaleFactor: 1.5),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(indent: 8, endIndent: 8),
        ListTile(
          title: Text(
              'OCCUPAZIONE AULE',
              style: TextStyle(color: Theme.of(context).colorScheme.secondary)
          ),
          subtitle: Text('Tempo medio di permanenza: ${realtimeData.realtimeSensorData.dwellTime.inMinutes} minuti'),
          trailing: OutlinedButton(
            child: const Text('VEDI MAPPA'),
            onPressed: () => null,
          ),
        ),
        for (var roomData in realtimeData.realtimeSensorData.roomsData)
          Padding(
            padding: EdgeInsets.only(
              left: 16, right: 16, top: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LinearProgressIndicator(
                  value: roomData.percentage.clamp(0, 1),
                  valueColor: AlwaysStoppedAnimation(roomData.color),
                  backgroundColor: Colors.grey.withOpacity(0.5),
                  minHeight: 10,
                ),
                SizedBox(height: 2),
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    Text('${roomData.room}', textScaleFactor: 1.2),
                    Text('${roomData.occupancy}/${roomData.room.capacity}', textScaleFactor: 1.2),
                  ],
                ),
              ],
            ),
          ),
        Padding(
          padding: EdgeInsets.only(
            left: 16, right: 16, top: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LinearProgressIndicator(
                value: realtimeData.realtimeSensorData.returnRate / 100,
                valueColor: AlwaysStoppedAnimation(Colors.blue),
                backgroundColor: Colors.grey.withOpacity(0.5),
                minHeight: 10,
              ),
              SizedBox(height: 2),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                children: [
                  Text('Tasso di ritorno', textScaleFactor: 1.2),
                  Text('${realtimeData.realtimeSensorData.returnRate.toStringAsFixed(2)}%', textScaleFactor: 1.2),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Divider(indent: 8, endIndent: 8),
        ListTile(
          title: Text(
              'PREVISIONI',
              style: TextStyle(color: Theme.of(context).colorScheme.secondary)
          ),
          subtitle: Text('Nel campus rispetto $_weekString precedenti'),
        ),
        if (!isVodafoneDataConsistent) ListTile(
          leading: Icon(Icons.error, color: Theme.of(context).errorColor),
          title: const Text('Attenzione! Le stime non sono consistenti'),
        ),
        // TODO: re-add tests
        /* if (isVodafoneDataConsistent) */ Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ComponentBarGraph(
                data: _getVisitorsByGender(realtimeData.neighborhoodVodafoneData),
                crossAxisSize: 10,
              ),
              SizedBox(height: 2),
              Text('Distribuzione genere', textScaleFactor: 1.2),
            ],
          ),
        ),
        /* if (isVodafoneDataConsistent) */ Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 16
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LinearProgressIndicator(
                value: foreignersPercentage / 100,
                backgroundColor: Colors.grey.withOpacity(0.5),
                minHeight: 10,
              ),
              SizedBox(height: 2),
              Text('Percentuale di stranieri: ${foreignersPercentage.toStringAsFixed(2)}%', textScaleFactor: 1.2),
            ],
          ),
        ),
        /* if (isVodafoneDataConsistent) */ Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LinearProgressIndicator(
                value: captureRatio / 100,
                backgroundColor: Colors.grey.withOpacity(0.5),
                minHeight: 10,
              ),
              SizedBox(height: 2),
              Text('Tasso di cattura: ${captureRatio.toStringAsFixed(2)}%', textScaleFactor: 1.2),
            ],
          ),
        ),
        SizedBox(height: 88),
      ],
    );
  }

  String get _weekString {
    final now = DateTime.now();
    return '${now.weekday == DateTime.sunday ? 'alle' : 'ai'} '
        '${now.weekday == DateTime.sunday ? 'domeniche' : _weekdayResolver.format(DateTime.now())}';
  }

  bool _isVodafoneDataConsistent(final VodafoneDailyList first, final VodafoneDailyList second) {
    return first.length > 0 && second.length > 0 && first.length == second.length;
  }

  List<_GenderGraphModelImplementation> _getVisitorsByGender(final VodafoneDailyList list, [double absorbNa = 0]) {
    final result = <_GenderGraphModelImplementation>[];
    for (var gender in Gender.values) {
      result.add(_GenderGraphModelImplementation(
        gender: gender,
        size: list.whereCondition((cluster) => cluster.gender == gender).visitors,
      ));
    }
    return result;
  }

  double _getForeignersPercentage(final VodafoneDailyList list) {
    double result = 0.0;
    list.forEach(
            (daily) => daily.forEach(
                (cluster) => cluster.nationality == Nationality.foreigner
                ? result += cluster.visitors
                : null
        )
    );
    return result / list.visitors * 100;
  }

}

class _GenderGraphModelImplementation implements ComponentBarGraphModel {

  const _GenderGraphModelImplementation({
    required this.gender,
    required this.size,
  });

  final Gender gender;
  final int size;

  @override
  Color get color => gender.color;

}

