import 'package:elis_analytics_dashboard/component/modal/fullscreen/error.dart';
import 'package:elis_analytics_dashboard/component/modal/fullscreen/wait.dart';
import 'package:elis_analytics_dashboard/model/inherited/error.dart';
import 'package:elis_analytics_dashboard/model/inherited/map_data.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class ViewMapViewerSmartphone extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Check data
    final mapData = ModelInheritedMapData.maybeOf(context);
    final error = ModelInheritedError.maybeOf(context);
    // Build the view
    return Scaffold(
      appBar: AppBar(
        title: Text(mapData != null ? mapData.title : 'Visualizza mappa'),
      ),
      body: mapData != null
        ? _ViewMapViewerSmartphoneData()
        : error != null
          ? ComponentModalFullscreenError(error: error.error)
          : ComponentModalFullscreenWait(),
    );
  }

}

class _ViewMapViewerSmartphoneData extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Get the data
    final mapData = ModelInheritedMapData.of(context);
    // Build UI
    return SfMaps(
      layers: [
        MapShapeLayer(
          source: mapData.mapShapeSource,
          showDataLabels: true,
          zoomPanBehavior: MapZoomPanBehavior(),
        ),
      ],
    );
  }

}

