import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ModelInheritedHomeData extends InheritedWidget {

  const ModelInheritedHomeData({
    required Widget child,
    required this.lastWeekRange,
  }) : super(child: child);

  final DateTimeRange lastWeekRange;

  static ModelInheritedHomeData of(BuildContext context) =>
    context.dependOnInheritedWidgetOfExactType<ModelInheritedHomeData>()!;

  static ModelInheritedHomeData? maybeOf(BuildContext context) =>
    context.dependOnInheritedWidgetOfExactType<ModelInheritedHomeData>();

  @override
  bool updateShouldNotify(ModelInheritedHomeData old) =>
    lastWeekRange != old.lastWeekRange;

}