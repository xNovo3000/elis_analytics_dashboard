import 'package:elis_analytics_dashboard/model/container/vodafone_daily.dart';
import 'package:flutter/material.dart';

class FragmentDailyRegionChartSmartphone extends StatelessWidget {

  const FragmentDailyRegionChartSmartphone({
    required this.neighborhoodVodafoneByRegion,
  });

  final VodafoneDaily neighborhoodVodafoneByRegion;

  @override
  Widget build(BuildContext context) {
    // Calculate total
    final total = neighborhoodVodafoneByRegion.visitors;
    // Build UI
    return Column(
      children: [
        for (var cluster in neighborhoodVodafoneByRegion)
          Padding(
            padding: EdgeInsets.only(
              left: 16, right: 16, top: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LinearProgressIndicator(
                  value: cluster.visitors / total,
                  backgroundColor: Colors.grey.withOpacity(0.5),
                  minHeight: 10,
                ),
                SizedBox(height: 2),
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    Text('${cluster.region}: ${cluster.visitors}'),
                    Text('${(cluster.visitors / total * 100).toStringAsFixed(2)}%'),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }

}
