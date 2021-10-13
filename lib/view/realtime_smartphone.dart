import 'package:elis_analytics_dashboard/component/colored_app_bar.dart';
import 'package:elis_analytics_dashboard/component/modal/fullscreen/error.dart';
import 'package:elis_analytics_dashboard/component/modal/fullscreen/wait.dart';
import 'package:elis_analytics_dashboard/fragment/realtime/dynamic_rooms_list.dart';
import 'package:elis_analytics_dashboard/fragment/realtime/expectations.dart';
import 'package:elis_analytics_dashboard/fragment/realtime/sensor_dwell_time.dart';
import 'package:elis_analytics_dashboard/fragment/realtime/static_rooms_list.dart';
import 'package:elis_analytics_dashboard/fragment/realtime/weather_report.dart';
import 'package:elis_analytics_dashboard/model/container/vodafone_daily.dart';
import 'package:elis_analytics_dashboard/model/container/vodafone_daily_list.dart';
import 'package:elis_analytics_dashboard/model/data/sensor.dart';
import 'package:elis_analytics_dashboard/model/data/vodafone_cluster.dart';
import 'package:elis_analytics_dashboard/model/data/weather_instant.dart';
import 'package:elis_analytics_dashboard/model/enum/kpi.dart';
import 'package:elis_analytics_dashboard/model/enum/nationality.dart';
import 'package:elis_analytics_dashboard/model/enum/room.dart';
import 'package:elis_analytics_dashboard/model/inherited/error.dart';
import 'package:elis_analytics_dashboard/model/inherited/realtime_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weather_icons/weather_icons.dart';

class ViewRealtimeSmartphone extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Check data
    final data = ModelInheritedRealtimeData.maybeOf(context);
    final error = ModelInheritedError.maybeOf(context);
    // Build UI
    return Scaffold(
      appBar: ColoredAppBar(
        title: Text('Visualizzazione in tempo reale'),
      ),
      body: data != null
        ? _ViewRealtimeSmartphoneData()
        : error != null
          ? ComponentModalFullscreenError(error: error.error)
          : ComponentModalFullscreenWait(),
    );
  }

}

class _ViewRealtimeSmartphoneData extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Get data
    final data = ModelInheritedRealtimeData.of(context);
    // Build UI
    return CustomScrollView(
      key: PageStorageKey('_ViewRealtimeSmartphoneDataCustomScrollView'),
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'MONITORAGGIO OCCUPAZIONE ANTIASSEMBRAMENTO',
                  style: TextStyle(color: Theme.of(context).colorScheme.primary),
                  maxLines: null,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: FragmentRealtimeStaticRoomsList(
                  sensorData: data.realtimeSensorData,
                  direction: Axis.horizontal,
                ),
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'MONITORAGGIO FLUSSO PASSANTI IN 10 MINUTI',
                  style: TextStyle(color: Theme.of(context).colorScheme.primary),
                  maxLines: null,
                ),
              ),
              SizedBox(
                width: double.infinity, height: 200,
                child: FragmentRealtimeDynamicRoomsList(
                  sensorData: data.realtimeSensorData,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: FragmentRealtimeSensorDwellTime(
            sensorData: data.realtimeSensorData,
          ),
        ),
        SliverToBoxAdapter(
          child: Divider(indent: 8, endIndent: 8, height: 1, thickness: 1),
        ),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  'RAPPORTO METEO',
                  style: TextStyle(color: Theme.of(context).colorScheme.primary),
                  maxLines: null,
                ),
              ),
              FragmentRealtimeWeatherReport(
                weatherInstant: data.weather,
              )
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Divider(indent: 8, endIndent: 8, height: 1, thickness: 1),
        ),
        SliverToBoxAdapter(
          child: FragmentRealtimeExpectations(
            campusVodafoneData: data.campusVodafoneData,
            neighborhoodVodafoneData: data.neighborhoodVodafoneData,
          ),
        ),
      ],
    );
  }

}
