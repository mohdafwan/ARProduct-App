import 'package:flutter/material.dart';
import 'package:interior_design_arapp/features/auth/screens/screen_auth.dart';
import 'package:interior_design_arapp/features/auth/screens/screen_auth.signin.dart';
import 'package:interior_design_arapp/features/home/screens/home_screen.dart';
import 'package:interior_design_arapp/features/welcome/screens/screen_welcome.dart';

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
        builder: (context) => const HomeScreen() ,
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
