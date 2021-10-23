import 'package:elis_analytics_dashboard/component/colored_app_bar.dart';
import 'package:elis_analytics_dashboard/model/inherited/error.dart';
import 'package:elis_analytics_dashboard/model/inherited/home_data.dart';
import 'package:elis_analytics_dashboard/view/gdpr_dialog.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewHomeSmartphone extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Check the presence of data
    final homeData = ModelInheritedHomeData.maybeOf(context);
    final error = ModelInheritedError.maybeOf(context);
    // Build UI
    return Scaffold(
      appBar: ColoredAppBar(
        title: Text('ELIS Analytics Dashboard'),
      ),
      body: ListView(
        key: PageStorageKey('_ViewHomeSmartphoneList'),
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 12, top: 12, bottom: 12, right: 4),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image(image: AssetImage('asset/image/LOGO_GMOVE.png')),
                    margin: EdgeInsets.zero,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 8, top: 12, bottom: 12, right: 8),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image(image: AssetImage('asset/image/LOGO_NETCOM.png')),
                    margin: EdgeInsets.zero,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 12, top: 12, bottom: 12, left: 4),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image(image: AssetImage('asset/image/LOGO_VODAFONE.png')),
                    margin: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
          Divider(indent: 8, endIndent: 8),
          ListTile(
            leading: Icon(Icons.schedule),
            title: Text('Tempo reale'),
            subtitle: Text('Visualizza i dati in tempo reale'),
            trailing: IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () => _onRealtimeButtonClick(context),
            ),
          ),
          ListTile(
            leading: Icon(Icons.today),
            title: Text('Visualizzazione giornaliera'),
            subtitle: Text('Visualizza i dati elaborati a partire da ieri'),
            trailing: IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () => _onDailyButtonClick(context),
            ),
          ),
          ListTile(
            leading: Icon(Icons.date_range),
            title: Text('Visualizzazione settimanale'),
            subtitle: Text('Visualizza i dati dell\'ultima settimana disponibile'),
            trailing:
              homeData != null
                ? IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: () => _onWeeklyButtonClick(context, homeData.lastWeekRange),
                  )
                : error != null
                  ? Icon(Icons.error, color: Theme.of(context).colorScheme.error)
                  : SizedBox(
                      width: 24, height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
          ),
          ButtonBar(
            children: [
              OutlinedButton.icon(
                icon: Icon(Icons.logout),
                label: Text('Logout'),
                onPressed: () => _onLogoutButtonClick(context),
              ),
              OutlinedButton.icon(
                icon: Image(image: AssetImage('asset/image/GDPR.png'), width: 24, height: 24),
                label: Text('GDPR'),
                onPressed: () => _onGDPRButtonClick(context),
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.info),
                label: Text('Informazioni'),
                onPressed: () => _onInfoButtonClick(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onRealtimeButtonClick(BuildContext context) {
    Navigator.of(context).pushNamed('/realtime');
  }

  void _onDailyButtonClick(BuildContext context) {
    final now = DateTime.now().subtract(Duration(days: 1));
    Navigator.of(context).pushNamed('/daily', arguments: {
      'day': DateTime(now.year, now.month, now.day),
    });
  }

  void _onWeeklyButtonClick(BuildContext context, DateTimeRange lastWeekRange) {
    Navigator.of(context).pushNamed('/weekly', arguments: {
      'week': lastWeekRange,
    });
  }

  void _onGDPRButtonClick(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ViewGdprDialog(),
    );
  }

  Future<void> _onLogoutButtonClick(BuildContext context) async {
    // Remove "Email" and "Password"
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('Email');
    await preferences.remove('Password');
    // Go to login page
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
  }

  void _onInfoButtonClick(BuildContext context) {
    PackageInfo.fromPlatform().then((info) => showAboutDialog(
      context: context,
      applicationName: 'ELIS Analytics Dashboard',
      applicationVersion: info.version,
      applicationLegalese: '© 2021 ELIS Innovation Team',
      applicationIcon: Image(image: AssetImage('asset/image/Icon-512.png'), width: 48, height: 48),
    ));
  }

}
