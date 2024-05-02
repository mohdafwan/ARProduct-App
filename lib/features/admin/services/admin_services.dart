import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:interior_design_arapp/constants/error_handler.dart';
import 'package:interior_design_arapp/constants/utils/snackBar.utils.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:interior_design_arapp/models/product.model.dart';
import 'package:http/http.dart' as http;
import 'package:interior_design_arapp/providers/user.provider.dart';
import 'package:provider/provider.dart';
import 'package:interior_design_arapp/models/order.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String threeName,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic("dwnwywbma", 'ckhoy0f6');
      List<String> imagesUrls = [];

      for (var i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imagesUrls.add(res.secureUrl);
      }

      Product product = Product(
        threeName: threeName,
        name: name,
        description: description,
        images: imagesUrls,
        price: price,
        quantity: quantity,
        category: category,
      );

      http.Response res = await http.post(
        Uri.parse('https://arproduct-app-1.onrender.com/admin/add-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: product.toJson(),
      );
      if (res.statusCode == 200) {
        showSnackBar(context, 'Product Added Successfully!');
        Navigator.pop(context);
      } else {
        showSnackBar(context, 'Failed to add product: ${res.reasonPhrase}');
      }
    } catch (e) {
      showSnackBar(context, 'Error occurred: $e');
      print('Error in sellProduct: $e');
    }
  }

  // get all the porduct
  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('https://arproduct-app-1.onrender.com/admin/get-products'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      ErrorHandler(
        response: res,
        context: context,
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
      log(e.toString());
    }
    return productList;
  }

  // delete product
  void deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('https://arproduct-app-1.onrender.com/admin/delete-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id,
        }),
      );

      ErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          onSuccess();
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // get all the userOrders
  Future<List<Order>> fetchAllOrders(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orderList = [];
    try {
      http.Response res = await http.get(
          Uri.parse('https://arproduct-app-1.onrender.com/admin/get-orders'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          });

      ErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            orderList.add(
              Order.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return orderList;
  }

  //
  void changeOrderStatus({
    required BuildContext context,
    required int status,
    required Order order,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse(
            'https://arproduct-app-1.onrender.com/admin/change-order-status'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': order.id,
          'status': status,
        }),
      );

      ErrorHandler(
        response: res,
        context: context,
        onSuccess: onSuccess,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
