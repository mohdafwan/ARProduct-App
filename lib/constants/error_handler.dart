import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:interior_design_arapp/constants/utils/snackBar.utils.dart';

void ErrorHandler({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(context, jsonDecode(response.body)['msg']);
      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)['error']);
      break;
    default:
      return response.body.isEmpty
          ? CircularProgressIndicator()
          : showSnackBar(context, response.body);
  }
}
