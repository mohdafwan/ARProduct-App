import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:interior_design_arapp/features/home/screens/category_details_screen.dart';

class CategoryScreen extends StatefulWidget {
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final List<String> furnitureNames = [
    "Stool",
    "Chair",
    "Sofa",
    "Lamp",
    "Dressing",
    "Table",
    "Bench",
    "Bed",
    "Couch"
  ];

  final List<IconData> furnitureIcons = [
    Icons.weekend,
    Icons.chair,
    Icons.local_hotel,
    Icons.lightbulb_outline,
    Icons.account_balance,
    Icons.table_chart,
    Icons.airline_seat_individual_suite,
    Icons.hotel,
    Icons.local_hotel,
  ];

  void navigateToCategoryPage(BuildContext context, String category) {
    Navigator.pushNamed(
      context,
      CategoryDetailsScreen.routeName,
      arguments: category,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomLeft,
              width: double.infinity,
              padding: const EdgeInsets.all(0).copyWith(left: 20, top: 30),
              child: const Text(
                "Category",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'rejoin',
                  fontSize: 70.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              padding: const EdgeInsets.all(12),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 0.0,
                  mainAxisSpacing: 0.0,
                ),
                itemCount: furnitureNames.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () =>
                        navigateToCategoryPage(context, furnitureNames[index]),
                    child: GridItem(
                      icon: furnitureIcons[index],
                      text: furnitureNames[index],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const GridItem({Key? key, required this.icon, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        // color: const Color.fromARGB(255, 184, 146, 212),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 40.0,
            color: const Color.fromARGB(255, 184, 146, 212),
          ),
          const SizedBox(height: 10.0),
          Text(
            text,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 184, 146, 212),
            ),
          ),
        ],
      ),
    );
  }
}
