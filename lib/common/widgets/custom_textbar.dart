// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final Color? hindTextColor;
  final Color? textColor;
  final int? maxline;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.hindTextColor = Colors.white,
    this.textColor = Colors.white,
    this.maxline = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: TextFormField(
        cursorColor: Colors.blue,
        strutStyle:
            const StrutStyle(fontFamily: 'rejoin', fontWeight: FontWeight.bold),
        style: TextStyle(
          color: textColor,
        ),
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: hindTextColor,
            ),
            hoverColor: Colors.blue,
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
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
        maxLines: maxline,
      ),
    );
  }
}
