import 'package:flutter/material.dart';
import 'package:interior_design_arapp/providers/user.provider.dart';
import 'package:provider/provider.dart';

class NavigateButtonToTheContext extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context).user;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(color: const Color.fromARGB(255, 184, 146, 212),width: 2),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(left: 0, right: 10),
            child: const CircleAvatar(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userProvider.username,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'rejoin',
                ),
              ),
              Text(
                userProvider.email,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'rejoin',
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
