// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:interior_design_arapp/features/category/screens/category_screen.dart';
import 'package:interior_design_arapp/features/home/screens/home_screen.dart';
import 'package:interior_design_arapp/features/setting/screens/settings_screen.dart';

class BottomBar extends StatefulWidget {
  final int initialPage;

  const BottomBar({Key? key, required this.initialPage}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  late PageController _pageController;
  List<Widget> pageList = [
    const HomeScreen(),
    const CategoryScreen(),
    const SettingScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _page = widget.initialPage;
    _pageController = PageController(initialPage: _page);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void updatePage(int page) {
    setState(() {
      _page = page;
      _pageController.animateToPage(page,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
    ));
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: PageView(
          controller: _pageController,
          children: pageList,
          onPageChanged: (index) {
            setState(() {
              _page = index;
            });
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          width: 200,
          margin: EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BottomBarButtons(
                imagePath: 'assets/images/house.png',
                imageSize: 20,
                color: _page == 0
                    ? const Color.fromARGB(255, 184, 146, 212)
                    : const Color.fromARGB(89, 245, 245, 245),
                callback: () {
                  updatePage(0);
                },
              ),
              BottomBarButtons(
                imagePath: 'assets/images/visualization.png',
                imageSize: 20,
                color: _page == 1
                    ? const Color.fromARGB(255, 184, 146, 212)
                    : const Color.fromARGB(89, 245, 245, 245),
                callback: () {
                  updatePage(1);
                },
              ),
              BottomBarButtons(
                imagePath: 'assets/images/settings.png',
                imageSize: 23,
                color: _page == 2
                    ? const Color.fromARGB(255, 184, 146, 212)
                    : const Color.fromARGB(89, 245, 245, 245),
                callback: () {
                  updatePage(2);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomBarButtons extends StatelessWidget {
  final void Function()? callback;
  final String? imagePath;
  final double? imageSize;
  final Color? color;

  const BottomBarButtons({
    Key? key,
    this.callback,
    required this.imagePath,
    required this.color,
    required this.imageSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Image.asset(
          '$imagePath',
          color: color,
          width: imageSize,
        ),
      ),
    );
  }
}
