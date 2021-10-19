import 'package:elis_analytics_dashboard/model/exception/invalid_token.dart';
import 'package:flutter/material.dart';

class ComponentManagedFutureBuilder<T> extends StatelessWidget {

  const ComponentManagedFutureBuilder({
    required this.future,
    required this.onSuccess,
    required this.onError,
    required this.onWait,
  });

  final Future<T>? future;
  final Widget Function(BuildContext context, T data) onSuccess;
  final Widget Function(BuildContext context, Object? error) onError;
  final Widget Function(BuildContext context) onWait;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          // If InvalidTokenException, then go to login page
          if (snapshot.error != null && snapshot.error is InvalidTokenException) {
            // Future necessary because runs after build method has finished building
            Future.delayed(const Duration(seconds: 0), () => Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false));
          }
          // Send error to the normal error builder
          return onError(context, snapshot.error);
        } else if (snapshot.hasData) {
          return onSuccess(context, snapshot.data!);
        } else {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return onError(context, 'ConnectionState.none');
            case ConnectionState.waiting:
            case ConnectionState.active:
              return onWait(context);
            case ConnectionState.done:
              if (snapshot.hasData) {
                return onSuccess(context, snapshot.data!);
              } else {
                return onError(context, null);
              }
          }
        }
      },
    );
  }

}
