// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:interior_design_arapp/providers/user.provider.dart';

class AddressAreaBox extends StatelessWidget {
  final Color iconColor;
  final Color bgColor;
  final Color middleTextColor;
  const AddressAreaBox({
    Key? key,
    this.iconColor = Colors.white,
    this.bgColor = Colors.black,
    this.middleTextColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Container(
      height: 40,
      color: bgColor,
      padding: const EdgeInsets.only(left: 10,right: 10),
      child: Row(
        children: [
          Icon(
            Icons.location_on_outlined,
            size: 20,
            color: iconColor,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                'Delivery to ${user.username} - ${user.address}',
                style: TextStyle(
                  color: middleTextColor,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 5,
              top: 2,
            ),
            child: Icon(
              Icons.arrow_drop_down_outlined,
              size: 18,
              color: iconColor,
            ),
          )
        ],
      ),
    );
  }
}
