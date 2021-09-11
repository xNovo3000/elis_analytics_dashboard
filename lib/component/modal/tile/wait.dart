import 'package:flutter/material.dart';

class ComponentModalTileWait extends StatelessWidget {

  const ComponentModalTileWait({
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        width: 24, height: 24,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
      title: Text(message),
    );
  }

}
