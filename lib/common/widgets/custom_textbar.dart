import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: TextFormField(
        cursorColor: Colors.blue,
        strutStyle:
            const StrutStyle(fontFamily: 'rejoin', fontWeight: FontWeight.bold),
        style: TextStyle(
          color: Colors.white,
        ),
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Colors.white,
            ),
            hoverColor: Colors.blue,
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue))),
        validator: (val) {
          if (val == null || val.isEmpty) {
            return 'Enter you $hintText';
          }
          return null;
        },
      ),
    );
  }
}
