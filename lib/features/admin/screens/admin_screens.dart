// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:interior_design_arapp/features/admin/screens/orders_screen.dart';
import 'package:interior_design_arapp/features/admin/screens/post_screen.dart';
import 'package:provider/provider.dart';

import 'package:interior_design_arapp/providers/user.provider.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _page = 0;
  List<Widget> pageList = [
    const PostScreen(),
    const OrdersScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider user = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          elevation: 0,
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              border: Border(
                bottom: BorderSide(color: Colors.black, width: 0),
              ),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Image.asset(
                    'assets/images/logo-no-background.png',
                    filterQuality: FilterQuality.high,
                    width: 180,
                  ),
                ),
                Container(
                  child: Text(
                    user.user.type,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      body: pageList[_page],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SafeArea(
        child: Container(
          width: 150,
          margin: EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BottomBarButtons(
                icons: Icons.home_outlined,
                color: _page == 0
                    ? const Color.fromARGB(255, 184, 146, 212)
                    : const Color.fromARGB(89, 245, 245, 245),
                callback: () {
                  updatePage(0);
                },
              ),
              BottomBarButtons(
                icons: Icons.all_inbox_outlined,
                color: _page == 1
                    ? const Color.fromARGB(255, 184, 146, 212)
                    : const Color.fromARGB(89, 245, 245, 245),
                callback: () {
                  updatePage(1);
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
  // final String? imagePath;
  final double? iconsSize;
  final IconData icons;
  final Color? color;

  const BottomBarButtons({
    Key? key,
    this.callback,
    this.iconsSize,
    required this.icons,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
          padding: const EdgeInsets.all(20),
          child: Icon(
            icons,
            size: iconsSize,
            color: color,
          )),
    );
  }
}
