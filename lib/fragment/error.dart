import 'package:flutter/material.dart';

class FragmentError extends StatelessWidget {

  const FragmentError({
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
