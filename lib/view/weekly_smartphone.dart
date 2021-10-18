import 'package:elis_analytics_dashboard/component/colored_app_bar.dart';
import 'package:elis_analytics_dashboard/fragment/weekly/weather_report_smartphone.dart';
import 'package:elis_analytics_dashboard/model/inherited/error.dart';
import 'package:elis_analytics_dashboard/model/inherited/weekly_data.dart';
import 'package:elis_analytics_dashboard/view/error.dart';
import 'package:elis_analytics_dashboard/view/wait.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViewWeeklySmartphone extends StatelessWidget {

  static const _oneSecond = Duration(seconds: 1);
  static final _weekStartResolver = DateFormat('d', 'it');
  static final _weekEndResolver = DateFormat('d/M/yyyy', 'it');

  @override
  Widget build(BuildContext context) {
    // Get week
    final week = (ModalRoute.of(context)!.settings.arguments as Map)['week'] as DateTimeRange;
    // Check data
    final error = ModelInheritedError.maybeOf(context);
    final data = ModelInheritedWeeklyData.maybeOf(context);
    // Build UI
    return Scaffold(
      appBar: ColoredAppBar(
        title: const Text('Visualizzazione settimanale'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: ListTile(
            title: Text('${_weekStartResolver.format(week.start)}-${_weekEndResolver.format(week.end.subtract(_oneSecond))}'),
          ),
        ),
      ),
      body: data != null
        ? _ViewWeeklySmartphoneData(week: week)
        : error != null
          ? ViewError(error: error.error)
          : ViewWait(),
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
    // Check data
    final data = ModelInheritedWeeklyData.of(context);
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
                weatherDailyList: data.weathers,
              ),
            ],
          ),
        ),

      ],
    );
  }

}
