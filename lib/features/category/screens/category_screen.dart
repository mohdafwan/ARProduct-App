import 'package:flutter/material.dart';
import 'package:interior_design_arapp/features/home/screens/category_details_screen.dart';
import 'package:interior_design_arapp/features/search/screens/search_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key});

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

  final List<String> furnitureImage = [
    'assets/images/stool.png',
    'assets/images/chair.png',
    'assets/images/sofa.png',
    'assets/images/lamp.png',
    'assets/images/wardrobe.png',
    'assets/images/table.png',
    'assets/images/bench.png',
    'assets/images/bed.png',
    'assets/images/visualization.png',
  ];

  void navigateToSearchScreen(String query) {
    if (query.isNotEmpty) {
      Navigator.pushNamed(
        context,
        SearchScreen.routeName,
        arguments: query,
      );
    }
  }

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
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 100),
        child: Container(
          color: Colors.black,
          padding: const EdgeInsets.all(0).copyWith(left: 20, top: 20),
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
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
              child: Container(
                height: 42,
                margin: const EdgeInsets.only(
                    left: 20, right: 20, top: 5, bottom: 6),
                child: Material(
                  borderRadius: BorderRadius.circular(7),
                  elevation: 1,
                  child: Form(
                    child: TextFormField(
                      style: const TextStyle(
                        fontFamily: 'rejoin',
                      ),
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(
                              left: 6,
                              right: 10,
                            ),
                            child: Icon(
                              Icons.search,
                              color: Color.fromARGB(255, 228, 174, 233),
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        hintText: 'Search Arproduct.in',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 17,
                          fontFamily: 'rejoin',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ]),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 0.0,
                ),
                itemCount: furnitureNames.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () =>
                        navigateToCategoryPage(context, furnitureNames[index]),
                    child: GridItem(
                      pathName: furnitureImage[index],
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
  final String text;
  final String pathName;

  const GridItem({
    Key? key,
    required this.text,
    required this.pathName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        // color: const Color.fromARGB(255, 184, 146, 212),
        color: Colors.white,
        borderRadius: BorderRadius.circular(100.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(pathName),
          const SizedBox(height: 10.0),
          Container(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
