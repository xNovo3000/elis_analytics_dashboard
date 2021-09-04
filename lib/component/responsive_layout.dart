import 'package:flutter/material.dart';

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

  bool _isTabletMode = false;

  @override
  void initState() {
    super.initState();
    // Zero-call optimization
    if (widget.tabletWidget != null && widget.tabletWidget != widget.smartphoneWidget) {
      WidgetsBinding.instance!.addObserver(this);
    }
  }

  @override
  void dispose() {
    // Zero-call optimization
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
    return _isTabletMode
      ? (widget.tabletWidget ?? widget.smartphoneWidget)
      : widget.smartphoneWidget;
  }

}
