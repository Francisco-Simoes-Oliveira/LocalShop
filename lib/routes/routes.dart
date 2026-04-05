import 'package:flutter/material.dart';
import 'package:shoplocal/routes/app_routes.dart';

class Routes {
  static const String profileSelection = AppRoutes.profileSelection;
  static const String collaboratorType = AppRoutes.collaboratorType;
  static const String login = AppRoutes.login;
  static const String register = AppRoutes.register;
  static const String forgotPassword = AppRoutes.forgotPassword;
  static const String dashboard = AppRoutes.dashboard;
  static const String categories = AppRoutes.categories;
  static const String partnerStores = AppRoutes.partnerStores;
  static const String storeProducts = AppRoutes.storeProducts;
  static const String productDetail = AppRoutes.productDetail;
  static const String cart = AppRoutes.cart;
  static const String profile = AppRoutes.profile;

  static Map<String, WidgetBuilder> get routes => AppRoutes.routes;
}
