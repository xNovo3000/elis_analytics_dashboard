import 'package:flutter/material.dart';

class ComponentBarGraph extends StatelessWidget {

  static const _flexResolution = 100;

  const ComponentBarGraph({
    this.axis = Axis.horizontal,
    this.crossAxisSize = 8,
    this.borderRadius = 2,
    required this.data,
  });

  final Axis axis;
  final double crossAxisSize;
  final double borderRadius;
  final Iterable<ComponentBarGraphModel> data;

  @override
  Widget build(BuildContext context) {
    // Generate _CollapsedData
    final collapsed = <_CollapsedData>[];
    int total = 0;
    // If total == 0, then show all grey
    if (total <= 0) {
      // TODO: show grey graph
    }
    data.forEach((model) => total += model.size);
    data.forEach((model) => collapsed.add(_CollapsedData(
      percentage: model.size / total * _flexResolution,
      color: model.color,
    )));
    // TODO: add vertical graph
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).disabledColor
      ),
      width: double.infinity, height: crossAxisSize,
      child: Row(
        children: [
          for (var data in collapsed)
            Expanded(
              flex: data.percentage.round(),
              child: Container(
                decoration: BoxDecoration(
                  color: data.color,
                ),
                width: double.infinity, height: double.infinity,
              ),
            ),
        ],
      ),
    );
  }

}

abstract class ComponentBarGraphModel {
  int get size;
  Color get color;
}

class _CollapsedData {

  const _CollapsedData({
    required this.percentage,
    required this.color,
  });

  final double percentage;
  final Color color;

  @override
  String toString() => '_CollapsedData(percentage: $percentage, color: $color)';

  @override
  bool operator ==(Object other) => other is _CollapsedData
    ? percentage == other.percentage && color == other.color
    : false;

  @override
  int get hashCode => percentage.hashCode + color.hashCode;

}
