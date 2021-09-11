import 'package:flutter/material.dart';

class ComponentModalTileError extends StatelessWidget {

  const ComponentModalTileError({
    required this.error,
  });

  final String error;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.error, color: Theme.of(context).colorScheme.onError),
      title: Text(error),
    );
  }

}
