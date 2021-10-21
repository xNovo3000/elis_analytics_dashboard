import 'package:elis_analytics_dashboard/component/colored_app_bar.dart';
import 'package:elis_analytics_dashboard/fragment/realtime/dynamic_rooms_list.dart';
import 'package:elis_analytics_dashboard/fragment/realtime/expectations.dart';
import 'package:elis_analytics_dashboard/fragment/realtime/sensor_dwell_time.dart';
import 'package:elis_analytics_dashboard/fragment/realtime/static_rooms_list.dart';
import 'package:elis_analytics_dashboard/fragment/realtime/weather_report.dart';
import 'package:elis_analytics_dashboard/model/inherited/error.dart';
import 'package:elis_analytics_dashboard/model/inherited/realtime_data.dart';
import 'package:elis_analytics_dashboard/view/error.dart';
import 'package:elis_analytics_dashboard/view/wait.dart';
import 'package:flutter/material.dart';

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
          ? ViewError(error: error.error)
          : ViewWait(),
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
                  sensorData: data.realtimeSensorAttendance,
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
                  sensorData: data.realtimeSensorVisits,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: FragmentRealtimeSensorDwellTime(
            sensorData: data.realtimeSensorVisits,
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
