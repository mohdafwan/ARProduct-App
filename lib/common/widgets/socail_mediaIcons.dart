import 'package:flutter/material.dart';

class SocialMediaLoginIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  const SocialMediaLoginIcon({
    Key? key,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      height: 50.0,
      decoration: const BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: color,
      ),
    );
  }
}
