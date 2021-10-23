import 'package:elis_analytics_dashboard/component/colored_app_bar.dart';
import 'package:elis_analytics_dashboard/model/inherited/map_data.dart';
import 'package:elis_analytics_dashboard/view/error.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

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
        ? _ViewMapViewerSmartphoneData(mapShapeSource: mapData.mapShapeSource)
        : ViewError(error: 'Si è verificato un errore'),
    );
  }

}

class _ViewMapViewerSmartphoneData extends StatelessWidget {

  const _ViewMapViewerSmartphoneData({
    required this.mapShapeSource,
  });

  final MapShapeSource mapShapeSource;

  @override
  Widget build(BuildContext context) {
    // Build Viewer
    return SfMaps(
      layers: [
        MapShapeLayer(
          source: mapShapeSource,
          showDataLabels: true,
          zoomPanBehavior: MapZoomPanBehavior(),
        ),
      ],
    );
  }

}

