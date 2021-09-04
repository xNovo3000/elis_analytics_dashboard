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
