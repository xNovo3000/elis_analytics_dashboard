import 'package:flutter/material.dart';

class ComponentModalTileInfo extends StatelessWidget {

  const ComponentModalTileInfo({
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.error),
      title: Text(message),
    );
  }

}
