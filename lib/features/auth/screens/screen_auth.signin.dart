import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:interior_design_arapp/common/widgets/custom_textbar.dart';
import 'package:interior_design_arapp/features/auth/screens/screen_auth.dart';
import 'package:interior_design_arapp/features/auth/services/auth.service.dart';

class AuthScreenSignIn extends StatefulWidget {
  static const String routeName = "auth-screen-signin";
  const AuthScreenSignIn({super.key});

  @override
  State<AuthScreenSignIn> createState() => _AuthScreenSignInState();
}

class _AuthScreenSignInState extends State<AuthScreenSignIn> {
  final _signInFromKey = GlobalKey<FormState>();
  final AuthServiceSignUp _authServiceSignIn = AuthServiceSignUp();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void signInUser() {
    if (_signInFromKey.currentState!.validate()) {
      _authServiceSignIn.signInUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Login.",
                  style: TextStyle(
                    fontFamily: 'rejoin',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 40,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    const Text(
                      'Create New Account',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "rejoin",
                        fontWeight: FontWeight.w100,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          AuthScreenSignUp.routeName,
                        );
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.blue,
                          fontFamily: 'rejoin',
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Form(
                key: _signInFromKey,
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    CustomTextField(
                      hintText: 'Email',
                      controller: _emailController,
                    ),
                    const SizedBox(height: 5),
                    CustomTextField(
                      hintText: 'Password',
                      controller: _passwordController,
                      obscureText: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          signInUser();
        },
        backgroundColor: Colors.white,
        disabledElevation: 0,
        child: const Icon(
          FontAwesomeIcons.arrowRight,
          color: Colors.blue,
        ),
      ),
    );
  }
}
