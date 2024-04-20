import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:interior_design_arapp/common/widgets/custom_button.dart';
import 'package:interior_design_arapp/common/widgets/loader.dart';
import 'package:interior_design_arapp/features/admin/screens/add_product_screen.dart';
import 'package:interior_design_arapp/features/admin/services/admin_services.dart';
import 'package:interior_design_arapp/models/product.model.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  List<Product>? products;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  Future<void> fetchAllProducts() async {
    try {
      // Fetch products from the server
      products = await adminServices.fetchAllProducts(context);
      setState(() {});
    } catch (e) {
      // Handle error if fetch fails
      print('Error fetching products: $e');
      // Show error message to user, if needed
    }
  }

  void deleteProduct(Product product, int index) {
    adminServices.deleteProduct(
      context: context,
      product: product,
      onSuccess: () {
        products!.removeAt(index);
        setState(() {});
      },
    );
  }

  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader() // Show loader while products are being fetched
        : Scaffold(
            floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
            floatingActionButton: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: FloatingActionButton(
                backgroundColor: const Color.fromARGB(255, 184, 146, 212),
                elevation: 1.0,
                child: const Icon(Icons.add),
                onPressed: navigateToAddProduct,
                shape: const CircleBorder(),
                tooltip: 'Add new products',
              ),
            ),
            body: Center(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: products!.length,
                      itemBuilder: (context, index) {
                        final product = products![index];
                        // Display product details in a ListTile or custom widget
                        return GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                // This function returns the content of the bottom sheet
                                return Container(
                                  width: double.infinity,
                                  height: 400,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const SizedBox(height: 20),
                                        Container(
                                          width: double.infinity,
                                          child: const Text(
                                            textAlign: TextAlign.center,
                                            'Product Details',
                                            style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black38,
                                              // backgroundColor: Colors.red,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height: 80,
                                                color: product.images.isNotEmpty
                                                    ? Colors.green
                                                    : Colors.red,
                                                child: Center(
                                                  child: Text(
                                                    product.images.isNotEmpty
                                                        ? 'Images Added'
                                                        : 'No Image Added',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Expanded(
                                              child: Container(
                                                height: 80,
                                                color: product.images.isNotEmpty
                                                    ? Colors.green
                                                    : Colors.red,
                                                child: Center(
                                                  child: Text(
                                                    product.images.isNotEmpty
                                                        ? '3D Image Added'
                                                        : 'No 3D Image Url Added',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 18),
                                        Text(
                                          'Name: ${product.name}',
                                          style: const TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Description: ${product.description}',
                                          style: const TextStyle(
                                            fontSize: 19,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 4,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Price: \$${product.price}',
                                          style: const TextStyle(
                                            fontSize: 19,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Quantity: ${product.quantity}',
                                          style: const TextStyle(
                                            fontSize: 19,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Container(
                                          height: 80,
                                          width: double.infinity,
                                          child: CustomButton(
                                            text: 'Delete Product',
                                            onClick: () =>
                                                deleteProduct(product, index),
                                            Btnbg: Colors.red,
                                            textbg: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Card(
                            elevation: 2.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Image.network(
                                    width: double.infinity,
                                    product.images.last,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(0.0)
                                          .copyWith(
                                              bottom: 0,
                                              right: 0,
                                              left: 5,
                                              top: 10),
                                      child: Text(
                                        product.name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(0.0)
                                          .copyWith(
                                              bottom: 10, right: 10, left: 5),
                                      child: Text(
                                        product.description,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                )
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
          );
  }
}
