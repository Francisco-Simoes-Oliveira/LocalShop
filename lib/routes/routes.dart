import 'package:flutter/material.dart';
import 'package:shoplocal/features/auth/screens/collaboratoTypeScreen.dart';
import 'package:shoplocal/features/auth/screens/profileSelectionScreen.dart';
import 'package:shoplocal/features/auth/screens/loginScreen.dart';

class Routes {
  static String profileSelection = '/';
  static String collaboratorType = '/collaborator-type';
  static String login = '/login';

  static Map<String, WidgetBuilder> get routes => {
    profileSelection: (context) => const Profileselectionscreen(),
    collaboratorType: (context) => const Collaboratotypescreen(),
    login: (context) => const LoginScreen(),
  };
}
