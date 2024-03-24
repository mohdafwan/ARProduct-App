import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:interior_design_arapp/common/widgets/custom_textbar.dart';
import 'package:interior_design_arapp/features/auth/screens/screen_auth.signin.dart';
import 'package:interior_design_arapp/features/auth/services/auth.service.dart';

class AuthScreenSignUp extends StatefulWidget {
  static const String routeName = 'auth-screen-signup';
  const AuthScreenSignUp({Key? key}) : super(key: key);

  @override
  State<AuthScreenSignUp> createState() => _AuthScreenSignUpState();
}

class _AuthScreenSignUpState extends State<AuthScreenSignUp> {
  final _signUpFormKey = GlobalKey<FormState>();
  final AuthServiceSignUp _authServiceSignUp = AuthServiceSignUp();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void signUpUser() {
    if (_signUpFormKey.currentState!.validate()) {
      _authServiceSignUp.signUpUser(
        context: context,
        username: _userNameController.text,
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
                  "Create new account",
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
                      'Already Have Account',
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
                            context, AuthScreenSignIn.routeName);
                      },
                      child: const Text(
                        'Log In',
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
                key: _signUpFormKey,
                child: Column(
                  children: [
                    CustomTextField(
                      hintText: 'Name',
                      controller: _userNameController,
                    ),
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
          signUpUser();
        },
        backgroundColor: Colors.white,
        focusColor: Colors.black,
        elevation: 0,
        child: const Icon(
          FontAwesomeIcons.arrowRight,
          color: Colors.blue,
        ),
      ),
    );
  }
}
