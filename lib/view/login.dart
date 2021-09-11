import 'package:elis_analytics_dashboard/component/action_button.dart';
import 'package:flutter/material.dart';

class ViewLogin extends StatelessWidget {

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                  validator: (value) => (value ?? '').contains('@') && (value ?? '').contains('.')
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
                    onPressed: _onLoginPressed,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onLoginPressed() async {

  }

}
