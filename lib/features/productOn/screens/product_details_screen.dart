import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:interior_design_arapp/features/productOn/services/product_details_services.dart';
import 'package:interior_design_arapp/providers/user.provider.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:interior_design_arapp/common/widgets/stars_bar.dart';
import 'package:interior_design_arapp/features/home/widgets/address_area_box.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:interior_design_arapp/models/product.model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class OnProductDetailsScreen extends StatefulWidget {
  static const String routeName = '/product-details';

  final Product product;

  const OnProductDetailsScreen({super.key, required this.product});
  @override
  State<OnProductDetailsScreen> createState() => _OnProductDetailsScreenState();
}

class _OnProductDetailsScreenState extends State<OnProductDetailsScreen> {
  
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();
  double avgRating = 0;
  double myRating = 0;

  @override
  void initState() {
    super.initState();
    double totalRating = 0.0;
    for (int i = 0; i < widget.product.rating!.length; i++) {
      totalRating += widget.product.rating![i].rating.toDouble();
      if (widget.product.rating![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.product.rating![i].rating.toDouble();
      }
    }
    if (totalRating != 0) {
      avgRating = totalRating / widget.product.rating!.length.toDouble();
    }
  }

  void addToCart() {
    productDetailsServices.addToCart(context: context, product: widget.product);
  }

  @override
  Widget build(BuildContext context) {
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
        children: [
          const AddressAreaBox(
            bgColor: Colors.white,
            middleTextColor: Colors.black,
            iconColor: Colors.black,
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 100,
                    child: Text(
                      'Id:${widget.product.id!}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    child: StarsBar(
                      rating: avgRating,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
                width: double.infinity,
                color: Colors.black,
                child: Image.network(
                  '${widget.product.images[0]}',
                  fit: BoxFit.contain,
                )),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              width: double.infinity,
              color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      widget.product.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'rejoin',
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: const Text(
                      // '${widget.product.description}',
                      'This approach provides an alternative way to achieve a white background for the image without directly manipulating the image\'s pixels or using color filters. Adjust the size, opacity, and blend mode according to your requirements.',
                      style: TextStyle(color: Colors.white), maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xfff9e0f4),
                                  Color(0xfffff3de),
                                ],
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.all(0).copyWith(top: 20),
                                  child: Text(
                                    '\₹${widget.product.price}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 29,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(bottom: 13),
                                  padding: const EdgeInsets.only(
                                    left: 2,
                                    bottom: 3,
                                    top: 3,
                                    right: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Color.fromARGB(37, 209, 31, 31),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/percent.png',
                                        color:
                                            const Color.fromARGB(134, 0, 0, 0),
                                        width: 20,
                                      ),
                                      const Text(
                                        ' Extra 5% off',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 0),
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 99,
                            padding: const EdgeInsets.only(top: 1, left: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xffF8F8F8),
                                      borderRadius: BorderRadius.circular(12)),
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                    top: 15,
                                    bottom: 14,
                                    right: 5,
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/box.png',
                                        color: Colors.black,
                                        width: 20,
                                      ),
                                      const Text(
                                        "  Delivery: ",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const Text(
                                        "Tomorrow",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Color(0xffF8F8F8),
                                      borderRadius: BorderRadius.circular(12)),
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                    top: 12,
                                    bottom: 12,
                                    right: 10,
                                  ),
                                  width: double.infinity,
                                  child: RatingBar.builder(
                                    itemSize: 18,
                                    initialRating: myRating,
                                    allowHalfRating: true,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 2),
                                    minRating: 1,
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Color.fromARGB(255, 255, 163, 59),
                                    ),
                                    onRatingUpdate: (rating) {
                                      productDetailsServices.rateProduct(
                                        context: context,
                                        product: widget.product,
                                        rating: rating,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(0).copyWith(top: 10, bottom: 5),
                      child: ordersBtn(
                        onpress: () {},
                        whatColor: Colors.white,
                        text: 'Buy Now',
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(0).copyWith(top: 4, bottom: 5),
                      child: Row(
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: double.infinity,
                              child: ordersBtn(
                                  text: 'Add to Cart',
                                  onpress: addToCart,
                                  whatColor: Colors.white),
                            ),
                          ),
                          Container(
                            // margin: EdgeInsets.only(top: 20),
                            width: 70,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: ModelViewer(
                              src: widget.product.threeName!,
                              alt: '3D Model loaded with ap',
                              ar: true,
                              cameraControls: true,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ordersBtn extends StatelessWidget {
  final String text;
  final void Function() onpress;
  final Color whatColor;
  const ordersBtn({
    Key? key,
    required this.text,
    required this.onpress,
    required this.whatColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpress,
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'rejoin',
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: whatColor,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 184, 146, 212),
        maximumSize: const Size(200, 50),
      ),
    );
  }
}
