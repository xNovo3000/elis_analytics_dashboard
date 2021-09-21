import 'package:elis_analytics_dashboard/component/modal/fullscreen/error.dart';
import 'package:elis_analytics_dashboard/component/modal/fullscreen/wait.dart';
import 'package:elis_analytics_dashboard/model/inherited/error.dart';
import 'package:elis_analytics_dashboard/model/inherited/weekly_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViewWeeklySmartphone extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Check for data
    final weeklyData = ModelInheritedWeeklyData.maybeOf(context);
    final error = ModelInheritedError.maybeOf(context);
    // Build UI
    return Scaffold(
      appBar: AppBar(
        title: Text('Visualizzazione settimanale'),
      ),
      body: weeklyData != null
        ? _ViewWeeklySmartphoneData(weekRange: (ModalRoute.of(context)!.settings.arguments as Map)['week'])
        : error != null
          ? ComponentModalFullscreenError(error: error.error)
          : ComponentModalFullscreenWait(),
    );
  }

}

class _ViewWeeklySmartphoneData extends StatelessWidget {

  static const _oneWeek = Duration(days: 7);
  static const _epsilonTime = Duration(microseconds: 1);
  static final _minimumDate = DateTime(2021, 6, 28);
  static final _startDateResolver = DateFormat('d', 'it');
  static final _endDateResolver = DateFormat('d/M/yyyy', 'it');

  const _ViewWeeklySmartphoneData({
    required this.weekRange,
  });

  final DateTimeRange weekRange;

  @override
  Widget build(BuildContext context) {
    // Retrieve data
    final weeklyData = ModelInheritedWeeklyData.of(context);
    // Build UI
    return ListView(
      key: PageStorageKey('_ViewWeeklySmartphoneDataList'),
      children: [
        ListTile(
          title: Text('${_startDateResolver.format(weekRange.start)}-${_endDateResolver.format(weekRange.end)}'),
          subtitle: const Text('Settimana'),
          trailing: Wrap(
            children: [

            ],
          ),
        ),
        Divider(indent: 8, endIndent: 8),
      ],
    );
  }

  bool get _canGoBackwardInTime => weekRange.start.subtract(_oneWeek).isAfter(_minimumDate);
  bool get _canGoForwardInTime => weekRange.end.add(_oneWeek).isBefore(DateTime.now());

}
