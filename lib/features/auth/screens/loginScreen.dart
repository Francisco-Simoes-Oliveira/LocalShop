import 'package:flutter/material.dart';
import 'package:shoplocal/core/widgets/custom_appBar.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomHeader(title: 'Login', actions: [Icon(Icons.login)]),
      body: const Center(child: Text('Login Screen')),
    );
  }
}
