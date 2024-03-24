import 'package:flutter/material.dart';
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
    print(userProvider.user.toJson());

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Container(
        alignment: Alignment.center,
        child: Text(
          userProvider.user.email,
          style: TextStyle(color: Colors.white),
        ),
      )),
    );
  }
}
