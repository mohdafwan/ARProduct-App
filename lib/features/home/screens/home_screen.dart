import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interior_design_arapp/providers/user.provider.dart';
import 'package:provider/provider.dart';

import 'package:cloudinary_flutter/image/cld_image.dart';

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
    print(userProvider.user.toJson());

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
                ),
                width: double.infinity,
                child: SizedBox(
                  child: CldImageWidget(
                    
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.medium,
                    repeat: ImageRepeat.noRepeat,
                    publicId: "fa1cgi9q32fa8axtzeof",
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                child: const Text('DATA'),
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
