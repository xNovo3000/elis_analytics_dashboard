import 'package:elis_analytics_dashboard/component/colored_app_bar.dart';
import 'package:elis_analytics_dashboard/fragment/map.dart';
import 'package:elis_analytics_dashboard/model/inherited/map_data.dart';
import 'package:elis_analytics_dashboard/view/error.dart';
import 'package:flutter/material.dart';

class ViewMapViewerSmartphone extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Check data
    final mapData = ModelInheritedMapData.maybeOf(context);
    // Build the view
    return Scaffold(
      appBar: ColoredAppBar(
        title: Text(mapData != null ? mapData.title : 'Visualizza mappa'),
      ),
      body: mapData != null
        ? FragmentMap(mapShapeSource: mapData.mapShapeSource)
        : ViewError(error: 'Si è verificato un errore'),
    );
  }

}
