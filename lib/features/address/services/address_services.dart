import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:interior_design_arapp/constants/error_handler.dart';
import 'package:interior_design_arapp/constants/utils/snackBar.utils.dart';
import 'package:http/http.dart' as http;
import 'package:interior_design_arapp/models/user.model.dart';
import 'package:interior_design_arapp/providers/user.provider.dart';
import 'package:provider/provider.dart';

class AddressServices {
  void saveUserAddress({
    required BuildContext context,
    required String address,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final response = await http.post(
        Uri.parse('https://arproduct-app-1.onrender.com/api/save-user-address'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'address': address,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        User updatedUser =
            userProvider.user.copyWith(address: responseData['address']);
        userProvider.setUserFromModel(updatedUser);
      } else {
        throw Exception('Failed to save address: ${response.statusCode}');
      }
    } catch (e) {
      showSnackBar(context, 'Error occurred: $e');
      print('Error in saveUserAddress: $e');
    }
  }

  void placeOrder({
    required BuildContext context,
    required String address,
    required double totalPrice,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      if (address.isEmpty) {
        throw Exception('Address is empty or null');
      }
      http.Response res = await http.post(
        Uri.parse('https://arproduct-app-1.onrender.com/api/order'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'cart': userProvider.user.cart,
          'address': address,
          'totalPrice': totalPrice,
        }),
      );
      ErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Your order has been placed!');
          User user = userProvider.user.copyWith(
            cart: [],
          );
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, 'Error occurred: $e');
    }
  }
}
