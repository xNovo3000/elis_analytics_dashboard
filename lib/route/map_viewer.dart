import 'package:elis_analytics_dashboard/model/inherited/error.dart';
import 'package:elis_analytics_dashboard/model/inherited/map_data.dart';
import 'package:elis_analytics_dashboard/view/map_viewer_smartphone.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class RouteMapViewer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Create view (no need for ResponsiveLayout, smartphone only)
    final child = ViewMapViewerSmartphone();
    // Retrieve arguments
    final args = ModalRoute.of(context)?.settings.arguments;
    // Check for errors (and build error UI)
    if (
      args == null ||
      !(args is Map<String, dynamic>) ||
      !(args['title'] is String) ||
      !(args['map_shape_source'] is MapShapeSource)
    ) {
      return ModelInheritedError(
        error: 'Si è verificato un errore',
        child: child,
      );
    }
    // Build success UI
    return ModelInheritedMapData(
      title: args['title'],
      mapShapeSource: args['map_shape_source'],
      child: child,
    );
  }

}
