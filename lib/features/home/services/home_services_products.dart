import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:interior_design_arapp/constants/error_handler.dart';
import 'package:interior_design_arapp/constants/utils/snackBar.utils.dart';
import 'package:interior_design_arapp/models/product.model.dart';
import 'package:interior_design_arapp/providers/user.provider.dart';
import 'package:provider/provider.dart';

class HomeServicesAppProducts {
  Future<List<Product>> fetchAllProductsOnHomeScreen({
    required BuildContext context,
    String? showAllTheScreen,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
          Uri.parse('http://192.168.0.105:3000/api/products/homescreen'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          });
      ErrorHandler(
        context: context,
        response: res,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Product.fromJson(
                jsonEncode(jsonDecode(res.body)[i]),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }
}
