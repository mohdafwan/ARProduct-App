import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:interior_design_arapp/features/cart/services/cart_services.dart';
import 'package:interior_design_arapp/features/productOn/services/product_details_services.dart';
import 'package:interior_design_arapp/models/product.model.dart';
import 'package:interior_design_arapp/providers/user.provider.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatefulWidget {
  final int index;
  const CartProduct({super.key, required this.index});

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();

  void increaseQuantity(Product product) {
    productDetailsServices.addToCart(
      context: context,
      product: product,
    );
  }

  void decreaseQuantity(Product product) {
    CartServices().removeProductFromCart(
      context: context,
      product: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    final productCart = context.watch<UserProvider>().user.cart[widget.index];
    final totalNumberOfProduct =
        context.watch<UserProvider>().user.cart[widget.index];
    final product = Product.fromMap(productCart['product']);
    final quantity = totalNumberOfProduct['quantity'];
    return Container(
      height: 90,
      decoration: BoxDecoration(
          color: Colors.white, border: Border.all(color: Colors.white)),
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(17),
                child: Image.network(
                  product.images.first,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(0).copyWith(left: 10, top: 3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${product.name}',
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontFamily: 'rejoin',
                        fontSize: 23,
                      ),
                    ),
                    Text(
                      '\₹${product.price}  x  ${quantity.toString()}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin:
                const EdgeInsets.all(0).copyWith(left: 10, top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.black,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => decreaseQuantity(product),
                        child: Container(
                          width: 30,
                          height: 30,
                          alignment: Alignment.center,
                          child: const Icon(Icons.remove,
                              size: 18, color: Colors.white),
                        ),
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.black,
                            width: 1.5,
                          ),
                          color: Colors.white,
                        ),
                        child: Container(
                          width: 30,
                          height: 30,
                          alignment: Alignment.center,
                          child: Text(quantity.toString()),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => increaseQuantity(product),
                        child: Container(
                          width: 30,
                          height: 30,
                          alignment: Alignment.center,
                          child: const Icon(Icons.add,
                              size: 18, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
