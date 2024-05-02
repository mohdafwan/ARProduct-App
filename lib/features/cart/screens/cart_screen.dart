import 'package:flutter/material.dart';
import 'package:interior_design_arapp/common/widgets/custom_button.dart';
import 'package:interior_design_arapp/features/address/screens/address_screen.dart';
import 'package:interior_design_arapp/features/cart/widgets/cart_product.dart';
import 'package:interior_design_arapp/features/cart/widgets/cart_subtotal.dart';
import 'package:interior_design_arapp/features/home/widgets/address_area_box.dart';
import 'package:interior_design_arapp/providers/user.provider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static const String routeName = '/cart-screen';
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void navigateToAddress(int sum) {
    Navigator.pushNamed(context, AddressScreen.routeName,
        arguments: sum.toString());
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    int sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.white, width: 0),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Container(
                child: Image.asset(
                  'assets/images/logo-no-background-Inblack.png',
                  filterQuality: FilterQuality.high,
                  width: 180,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: AddressAreaBox(
              bgColor: Colors.white,
              middleTextColor: Colors.black,
              iconColor: Colors.black,
            ),
          ),
          Expanded(
              flex: 4,
              child: user.cart.isEmpty
                  ? Container(
                    padding: const EdgeInsets.all(52),
                    child: Image.asset('assets/images/cartimage.png'),
                  )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: user.cart.length,
                      itemBuilder: (context, index) {
                        return CartProduct(index: index);
                      },
                    )),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                const SizedBox(height: 10),
                const CartSubTotal(),
                Container(
                    height: 70,
                    width: double.infinity,
                    child: CustomButton(
                      text: "Proceed To Buy (${user.cart.length}) items",
                      onClick: () => navigateToAddress(sum),
                      Btnbg: Colors.black,
                      textbg: Colors.white,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
