import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:interior_design_arapp/common/widgets/custom_textbar.dart';
import 'package:interior_design_arapp/constants/utils/filePicker.utils.dart';
import 'package:interior_design_arapp/features/admin/services/admin_services.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productThreeDController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final AdminServices adminServices = AdminServices();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    productNameController.dispose();
    productThreeDController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  String category = "Stool";
  List<String> productCategories = [
    "Stool",
    "Chair",
    "Sofa",
    "Lamp",
    "Dressing",
    "Table",
    "Bench",
    "Bed",
    "Couch",
  ];
  List<File> image = [];
  final _addProductFormKey = GlobalKey<FormState>();

  void sellProduct() {
    if (_addProductFormKey.currentState!.validate() && image.isNotEmpty) {
      adminServices.sellProduct(
        context: context,
        threeName: productThreeDController.text,
        name: productNameController.text,
        description: descriptionController.text,
        price: double.parse(priceController.text),
        quantity: double.parse(quantityController.text),
        category: category,
        images: image,
      );
    }
  }

  void selectImage() async {
    var res = await pickImage();
    setState(() {
      image = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          // actionsIconTheme: ,
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: const Color.fromARGB(255, 184, 146, 212),
              border: Border(
                bottom: BorderSide(
                    color: Color.fromARGB(255, 184, 146, 212), width: 1),
              ),
            ),
          ),
          title: Title(
            color: Colors.black,
            child: const Text(
              "Add Product",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addProductFormKey,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0).copyWith(top: 10),
            child: Column(
              children: [
                image.isNotEmpty
                    ? Container(
                        width: double.infinity,
                        height: 150,
                        child: Image.file(
                          image[0],
                          fit: BoxFit.cover,
                        ))
                    : GestureDetector(
                        onTap: selectImage,
                        child: DottedBorder(
                          dashPattern: const [10, 4],
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.folder_open,
                                  size: 40,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Select Product Images",
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hintText: '3D Product url',
                  controller: productThreeDController,
                  textColor: Colors.black,
                  hindTextColor: Colors.black38,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hintText: 'Product Name',
                  controller: productNameController,
                  textColor: Colors.black,
                  hindTextColor: Colors.black38,
                ),
                const SizedBox(height: 10.0),
                CustomTextField(
                  hintText: "Description",
                  textColor: Colors.black,
                  hindTextColor: Colors.black38,
                  controller: descriptionController,
                  maxline: 4,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hintText: 'Price',
                  controller: priceController,
                  textColor: Colors.black,
                  hindTextColor: Colors.black38,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hintText: 'Quantity',
                  controller: quantityController,
                  textColor: Colors.black,
                  hindTextColor: Colors.black38,
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: DropdownButton(
                      value: category,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: productCategories.map((String item) {
                        return DropdownMenuItem(
                          alignment: Alignment.center,
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (String? newVal) {
                        setState(() {
                          category = newVal!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: sellProduct,
        backgroundColor: const Color.fromARGB(255, 184, 146, 212),
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
