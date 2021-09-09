import 'package:elis_analytics_dashboard/component/gender_bar.dart';
import 'package:elis_analytics_dashboard/model/inherited/realtime_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';

class ViewRealtimeSmartphoneData extends StatelessWidget {

  static final DateFormat _weekdayResolver = DateFormat('EEEE', 'it');

  @override
  Widget build(BuildContext context) {
    // Obtain data (always exists)
    final realtimeData = ModelInheritedRealtimeData.of(context);
    // Build the view
    return ListView(
      children: [
        ListTile(
          title: Text(
            'RAPPORTO METEO',
            style: TextStyle(color: Theme.of(context).accentColor)
          ),
          trailing: OutlinedButton(
            child: const Text('DETTAGLI'),
            onPressed: () => null,
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
            style: TextStyle(color: Theme.of(context).accentColor)
          ),
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
        SizedBox(height: 16),
        Divider(indent: 8, endIndent: 8),
        ListTile(
          title: Text(
            'PREVISIONI',
            style: TextStyle(color: Theme.of(context).accentColor)
          ),
          subtitle: Text('Rispetto $_weekString precedenti'),
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              ComponentGenderBar(
                data: realtimeData.campusVodafoneData.genderVisitors,
              ),
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
           '${_weekdayResolver.format(DateTime.now())}';
  }

}
