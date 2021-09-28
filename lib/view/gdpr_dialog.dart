import 'package:elis_analytics_dashboard/component/managed_future_builder.dart';
import 'package:elis_analytics_dashboard/component/modal/tile/error.dart';
import 'package:elis_analytics_dashboard/component/modal/tile/wait.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ViewGdprDialog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ListView(
        children: [
          Row(
            children: [
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 16),
                    Text('GDPR compliance', textScaleFactor: 2),
                    SizedBox(height: 16),
                    ComponentManagedFutureBuilder<String>(
                      future: _getGDPRLicense(),
                      onSuccess: (context, data) => Text(data, maxLines: null),
                      onWait: (context) => ComponentModalTileWait(message: 'Attendi'),
                      onError: (context, error) => ComponentModalTileError(error: '$error'),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
              SizedBox(width: 16),
            ],
          ),
        ],
      ),
    );
  }

  Future<String> _getGDPRLicense() async =>
    await rootBundle.loadString('assets/licenses/GDPR/DIALOG.txt');

}
