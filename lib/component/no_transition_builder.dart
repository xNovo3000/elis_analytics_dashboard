import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NoTransitionBuilder extends PageTransitionsBuilder {

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child
  ) => child;

}