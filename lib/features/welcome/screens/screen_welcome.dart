import 'package:flutter/material.dart';
import 'package:interior_design_arapp/common/widgets/custom_button.dart';
import 'package:interior_design_arapp/features/auth/screens/screen_auth.dart';
import 'package:interior_design_arapp/features/auth/screens/screen_auth.signin.dart';

class WelcomeScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const WelcomeScreen({super.key});
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffdbd7d3),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 4,
              child: Stack(
                fit: StackFit.expand,
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Image.asset(
                      'assets/images/wall.jpg',
                      scale: 2,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Minimalist Dream Space",
                          style: TextStyle(
                            height: 1,
                            fontFamily: "rejoin",
                            fontWeight: FontWeight.w900,
                            fontSize: 65,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Choose furniture with clean lines and minimal ornamentation',
                          style: TextStyle(
                            fontFamily: "rejoin",
                            height: 3,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 55, 53, 53),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            // Login the app Content
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                width: double.infinity,
                                height: 70,
                                child: CustomButton(
                                  onClick: () => {
                                    Navigator.pushNamed(
                                      context,
                                      AuthScreenSignUp.routeName,
                                    )
                                  },
                                  text: "Create New Account",
                                  Btnbg: Colors.black,
                                  textbg: Colors.white,
                                )),
                            Container(
                              width: double.infinity,
                              height: 70,
                              child: CustomButton(
                                onClick: () => {
                                  Navigator.pushNamed(
                                    context,
                                    AuthScreenSignIn.routeName,
                                  )
                                },
                                text: "I already have an account",
                                Btnbg: Colors.white,
                                textbg: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    //   Expanded(
                    //     flex: 1,
                    //     child: Container(
                    //       child: Column(
                    //         children: [
                    //           Container(
                    //             margin:
                    //                 EdgeInsets.only(left: 20, right: 20, top: 10),
                    //             height: 2,
                    //             width: double.infinity,
                    //             color: Color.fromARGB(84, 158, 158, 158),
                    //           ),
                    //           const Padding(
                    //             padding: EdgeInsets.all(16.0),
                    //             child: Center(
                    //               child: Text(
                    //                 'Sign in using',
                    //                 style: TextStyle(
                    //                   fontSize: 14,
                    //                   fontWeight: FontWeight.w700,
                    //                   fontFamily: "rejoin",
                    //                   color: Color.fromARGB(255, 95, 94, 94),
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //           Container(
                    //             margin:
                    //                 const EdgeInsets.only(left: 100, right: 100),
                    //             width: double.infinity,
                    //             height: 60,
                    //             child: const Row(
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceEvenly,
                    //               crossAxisAlignment: CrossAxisAlignment.center,
                    //               children: [
                    //                 SocialMediaLoginIcon(
                    //                   icon: FontAwesomeIcons.google,
                    //                   color: Colors.white,
                    //                 ),
                    //                 SocialMediaLoginIcon(
                    //                   icon: FontAwesomeIcons.facebook,
                    //                   color: Colors.white,
                    //                 ),
                    //                 SocialMediaLoginIcon(
                    //                   icon: FontAwesomeIcons.twitter,
                    //                   color: Colors.white,
                    //                 ),
                    //               ],
                    //             ),
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
