import 'package:flutter/material.dart';

class ComponentFloatingAppBar extends StatelessWidget {

  const ComponentFloatingAppBar({
    this.leading,
    this.title,
    this.trailing,
    this.onTap,
  });

  final Widget? leading;
  final Widget? title;
  final List<Widget>? trailing;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      snap: true,
      floating: true,
      toolbarHeight: 68.0,
      foregroundColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      flexibleSpace: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        margin: EdgeInsets.symmetric(
          vertical: 6.0,
          horizontal: 12.0
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          child: ListTile(
            leading: leading,
            title: title,
            trailing: Wrap(
              children: trailing ?? [],
            ),
          ),
        ),
      ),
    );
  }

}
