import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

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
                  // color: Color.fromARGB(255, 228, 174, 233),
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                width: double.infinity,
                child: Container(),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: 8,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(140),
                          margin: const EdgeInsets.only(bottom: 5, left: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color.fromARGB(255, 0, 0, 0),
                            // color: const Color.fromARGB(255, 129, 183, 203),
                          ),
                          alignment: Alignment.center,
                          child: const Column(),
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
                          margin: const EdgeInsets.only(bottom: 5, right: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color.fromARGB(255, 0, 0, 0),
                            // color: Color.fromARGB(255, 129, 138, 203),
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
