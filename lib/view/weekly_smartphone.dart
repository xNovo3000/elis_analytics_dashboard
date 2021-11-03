import 'package:elis_analytics_dashboard/component/colored_app_bar.dart';
import 'package:elis_analytics_dashboard/fragment/daily/gender_chart.dart';
import 'package:elis_analytics_dashboard/fragment/view.dart';
import 'package:elis_analytics_dashboard/fragment/vodafone_summary.dart';
import 'package:elis_analytics_dashboard/fragment/weekly/appbar_bottom_date.dart';
import 'package:elis_analytics_dashboard/fragment/weekly/kpi_comparator_smartphone.dart';
import 'package:elis_analytics_dashboard/fragment/weekly/map_manager.dart';
import 'package:elis_analytics_dashboard/fragment/weekly/weather_report_smartphone.dart';
import 'package:elis_analytics_dashboard/model/data/vodafone_cluster.dart';
import 'package:elis_analytics_dashboard/model/inherited/error.dart';
import 'package:elis_analytics_dashboard/model/inherited/weekly_data.dart';
import 'package:elis_analytics_dashboard/view/error.dart';
import 'package:elis_analytics_dashboard/view/wait.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewWeeklySmartphone extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Check error
    final error = ModelInheritedError.maybeOf(context);
    if (error != null) {
      return _ViewWeeklySmartphoneError(
        error: error.error,
      );
    }
    // Get week and weekRange
    final week = (ModalRoute.of(context)!.settings.arguments as Map)['week'] as DateTimeRange;
    final lastWeekRange = (ModalRoute.of(context)!.settings.arguments as Map)['last_available_week'] as DateTimeRange;
    // Check data
    final data = ModelInheritedWeeklyData.maybeOf(context);
    // Build UI
    return Scaffold(
      appBar: ColoredAppBar(
        title: const Text('Visualizzazione settimanale'),
        bottom: FragmentWeeklyAppbarBottomDate(
          weekRange: week,
          lastAvailableWeekRange: lastWeekRange,
        ),
      ),
      body: data != null
        ? _ViewWeeklySmartphoneData(week: week)
        : ViewWait(),
    );
  }

}

class _ViewWeeklySmartphoneError extends StatelessWidget {

  const _ViewWeeklySmartphoneError({
    required this.error,
  });

  final String error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ColoredAppBar(
        title: Text('Visualizzazione settimanale'),
      ),
      body: ViewError(
        error: error,
      ),
    );
  }

}

class _ViewWeeklySmartphoneData extends StatelessWidget {

  const _ViewWeeklySmartphoneData({
    required this.week,
  });

  final DateTimeRange week;

  @override
  Widget build(BuildContext context) {
    // Get data
    final data = ModelInheritedWeeklyData.of(context);
    // Collapse
    final campusVodafone = data.campusVodafone.toVodafoneDaily();
    final neighborhoodVodafone = data.neighborhoodVodafone.toVodafoneDaily();
    // Build UI
    return CustomScrollView(
      key: PageStorageKey('_ViewWeeklySmartphoneDataCustomScrollView'),
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              ListTile(
                title: Text('RAPPORTO METEO', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
              ),
              FragmentWeeklyWeatherReportSmartphone(
                weathers: data.weathers,
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: FutureBuilder<SharedPreferences>(
            future: SharedPreferences.getInstance(),
            builder: (context, snapshot) => snapshot.hasData
              ? FragmentWeeklyKpiComparatorSmartphone(preferences: snapshot.data!)
              : FragmentWait(message: 'Attendi...'),
          ),
        ),
        SliverToBoxAdapter(
          child: FutureBuilder<SharedPreferences>(
            future: SharedPreferences.getInstance(),
            builder: (context, snapshot) => snapshot.hasData
              ? FragmentWeeklyMapManager(
                  preferences: snapshot.data!,
                  campusVodafoneByRegion: data.campusVodafone.collapse(VodafoneClusterAttribute.region, collapseNa: true),
                  neighborhoodVodafoneByRegion: data.neighborhoodVodafone.collapse(VodafoneClusterAttribute.region, collapseNa: true),
                )
              : FragmentWait(message: 'Attendi...'),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              ListTile(
                title: Text('RIASSUNTO GIORNALIERO', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
              ),
              FragmentVodafoneSummary(
                campusVodafone: campusVodafone,
                neighborhoodVodafone: neighborhoodVodafone
              ),
              ListTile(
                title: Text('SUDDIVISIONE PER GENERE', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
              ),
              FragmentDailyGenderChart(
                campusVodafoneByGender: campusVodafone.collapse(VodafoneClusterAttribute.gender, collapseNa: true),
              ),
            ]
          ),
        ),
      ],
    );
  }

}
