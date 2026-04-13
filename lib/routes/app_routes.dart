import 'package:flutter/material.dart';
import 'package:shoplocal/features/auth/screens/collaboratoTypeScreen.dart';
import 'package:shoplocal/features/auth/screens/forgotPasswordScreen.dart';
import 'package:shoplocal/features/auth/screens/loginScreen.dart';
import 'package:shoplocal/features/auth/screens/profileSelectionScreen.dart';
import 'package:shoplocal/features/auth/screens/registerScreen.dart';
import 'package:shoplocal/features/cart/screens/cartScreen.dart';
import 'package:shoplocal/features/home/screens/categoriesScreen.dart';
import 'package:shoplocal/features/product/models/product_model.dart';
import 'package:shoplocal/features/home/screens/dashboardScreen.dart';
import 'package:shoplocal/features/product/screens/productDetailScreen.dart';
import 'package:shoplocal/features/profile/screens/profile_screen.dart';
import 'package:shoplocal/features/store/screens/partnerStoresScreen.dart';
import 'package:shoplocal/features/store/screens/StoreProductsScreen.dart';

class AppRoutes {
  static const String profileSelection = '/';
  static const String collaboratorType = '/collaborator-type';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot';
  static const String dashboard = '/dashboard';
  static const String categories = '/categories';
  static const String partnerStores = '/partner-stores';
  static const String storeProducts = '/store-products';
  static const String productDetail = '/product-detail';
  static const String cart = '/cart';
  static const String profile = '/profile';

  static Map<String, WidgetBuilder> get routes => {
    profileSelection: (context) => const ProfileSelectionScreen(),
    collaboratorType: (context) => const CollaboratorTypeScreen(),
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterScreen(),
    forgotPassword: (context) => const ForgotPasswordScreen(),
    dashboard: (context) => const Dashboard(),
    categories: (context) => const CategoriesScreen(),
    partnerStores: (context) => const PartnerStoresScreen(),
    storeProducts: (context) => const StoreProductsScreen(),
    productDetail: (context) {
      final args = ModalRoute.of(context)?.settings.arguments;
      final product = args is Product ? args : ProductMocks.decorLamp;
      return ProductDetailScreen(product: product);
    },
    cart: (context) => const CartScreen(),
    profile: (context) => const ProfileScreen(),
  };
}
