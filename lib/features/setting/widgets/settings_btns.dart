// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class settings_button extends StatelessWidget {
  final String text;
  final IconData btnIcons;
  final void Function()? callback;

  const settings_button(
      {super.key, required this.text, required this.btnIcons, this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        // color: const Color.fromARGB(255, 184, 146, 212),\
        border: Border.all(
          color: const Color.fromARGB(255, 184, 146, 212),
          width: 2,
        ),
        color: Colors.black,
      ),
      margin: const EdgeInsets.only(left: 12, right: 12, bottom: 4),
      padding: const EdgeInsets.all(17),
      child: GestureDetector(
        onTap: callback,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'rejoin',
                fontWeight: FontWeight.w300,
                fontSize: 18,
              ),
            ),
            Icon(
              btnIcons,
              color: Colors.white,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
