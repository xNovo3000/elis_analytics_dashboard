import 'package:flutter/material.dart';

enum _ResponsiveLayoutMode {
  smartphone, tablet, error
}

class ResponsiveLayout extends StatefulWidget {

  const ResponsiveLayout({
    required this.smartphoneWidget,
    this.tabletWidget,
  });

  final Widget smartphoneWidget;
  final Widget? tabletWidget;

  @override _ResponsiveLayoutState createState() => _ResponsiveLayoutState();

}

class _ResponsiveLayoutState extends State<ResponsiveLayout> with WidgetsBindingObserver {

  var _mode = _ResponsiveLayoutMode.smartphone;

  @override
  void initState() {
    super.initState();
    // Optimization when there is only one layout
    if (widget.tabletWidget != null && widget.tabletWidget != widget.smartphoneWidget) {
      WidgetsBinding.instance!.addObserver(this);
    }
  }

  @override
  void dispose() {
    // Optimization when there is only one layout
    if (widget.tabletWidget != null && widget.tabletWidget != widget.smartphoneWidget) {
      WidgetsBinding.instance!.removeObserver(this);
    }
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    // TODO: implement didChangeMetrics (use setState only when necessary)
  }

  @override
  Widget build(BuildContext context) {
    switch (_mode) {
      case _ResponsiveLayoutMode.smartphone:
        return widget.smartphoneWidget;
      case _ResponsiveLayoutMode.tablet:
        return widget.tabletWidget ?? widget.smartphoneWidget;
      case _ResponsiveLayoutMode.error:  // TODO: give error view
        return widget.smartphoneWidget;
    }
  }

}
