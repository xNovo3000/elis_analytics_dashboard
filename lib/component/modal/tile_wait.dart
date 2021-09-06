import 'package:flutter/material.dart';

class ComponentModalTileWait extends StatelessWidget {

  const ComponentModalTileWait([this.customMessage]);

  final String? customMessage;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        child: const CircularProgressIndicator(),
      ),
      title: Text(customMessage ?? 'Attendere prego'),
    );
  }

}
