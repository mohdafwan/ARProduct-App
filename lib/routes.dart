import 'package:flutter/material.dart';
import 'package:interior_design_arapp/features/admin/screens/add_product_screen.dart';
import 'package:interior_design_arapp/features/auth/screens/screen_auth.dart';
import 'package:interior_design_arapp/features/auth/screens/screen_auth.signin.dart';
import 'package:interior_design_arapp/features/home/screens/category_details_screen.dart';
import 'package:interior_design_arapp/features/home/screens/home_screen.dart';
import 'package:interior_design_arapp/features/productOn/product_details_screen.dart';
import 'package:interior_design_arapp/features/search/screens/search_screen.dart';
import 'package:interior_design_arapp/features/welcome/screens/screen_welcome.dart';
import 'package:interior_design_arapp/models/product.model.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case WelcomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const WelcomeScreen(),
      );
    case AuthScreenSignUp.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const AuthScreenSignUp(),
      );
    case AuthScreenSignIn.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const AuthScreenSignIn(),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const HomeScreen(),
      );
    // Admin Section
    case AddProductScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const AddProductScreen(),
      );
    case CategoryDetailsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => CategoryDetailsScreen(
          category: category,
        ),
      );
    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => SearchScreen(
          searchQuery: searchQuery,
        ),
      );
    case OnProductDetailsScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => OnProductDetailsScreen(
          product: product,
        ),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Text(
              "404 :)",
              style: TextStyle(fontSize: 40.0, color: Colors.white),
            ),
          ),
        ),
      );
  }
}
