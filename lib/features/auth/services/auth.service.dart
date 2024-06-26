import 'dart:convert';
import 'package:interior_design_arapp/common/widgets/bottom_bar.dart';
import 'package:interior_design_arapp/features/home/screens/home_screen.dart';
import 'package:interior_design_arapp/providers/user.provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:interior_design_arapp/constants/error_handler.dart';
import 'package:interior_design_arapp/constants/utils/snackBar.utils.dart';
import 'package:interior_design_arapp/models/user.model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

void navigateToBottomBar(BuildContext context, int pageIndex) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => BottomBar(initialPage: pageIndex)),
  );
}

class AuthServiceSignUp {
  // signup for the user
  void signUpUser({
    required BuildContext context,
    required username,
    required email,
    required password,
  }) async {
    try {
      User user = User(
        id: "",
        username: username,
        email: email,
        password: password,
        address: "",
        type: "",
        token: "",
        cart: [],
      );

      http.Response res = await http.post(
        Uri.parse('https://arproduct-app-1.onrender.com/api/register'),
        body: user.toJson(),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
      );

      ErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          return showSnackBar(
            context,
            'Account created! Login with the same credential',
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('https://arproduct-app-1.onrender.com/api/login'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      ErrorHandler(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          final resData = jsonDecode(res.body);
          Provider.of<UserProvider>(context, listen: false)
              .setUser(jsonEncode(resData));
          await prefs.setString('x-auth-token', resData['token']);
          int pageIndex = 0;
          navigateToBottomBar(context, pageIndex);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // Current User
  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('https://arproduct-app-1.onrender.com/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);
      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('https://arproduct-app-1.onrender.com/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
