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
  );

  final AppBar widget;

  Widget build(BuildContext context) {
    return Theme(
      data: _appBarTheme,
      child: widget,
    );
  }

  @override
  Size get preferredSize => widget.preferredSize;

  static const _whiteBackgroundColor = Color(0xFFFAFAFA);

  static final _appBarTheme = ThemeData(
    fontFamily: 'OpenSans',
    colorScheme: ColorScheme.light(
      primary: _whiteBackgroundColor,
      primaryVariant: _whiteBackgroundColor,
      onPrimary: Colors.black,
    ),
  );

}
