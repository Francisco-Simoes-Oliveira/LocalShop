import 'package:flutter/material.dart';
import 'package:shoplocal/features/auth/screens/profileSelectionScreen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Profileselectionscreen(),
    );
  }
}
