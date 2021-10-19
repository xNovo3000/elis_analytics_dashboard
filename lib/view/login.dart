import 'package:elis_analytics_dashboard/component/action_button.dart';
import 'package:elis_analytics_dashboard/component/colored_app_bar.dart';
import 'package:elis_analytics_dashboard/foundation/fetcher.dart';
import 'package:elis_analytics_dashboard/model/enum/thingsboard_device.dart';
import 'package:elis_analytics_dashboard/model/exception/invalid_token.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class ViewLogin extends StatelessWidget {

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ColoredAppBar(
        title: Text('Login'),
      ),
      body: Form(
        key: formKey,
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.only(
                left: 8.0,
                right: 8.0,
                top: 12.0,
              ),
              sliver: SliverToBoxAdapter(
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                  validator: (value) =>
                  (value ?? '').contains('@') && (value ?? '').contains('.')
                    ? null : 'Non è un indirizzo email',
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(
                left: 8.0,
                right: 8.0,
                top: 12.0,
              ),
              sliver: SliverToBoxAdapter(
                child: TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                  validator: (value) => (value ?? '').length > 0
                    ? null : 'La password non può essere vuota',
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: ButtonBar(
                children: [
                  ComponentActionButton(
                    label: 'Login',
                    onPressed: () async => await _onLoginPressed(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onLoginPressed(BuildContext context) async {
    // Validate form
    if (!formKey.currentState!.validate()) {
      return;
    }
    // Set "Email" and "Password"
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('Email', emailController.text);
    await preferences.setString('Password', passwordController.text);
    // Generate vars
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final fetcher = Fetcher();
    final uri = Uri.parse('plugins/telemetry/DEVICE/${ThingsboardDevice.weatherStation}/values/timeseries');
    // Check if 200 OK
    try {
      final response = await fetcher.get(uri);
      if (response.statusCode == 200) {
        Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
      } else {
        scaffoldMessenger.showSnackBar(SnackBar(
          content: Text('Errore: codice ${response.statusCode}'),
        ));
      }
    } on InvalidTokenException catch (_) {
      scaffoldMessenger.showSnackBar(SnackBar(
        content: Text('Email o password errati'),
      ));
    } catch (_) {
      scaffoldMessenger.showSnackBar(SnackBar(
        content: Text('Non riesco a raggiungere il server'),
      ));
    }
  }

}
