import 'package:flutter/material.dart';

class Authform extends StatelessWidget {
  const Authform({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(32),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              shadows: [
                BoxShadow(
                  color: const Color(0x0A000000),
                  blurRadius: 48,
                  offset: const Offset(0, 24),
                  spreadRadius: -12,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 24,
              children: [
                buildEmailField(),
                buildPasswordField(),
                buildLoginButton(),
                buildDivider(),
                buildSocialButtons(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildEmailField() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Email',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget buildPasswordField() {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget buildLoginButton() {
    return ElevatedButton(onPressed: () {}, child: const Text('Login'));
  }

  Widget buildDivider() {
    return const Row(
      children: [
        Expanded(child: Divider()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('Ou continuar com'),
        ),
        Expanded(child: Divider()),
      ],
    );
  }

  Widget buildSocialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
          icon: Image.asset(
            'assets/img/google-logo.png',
            width: 24,
            height: 24,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Image.asset('assets/img/ios-logo.png', width: 24, height: 24),
        ),
      ],
    );
  }
}
