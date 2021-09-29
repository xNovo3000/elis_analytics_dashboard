import 'package:elis_analytics_dashboard/model/container/vodafone_daily.dart';
import 'package:elis_analytics_dashboard/model/data/vodafone_cluster.dart';
import 'package:elis_analytics_dashboard/model/enum/region.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class ComponentButtonNavigateToRegionMapViewer extends StatelessWidget {

  static final _mapNumberFormat = NumberFormat('###,###,##0');

  const ComponentButtonNavigateToRegionMapViewer({
    required this.topLevelRoute,
    required this.vodafoneDaily,
  });

  final String topLevelRoute;
  final VodafoneDaily vodafoneDaily;

  @override
  Widget build(BuildContext context) {
    // Cache results
    final total = vodafoneDaily.visitors;
    // Build button
    return OutlinedButton(
      child: Text('VEDI MAPPA'),
      onPressed: () => Navigator.of(context).pushNamed(
          '/$topLevelRoute/region_map',
          arguments: {
            'title': 'Mappa delle provenienze',
            'map_shape_source': MapShapeSource.asset(
              'assets/maps/italy.geojson',
              shapeDataField: 'reg_name',
              dataCount: 20,
              primaryValueMapper: (index) => Region.values[index].name,
              dataLabelMapper: (index) => _mapNumberFormat.format(
                vodafoneDaily.singleWhere(
                  (cluster) => cluster.region == Region.values[index],
                  orElse: () => VodafoneCluster.empty(),
                ).visitors
              ),
              shapeColorValueMapper: (index) => _getRegionColorByPercentage(
                visitors: vodafoneDaily.singleWhere(
                  (cluster) => cluster.region == Region.values[index],
                  orElse: () => VodafoneCluster.empty(),
                ).visitors,
                total: total,
              ),
            ),
          }
      ),
    );
  }

  Color? _getRegionColorByPercentage({
    required int visitors,
    required int total,
  }) {
    // Cache percentage
    final percentage = visitors / total;
    // Generate color
    if (percentage > 0.9) {
      return Colors.red;
    } else if (percentage > 0.75) {
      return Colors.yellow;
    } else if (percentage > 0.5) {
      return Colors.green;
    } else if (percentage > 0) {
      return Colors.blue;
    }
  }

}
