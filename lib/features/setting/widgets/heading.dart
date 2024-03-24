// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class HeadingText extends StatelessWidget {
  final String textitem;
  final double fontSize;
  final EdgeInsetsGeometry padding;
  final FontWeight weight;

  const HeadingText({
    Key? key,
    required this.textitem,
    required this.fontSize,
    required this.padding,
    required this.weight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: padding,
        child: Text(
          textitem,
          style: TextStyle(
            color: Color.fromARGB(255, 51, 50, 50),
            fontFamily: 'rejoin',
            fontWeight: weight,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
