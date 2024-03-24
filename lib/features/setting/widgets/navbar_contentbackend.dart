import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:interior_design_arapp/providers/user.provider.dart';
import 'package:provider/provider.dart';

class NavBarContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
        border: Border(
          top: BorderSide(color: Colors.black),
        ),
      ),
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 0),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
              text: 'Hello ',
              style: const TextStyle(
                fontSize: 20,
                fontFamily: 'rejoin',
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
              children: [
                TextSpan(
                  text: user.username,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'rejoin',
                    fontWeight: FontWeight.w100,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
