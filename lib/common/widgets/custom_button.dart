import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onClick;
  final Color Btnbg;
  final Color? textbg;

  const CustomButton({
    super.key,
    required this.text,
    required this.onClick,
    required this.Btnbg,
    this.textbg,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(
        onPressed: onClick,
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'rejoin',
            fontWeight: FontWeight.bold,
            color: textbg,
          ),
        ),
        style: ElevatedButton.styleFrom(
            backgroundColor: Btnbg,
            maximumSize: const Size(double.infinity, 40)),
      ),
    );
  }
}
