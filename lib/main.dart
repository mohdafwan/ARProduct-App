import 'package:flutter/material.dart';
import 'package:interior_design_arapp/common/widgets/bottom_bar.dart';
import 'package:interior_design_arapp/features/auth/services/auth.service.dart';
import 'package:interior_design_arapp/features/welcome/screens/screen_welcome.dart';
import 'package:interior_design_arapp/providers/user.provider.dart';
import 'package:interior_design_arapp/routes.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Interior Design',
        onGenerateRoute: (settings) => generateRoute(settings),
        home:const MyARApp(),
      ),
    ),
  );
}

class MyARApp extends StatefulWidget {
  const MyARApp({super.key});

  @override
  State<MyARApp> createState() => _MyARAppState();
}

class _MyARAppState extends State<MyARApp> {
  final AuthServiceSignUp authServiceSignUp = AuthServiceSignUp();
  @override
  void initState() {
    super.initState();
    authServiceSignUp.getUserData(context);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? const BottomBar()
          : const WelcomeScreen(),
    );
  }
}
