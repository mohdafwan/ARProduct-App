import 'package:flutter/material.dart';
import 'package:interior_design_arapp/providers/user.provider.dart';
import 'package:provider/provider.dart';

class CartSubTotal extends StatelessWidget {
  const CartSubTotal({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    int sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(0).copyWith(left: 15,right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            "Total:",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            "\₹${sum.toString()}",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
