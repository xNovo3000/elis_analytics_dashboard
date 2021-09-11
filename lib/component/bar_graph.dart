import 'package:flutter/material.dart';

class ComponentBarGraph extends StatelessWidget {

  static const _flexResolution = 500;

  const ComponentBarGraph({
    this.axis = Axis.horizontal,
    this.crossAxisSize = 8,
    required this.data,
  });

  final Axis axis;
  final double crossAxisSize;
  final Iterable<ComponentBarGraphModel> data;

  @override
  Widget build(BuildContext context) {
    // Generate _CollapsedData
    final collapsed = <_CollapsedData>[];
    int total = 0;
    data.forEach((model) => total += model.size);
    data.forEach((model) => collapsed.add(_CollapsedData(
      fraction: model.size / total * _flexResolution,
      color: model.color,
    )));
    return axis == Axis.horizontal
      ? Container(
        decoration: BoxDecoration(
          color: Theme.of(context).disabledColor
        ),
        width: double.infinity, height: crossAxisSize,
        child: Row(
          children: [
            for (var data in collapsed)
              if (data.fraction.round() > 0) Expanded(
                flex: data.fraction.round(),
                child: Container(
                  decoration: BoxDecoration(
                    color: data.color,
                  ),
                  width: double.infinity, height: double.infinity,
                ),
              ),
            ],
          ),
        )
      : Container(
        decoration: BoxDecoration(
            color: Theme.of(context).disabledColor
        ),
        width: crossAxisSize, height: double.infinity,
        child: Column(
          children: [
            for (var data in collapsed)
              if (data.fraction.round() > 0) Expanded(
                flex: data.fraction.round(),
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
    required this.fraction,
    required this.color,
  });

  final double fraction;
  final Color color;

  @override
  String toString() => '_CollapsedData(fraction: $fraction, color: $color)';

  @override
  bool operator ==(Object other) =>
    other is _CollapsedData
      ? fraction == other.fraction && color == other.color
      : false;

  @override
  int get hashCode => fraction.hashCode + color.hashCode;

}
