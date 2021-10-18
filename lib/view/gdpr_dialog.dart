import 'package:elis_analytics_dashboard/component/managed_future_builder.dart';
import 'package:elis_analytics_dashboard/fragment/error.dart';
import 'package:elis_analytics_dashboard/fragment/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ViewGdprDialog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              children: [
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 16),
                      Text('GDPR compliance', textScaleFactor: 2),
                      SizedBox(height: 16),
                      Expanded(
                        child: ComponentManagedFutureBuilder<String>(
                          future: _getGDPRLicense(),
                          onSuccess: (context, data) => ListView(
                            children: [
                              Text(data, maxLines: null),
                            ],
                          ),
                          onWait: (context) => FragmentWait(message: 'Attendi'),
                          onError: (context, error) => FragmentError(error: '$error'),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
              ],
            ),
          ),
          ButtonBar(
            children: [
              TextButton(
                child: Text('CHIUDI'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<String> _getGDPRLicense() async =>
    await rootBundle.loadString('asset/license/GDPR/DIALOG.txt');

}
