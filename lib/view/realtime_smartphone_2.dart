import 'package:elis_analytics_dashboard/component/colored_app_bar.dart';
import 'package:elis_analytics_dashboard/component/modal/fullscreen/error.dart';
import 'package:elis_analytics_dashboard/component/modal/fullscreen/wait.dart';
import 'package:elis_analytics_dashboard/model/inherited/error.dart';
import 'package:elis_analytics_dashboard/model/inherited/realtime_data.dart';
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
          ? ComponentModalFullscreenError(error: error.error)
          : ComponentModalFullscreenWait(),
    );
  }

}

class _ViewRealtimeSmartphoneData extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Get data
    final data = ModelInheritedRealtimeData.maybeOf(context);
    final majorTextStyle = TextStyle(color: Theme.of(context).colorScheme.primary);
    // Build UI
    return CustomScrollView(
      key: PageStorageKey('_ViewRealtimeSmartphoneDataCustomScrollView'),
      slivers: [
        SliverPadding(
          padding: EdgeInsets.all(16),
          sliver: SliverToBoxAdapter(
            child: Text('MONITORAGGIO OCCUPAZIONE ANTIASSEMBRAMENTO', style: majorTextStyle),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverToBoxAdapter(
            child: Row(
              children: [
                Expanded(
                  child: Card(
                    child: Text('Ciao'),
                    margin: EdgeInsets.zero,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Card(
                    child: Text('Ciao'),
                    margin: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

}

