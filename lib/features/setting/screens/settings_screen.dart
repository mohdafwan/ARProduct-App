import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:interior_design_arapp/features/setting/widgets/heading.dart';
import 'package:interior_design_arapp/features/setting/widgets/navigate_button.dart';
// ignore: depend_on_referenced_packages
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:interior_design_arapp/features/setting/widgets/settings_btns.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> ListViewDemoObjects = ['string one', "string two"];
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Image.asset(
                    'assets/images/logo-no-background.png',
                    filterQuality: FilterQuality.high,
                    width: 180,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeadingText(
            textitem: 'Setting',
            fontSize: 23,
            weight: FontWeight.w800,
            padding: EdgeInsets.only(top: 12, left: 15, right: 15),
          ),
          NavigateButtonToTheContext(),
          const HeadingText(
            textitem: 'General',
            fontSize: 18,
            padding: EdgeInsets.only(top: 0, left: 15, right: 15),
            weight: FontWeight.w400,
          ),
          settings_button(
            text: 'Your Orders',
            callback: () {
              print('object');
            },
            btnIcons: FontAwesomeIcons.cartFlatbed,
          ),
          settings_button(
            text: 'Your Wish List',
            btnIcons: FontAwesomeIcons.arrowRightLong,
            callback: () {},
          ),
          settings_button(
            text: 'Turn Seller',
            btnIcons: FontAwesomeIcons.arrowRightLong,
            callback: () {},
          ),
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.only(left: 12, right: 12, bottom: 3, top: 5),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(double.infinity, 50),
                backgroundColor: Colors.white,
                elevation: 0,
                shadowColor: Colors.white,
                side: const BorderSide(
                  color: const Color.fromARGB(255, 184, 146, 212),
                ),
                foregroundColor: Colors.white,
                disabledBackgroundColor: Colors.white,
              ),
              onPressed: () {
                log('message');
              },
              child: const Text(
                'Log Out',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'rejoin',
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
