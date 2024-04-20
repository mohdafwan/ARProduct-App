import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:interior_design_arapp/common/widgets/loader.dart';
import 'package:interior_design_arapp/features/home/services/home_services_products.dart';
import 'package:interior_design_arapp/features/productOn/product_details_screen.dart';
import 'package:interior_design_arapp/models/product.model.dart';
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
  final HomeServicesAppProducts homeServicesAppProducts =
      HomeServicesAppProducts();
  @override
  void initState() {
    super.initState();
    fetchAllProductsOnHomeScreen();
  }

  Future<void> fetchAllProductsOnHomeScreen() async {
    productList = await homeServicesAppProducts.fetchAllProductsOnHomeScreen(
      context: context,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: Container(),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              flex: 2,
              child: productList == null
                  ? const Loader()
                  : Row(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: productList?.length ?? 0,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              final products =
                                  productList!.sublist(0)[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    OnProductDetailsScreen.routeName,
                                    arguments: products,
                                  );
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.only(bottom: 5, left: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
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
                                                top: 10),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          child: Image.network(
                                            products.images.first,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(0)
                                            .copyWith(top: 10, bottom: 0),
                                        child: Container(
                                          child: Text(
                                            '${products.name}',
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
                                            .copyWith(top: 3, bottom: 10),
                                        child: Container(
                                          child: Text(
                                            '\₹${products.price}',
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
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: 8,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.all(140),
                                margin:
                                    const EdgeInsets.only(bottom: 5, right: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  // color: Color.fromARGB(255, 0, 0, 0),
                                  color: Color.fromARGB(255, 129, 138, 203),
                                ),
                                alignment: Alignment.center,
                                child: const Column(
                                  children: [],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
            )
          ],
        ),
      ),
    );
  }
}

class CartFloating extends StatelessWidget {
  const CartFloating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/cartScreen');
      },
      child: Container(
        margin: const EdgeInsets.only(top: 25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(12),
        child: Image.asset(
          'assets/images/cartfree.png',
          color: Colors.black,
          scale: 1,
        ),
      ),
    );
  }
}
