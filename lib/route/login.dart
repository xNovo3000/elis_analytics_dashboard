import 'package:flutter/material.dart';

class RouteLogin extends StatelessWidget {

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
                  _LoginButton(
                    email: emailController.text,
                    password: passwordController.text,
                    formKey: formKey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class _LoginButton extends StatefulWidget {

  const _LoginButton({
    required this.email,
    required this.password,
    required this.formKey,
  });

  final String email;
  final String password;
  final GlobalKey<FormState> formKey;

  @override _LoginButtonState createState() => _LoginButtonState();

}

class _LoginButtonState extends State<_LoginButton> {

  bool _isLoggingIn = false;

  @override
  Widget build(BuildContext context) {
    return _isLoggingIn
      ? ElevatedButton.icon(
        label: const Text('Login'),
        icon: const CircularProgressIndicator(),
        onPressed: null,
      )
      : ElevatedButton(
        child: const Text('Login'),
        onPressed: _onLoginPressed,
      );
  }

  Future<void> _onLoginPressed() async {
    // TODO: login logic here
  }

}

