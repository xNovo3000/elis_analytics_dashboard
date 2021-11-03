import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class FragmentMap extends StatelessWidget {

  const FragmentMap({
    required this.mapShapeSource,
    this.canZoomPan = true,
  });

  final MapShapeSource mapShapeSource;
  final bool canZoomPan;

  @override
  Widget build(BuildContext context) {
    // Build Viewer
    return SfMapsTheme(
      data: SfMapsThemeData(
        dataLabelTextStyle: TextStyle(
          color: Colors.black,
        ),
      ),
      child: SfMaps(
        layers: [
          MapShapeLayer(
            source: mapShapeSource,
            showDataLabels: true,
            zoomPanBehavior: canZoomPan ? MapZoomPanBehavior() : null,
          ),
        ],
      )
    );
  }

}