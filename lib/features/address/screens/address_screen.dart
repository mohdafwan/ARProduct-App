import 'package:flutter/material.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                child: const Text(
                  "Checkout",
                  style: TextStyle(
                    fontFamily: 'rejoin',
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Shipping Details',
                    style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'rejoin',
                        fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      'Edit',
                      style: TextStyle(
                        fontFamily: 'rejoin',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffea1833),
                      ),
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
