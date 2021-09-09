import 'package:flutter/material.dart';

class ModelInheritedError extends InheritedWidget {

  ModelInheritedError({
    required Widget child,
    required this.error
  }) : super(key: ValueKey(error), child: child);

  final String error;

  static ModelInheritedError of(BuildContext context) =>
    context.dependOnInheritedWidgetOfExactType<ModelInheritedError>()!;

  static ModelInheritedError? maybeOf(BuildContext context) =>
    context.dependOnInheritedWidgetOfExactType<ModelInheritedError>();

  @override
  bool updateShouldNotify(ModelInheritedError old) {
    return error != old.error;
  }

}