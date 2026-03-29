import 'package:flutter/material.dart';
import 'package:shoplocal/features/auth/screens/collaboratoTypeScreen.dart';
import 'package:shoplocal/features/auth/screens/profileSelectionScreen.dart';
import 'package:shoplocal/features/auth/screens/loginScreen.dart';
import 'package:shoplocal/features/auth/screens/registerScreen.dart';
import 'package:shoplocal/features/auth/screens/forgotPasswordScreen.dart';
import 'package:shoplocal/features/home/screens/categoriesScreen.dart';
import 'package:shoplocal/features/home/screens/dashboardScreen.dart';

class Routes {
  static String profileSelection = '/';
  static String collaboratorType = '/collaborator-type';
  static String login = '/login';
  static String register = '/register';
  static String forgotPassword = '/forgot';
  static String dashboard = '/dashboard';
  static String categories = '/categories';

  static Map<String, WidgetBuilder> get routes => {
    profileSelection: (context) => const Profileselectionscreen(),
    collaboratorType: (context) => const Collaboratotypescreen(),
    login: (context) => const LoginScreen(),
    register: (context) => const Registerscreen(),
    forgotPassword: (context) => const ForgotPasswordScreen(),

    dashboard: (context) => const Dashboard(),
    categories: (context) => const CategoriesScreen(),
  };
}
