import 'package:elis_analytics_dashboard/model/container/vodafone_daily.dart';
import 'package:elis_analytics_dashboard/model/data/sensor.dart';
import 'package:elis_analytics_dashboard/model/data/vodafone_cluster.dart';
import 'package:elis_analytics_dashboard/model/data/weather_instant.dart';
import 'package:elis_analytics_dashboard/model/enum/kpi.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class ComponentNonPassingRoomsOccupancy extends StatelessWidget {

  const ComponentNonPassingRoomsOccupancy({
    required this.sensorData,
  });

  final SensorData sensorData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text('PRESENZE NELLE AULE', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
        ),
        for (var roomData in sensorData.roomsData)
          if (!roomData.room.passing)
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
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
        SizedBox(height: 12),
      ],
    );
  }

}

class ComponentPassingRoomsOccupancy extends StatelessWidget {

  const ComponentPassingRoomsOccupancy({
    required this.sensorData,
  });

  final SensorData sensorData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text('PASSANTI', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
        ),
        for (var roomData in sensorData.roomsData)
          if (roomData.room.passing)
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
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
        SizedBox(height: 12),
      ],
    );
  }

}

class ComponentRoomStats extends StatelessWidget {

  const ComponentRoomStats({
    required this.sensorData,
  });

  final SensorData sensorData;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(
          title: Text('OCCUPAZIONE AULE', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
        ),
        LinearProgressIndicator(
          value: (sensorData.returnRate / 100).clamp(0, 1),
          backgroundColor: Colors.grey.withOpacity(0.5),
          minHeight: 10,
        ),
        SizedBox(height: 2),
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: [
            Text('Tasso di ritorno', textScaleFactor: 1.2),
            Text('${(sensorData.returnRate / 100).toStringAsFixed(2)}%', textScaleFactor: 1.2),
          ],
        ),
        ListTile(
          title: Text('${sensorData.dwellTime.inMinutes}:${(sensorData.dwellTime.inSeconds / sensorData.dwellTime.inMinutes).floor()} minuti'),
          subtitle: Text('Tempo medio di permanenza'),
        ),
      ],
    );
  }

}

class ComponentVodafonePrediction extends StatelessWidget {

  const ComponentVodafonePrediction({
    required this.vodafoneCampus,
    required this.vodafoneNeighborhood,
  });

  final VodafoneDaily vodafoneCampus;
  final VodafoneDaily vodafoneNeighborhood;

  @override
  Widget build(BuildContext context) {
    // Calculations
    final vodafoneCampusVisitors = vodafoneCampus.visitors;
    final genderList = vodafoneCampus.collapseFromKPI(KPI.gender);
    final captureRatio = vodafoneCampusVisitors / vodafoneNeighborhood.visitors;
    double ageAverage = 0;
    final ageList = vodafoneCampus.collapseFromKPI(KPI.age);
    for (var ageValue in ageList) {
      ageAverage += ageValue.age.median * ageValue.visitors;
    }
    ageAverage /= ageList.visitors;
    // Build UI
    return Column(
      children: [
        ListTile(
          title: Text('MODELLO PREVISIONALE', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
        ),
        Padding(
          padding: EdgeInsets.only(top: 16, left: 16, right: 16),
          child: Row(
            children: [
              Column(
                children: [
                  SfCircularChart(
                    series: [],
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    Text('Sesso'),
                    SizedBox(height: 2),
                    SfCircularChart(
                      series: [
                        PieSeries<VodafoneCluster, String>(
                          dataSource: genderList,
                          xValueMapper: (datum, index) => '${datum.gender}',
                          yValueMapper: (datum, index) => datum.visitors / vodafoneCampusVisitors,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    Text('Sesso'),
                    SizedBox(height: 2),
                    SfCircularChart(
                      series: [
                        RadialBarSeries<double, String>(
                          dataSource: [captureRatio],
                          xValueMapper: (datum, index) => 'Tasso di cattura',
                          yValueMapper: (datum, index) => datum,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        ListTile(
          title: Text('${ageAverage.round()} anni'),
          subtitle: Text('Età media nel campus'),
        ),
      ],
    );
  }

}

class ComponentWeatherReport extends StatelessWidget {

  const ComponentWeatherReport({
    required this.weatherInstant,
  });

  final WeatherInstant weatherInstant;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text('RAPPORTO METEO', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
          trailing: OutlinedButton(
            child: const Text('DETTAGLI'),
            onPressed: () => Navigator.pushNamed(
              context,
              '/realtime/weather_report',
              arguments: {
                'weather_report': weatherInstant,
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
                  BoxedIcon(weatherInstant.icon, size: 48),
                  SizedBox(width: 16),
                  Text('${weatherInstant.ambientTemperature.round()}°C', textScaleFactor: 2.5),
                ],
              ),
              Wrap(
                direction: Axis.vertical,
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      BoxedIcon(WeatherIcons.raindrop, color: Colors.lightBlue, size: 24),
                      SizedBox(width: 16),
                      Text('${weatherInstant.humidity.round()}%', textScaleFactor: 1.25),
                    ],
                  ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      BoxedIcon(WeatherIcons.strong_wind, size: 24),
                      SizedBox(width: 16),
                      Text('${weatherInstant.windSpeed.round()} km/h ${weatherInstant.windDirection}', textScaleFactor: 1.25),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

}

