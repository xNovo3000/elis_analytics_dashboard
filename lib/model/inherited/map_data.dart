import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class ModelInheritedMapData extends InheritedWidget {

  const ModelInheritedMapData({
    required this.title,
    required this.mapShapeSource,
    required Widget child,
  }) : super(child: child);

  final String title;
  final MapShapeSource mapShapeSource;

  static ModelInheritedMapData of(BuildContext context) =>
    context.dependOnInheritedWidgetOfExactType<ModelInheritedMapData>()!;

  static ModelInheritedMapData? maybeOf(BuildContext context) =>
    context.dependOnInheritedWidgetOfExactType<ModelInheritedMapData>();

  @override
  bool updateShouldNotify(ModelInheritedMapData old) {
    return title != old.title || mapShapeSource != old.mapShapeSource;
  }

}