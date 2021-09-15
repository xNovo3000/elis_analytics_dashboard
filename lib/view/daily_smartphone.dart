import 'package:elis_analytics_dashboard/component/modal/fullscreen/error.dart';
import 'package:elis_analytics_dashboard/component/modal/fullscreen/wait.dart';
import 'package:elis_analytics_dashboard/model/inherited/daily_data.dart';
import 'package:elis_analytics_dashboard/model/inherited/error.dart';
import 'package:flutter/material.dart';

class ViewDailySmartphone extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Check data
    final error = ModelInheritedError.maybeOf(context);
    final data = ModelInheritedDailyData.maybeOf(context);
    // Build UI
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visualizzazione giornaliera'),
      ),
      body: data != null
        ? _ViewDailySmartphoneData(
          day: (ModalRoute.of(context)!.settings.arguments as Map)['day']
        )
        : error != null
          ? ComponentModalFullscreenError(error: error.error)
          : ComponentModalFullscreenWait(),
    );
  }

}

class _ViewDailySmartphoneData extends StatelessWidget {

  const _ViewDailySmartphoneData({
    required this.day,
  });

  final DateTime day;

  @override
  Widget build(BuildContext context) {
    // Extract data
    final data = ModelInheritedDailyData.of(context);
    // Build UI
    return ListView(
      key: PageStorageKey('_ViewDailySmartphoneDataList'),
      children: [],
    );
  }

}

