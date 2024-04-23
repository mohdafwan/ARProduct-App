// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:interior_design_arapp/common/widgets/loader.dart';
import 'package:interior_design_arapp/common/widgets/stars_bar.dart';
import 'package:interior_design_arapp/features/home/widgets/address_area_box.dart';
import 'package:interior_design_arapp/features/productOn/screens/product_details_screen.dart';
import 'package:interior_design_arapp/features/search/services/search_services.dart';
import 'package:interior_design_arapp/models/product.model.dart';
import 'package:interior_design_arapp/providers/user.provider.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';
  final String searchQuery;

  const SearchScreen({
    Key? key,
    required this.searchQuery,
  }) : super(key: key);
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>? product;

  @override
  void initState() {
    super.initState();
    fetchSearchedProducts();
  }

  void fetchSearchedProducts() async {
    product = await SearchServices().fetchSearchedProducts(
        context: context, searchQuery: widget.searchQuery);
    setState(() {});
  }

  void NavigateToOnProductScreen(BuildContext context, Product product) {
    Navigator.pushNamed(
      context,
      OnProductDetailsScreen.routeName,
      arguments: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.black, width: 1),
            ),
          ),
          child: AppBar(
            backgroundColor: Color.fromARGB(255, 0, 0, 0),
            iconTheme: const IconThemeData(color: Colors.white),
            elevation: 0,
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Container(
                child: Image.asset(
                  'assets/images/logo-no-background.png',
                  filterQuality: FilterQuality.high,
                  width: 180,
                ),
              ),
            ),
          ),
        ),
      ),
      body: product == null
          ? const Loader()
          : SafeArea(
              child: Column(
                children: [
                  const AddressAreaBox(),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: product!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              OnProductDetailsScreen.routeName,
                              arguments: product![index],
                            );
                          },
                          child: SearchProducts(
                            product: product![index],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

class SearchProducts extends StatelessWidget {
  final Product product;
  const SearchProducts({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalRating = 0.0;
    for (int i = 0; i < product.rating!.length; i++) {
      totalRating += product.rating![i].rating;
    }
    double avgRating = 0.0;
    if (totalRating != 0) {
      avgRating = totalRating / product.rating!.length;
    }
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(12),
            color: Color.fromARGB(255, 230, 207, 247),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(0.0).copyWith(
                  left: 5,
                  top: 5,
                  bottom: 5,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    product.images.first,
                    height: 135,
                    width: 135,
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    width: 235,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.symmetric(horizontal: 0)
                        .copyWith(left: 10, top: 5),
                    child: StarsBar(rating: avgRating),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.symmetric(horizontal: 10)
                        .copyWith(left: 10, top: 5),
                    child: Text(
                      '\₹${product.price}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.symmetric(horizontal: 10)
                        .copyWith(left: 10),
                    child: const Text(
                      'Eligible for Free Shipping',
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.symmetric(horizontal: 10)
                        .copyWith(left: 10),
                    child: const Text(
                      'In Stock',
                      style: TextStyle(color: Colors.teal),
                      maxLines: 2,
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
