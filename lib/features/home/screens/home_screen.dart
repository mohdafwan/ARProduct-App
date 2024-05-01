import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:interior_design_arapp/common/widgets/loader.dart';
import 'package:interior_design_arapp/features/cart/screens/cart_screen.dart';
import 'package:interior_design_arapp/features/home/services/home_services.dart';
import 'package:interior_design_arapp/features/home/services/home_services_products.dart';
import 'package:interior_design_arapp/features/productOn/screens/product_details_screen.dart';
import 'package:interior_design_arapp/models/product.model.dart';
import 'package:badges/badges.dart' as badges;
import 'package:interior_design_arapp/providers/user.provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product>? productList;
  Product? product;
  final HomeServices homeServices = HomeServices();
  final HomeServicesAppProducts homeServicesAppProducts =
      HomeServicesAppProducts();
  @override
  void initState() {
    super.initState();
    fetchAllProductsOnHomeScreen();
    fetchDealOfTheDay();
  }

  void fetchDealOfTheDay() async {
    product = await homeServices.fetchDealOfDay(context: context);
    setState(() {});
  }

  Future<void> fetchAllProductsOnHomeScreen() async {
    productList = await homeServicesAppProducts.fetchAllProductsOnHomeScreen(
      context: context,
    );
    setState(() {});
    productList!.forEach((element) {
      log(element.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (productList == null || productList!.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: const Loader(), // Or any other loading indicator
        ),
      );
    }

    int midpoint = (productList!.length / 2).ceil();
    // Split the list into two separate lists
    List<Product> firstHalf = productList!.sublist(0, midpoint);
    List<Product> secondHalf = productList!.sublist(midpoint);

    return productList == null
        ? const Loader()
        : Scaffold(
            floatingActionButton: const CartFloating(),
            floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                        color: Color.fromARGB(255, 228, 174, 233),
                        // color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      width: double.infinity,
                      child: product == null
                          ? const Loader()
                          : product!.name.isEmpty
                              ? const SizedBox()
                              : Container(
                                  child: Stack(
                                    alignment: Alignment.centerRight,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(0)
                                            .copyWith(
                                                left: 20,
                                                right: 10,
                                                top: 10,
                                                bottom: 10),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(0).copyWith(
                                            topRight: const Radius.circular(22),
                                            bottomRight:
                                                const Radius.circular(40),
                                            bottomLeft:
                                                const Radius.circular(20),
                                            topLeft: const Radius.circular(20),
                                          ),
                                          child: Image.network(
                                            product!.images.first,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 14,
                                        top: 60,
                                        child: RichText(
                                          text: TextSpan(
                                            text: 'Find The Best\nDeal\n',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'rejoin',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 40,
                                              height: 1,
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: '${product!.name}\n\n',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 60,
                                        left: 10,
                                        child: Container(
                                          padding: const EdgeInsets.all(14),
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          child: Text(
                                            '\₹${product!.price}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 15,
                                              fontFamily: 'rejoin',
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    flex: 2,
                    child: productList == null
                        ? const Loader() // Show a loader if productList is null
                        : Row(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemCount: firstHalf
                                      .length, // No need for null check here
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    final product = firstHalf[
                                        index]; // Access the product directly
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          OnProductDetailsScreen.routeName,
                                          arguments: product,
                                        );
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            bottom: 5, left: 5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: const Color.fromARGB(
                                              255, 129, 183, 203),
                                        ),
                                        alignment: Alignment.center,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(0.0)
                                                  .copyWith(
                                                left: 10,
                                                right: 10,
                                                bottom: 1,
                                                top: 10,
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                                child: Image.network(
                                                  product.images.first,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(0)
                                                  .copyWith(
                                                top: 10,
                                                bottom: 0,
                                              ),
                                              child: Container(
                                                child: Text(
                                                  '${product.name}',
                                                  style: const TextStyle(
                                                    height: 1,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 25,
                                                    fontFamily: 'rejoin',
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(0)
                                                  .copyWith(
                                                top: 3,
                                                bottom: 10,
                                              ),
                                              child: Container(
                                                child: Text(
                                                  '\₹${product.price}',
                                                  style: const TextStyle(
                                                    fontSize: 21,
                                                    fontFamily: 'rejoin',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: ListView.builder(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemCount: secondHalf
                                      .length, // No need for null check here
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    final product = secondHalf[
                                        index]; // Access the product directly
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          OnProductDetailsScreen.routeName,
                                          arguments: product,
                                        );
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            bottom: 5, left: 5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: const Color.fromARGB(
                                              255, 173, 180, 235),
                                        ),
                                        alignment: Alignment.center,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(0.0)
                                                  .copyWith(
                                                left: 10,
                                                right: 10,
                                                bottom: 1,
                                                top: 10,
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                                child: Image.network(
                                                  product.images.first,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(0)
                                                  .copyWith(
                                                top: 10,
                                                bottom: 0,
                                              ),
                                              child: Container(
                                                child: Text(
                                                  '${product.name}',
                                                  style: const TextStyle(
                                                    height: 1,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 25,
                                                    fontFamily: 'rejoin',
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(0)
                                                  .copyWith(
                                                top: 3,
                                                bottom: 10,
                                              ),
                                              child: Container(
                                                child: Text(
                                                  '\₹${product.price}',
                                                  style: const TextStyle(
                                                    fontSize: 21,
                                                    fontFamily: 'rejoin',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          );
  }
}

class CartFloating extends StatefulWidget {
  const CartFloating({
    super.key,
  });

  @override
  State<CartFloating> createState() => _CartFloatingState();
}

class _CartFloatingState extends State<CartFloating> {
  @override
  Widget build(BuildContext context) {
    final userCartlength = context.watch<UserProvider>().user.cart.length;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, CartScreen.routeName);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(12),
        child: badges.Badge(
          badgeStyle: const badges.BadgeStyle(
            badgeColor: Colors.black,
          ),
          badgeContent: Text(
            userCartlength.toString(),
            style: const TextStyle(color: Colors.white),
          ),
          child: Image.asset(
            'assets/images/cartfree.png',
            color: Colors.black,
            scale: 1,
          ),
        ),
      ),
    );
  }
}
