// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class StarsBar extends StatelessWidget {
  final double rating;
  final double whatSize;
  const StarsBar({
    Key? key,
    required this.rating,
    this.whatSize = 15,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      direction: Axis.horizontal,
      itemCount: 5,
      rating: rating,
      itemSize: whatSize,
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Color.fromARGB(255, 255, 163, 59),
      ),
    );
  }
}
