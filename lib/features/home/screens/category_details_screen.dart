// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:interior_design_arapp/common/widgets/loader.dart';
import 'package:interior_design_arapp/features/home/services/home_services.dart';
import 'package:interior_design_arapp/features/productOn/product_details_screen.dart';
import 'package:interior_design_arapp/models/product.model.dart';

class CategoryDetailsScreen extends StatefulWidget {
  static const String routeName = '/category-details';
  final String category;

  const CategoryDetailsScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<CategoryDetailsScreen> createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  List<Product>? productList;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  Future<void> fetchCategoryProducts() async {
    productList = await homeServices.fetchCategoryProducts(
      context: context,
      category: widget.category,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 184, 146, 212),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.category,
          style: const TextStyle(
            fontWeight: FontWeight.bold,    
            color: Colors.black,          
            fontFamily: 'rejoin',
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              child: Text(
                'See all the "${widget.category}"',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                ),
              ),
            ),
            Expanded(
              child: productList == null
                  ? const Loader()
                  : GridView.builder(
                      padding: const EdgeInsets.only(top: 0, left: 8),
                      itemCount: productList?.length ?? 0,
                      scrollDirection: Axis.vertical,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        final product = productList![index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              OnProductDetailsScreen.routeName,
                              arguments: product,
                            );
                          },
                          child: Column(
                            children: [
                              SizedBox(
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 0.5,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height -
                                              677,
                                          child: Image.network(
                                            product.images.first,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 10),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: const EdgeInsets.only(
                                            top: 10,
                                            bottom: 10,
                                            left: 8,
                                            right: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: const Color.fromARGB(
                                                255, 184, 146, 212),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                textAlign: TextAlign.left,
                                                product.name,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(0),
                                                child: Text(
                                                  textAlign: TextAlign.left,
                                                  "\₹" +
                                                      product.price.toString(),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
