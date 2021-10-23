import 'package:flutter/material.dart';

class ColoredAppBar extends StatelessWidget implements PreferredSizeWidget {

  ColoredAppBar({
    Widget? title,
    List<Widget>? actions,
    PreferredSizeWidget? bottom,
  }) : widget = AppBar(
    title: title,
    actions: actions,
    bottom: bottom,
    foregroundColor: Colors.black,
    backgroundColor: Color(0xFFFAFAFA),
  );

  final AppBar widget;

  Widget build(BuildContext context) {
    return widget;
  }

  @override
  Size get preferredSize => widget.preferredSize;

}
