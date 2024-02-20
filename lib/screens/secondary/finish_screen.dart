import 'package:eamar_app/helpers/colors.dart';
import 'package:eamar_app/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

class FinishScreen extends StatefulWidget {
  const FinishScreen({super.key});

  @override
  State<FinishScreen> createState() => _FinishScreenState();
}

class _FinishScreenState extends State<FinishScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Align(
          child: Column(
            children: [
              SizedBox(
                height: size.height * .35,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset('assets/images/secondary/finishPhoto.png'),
                  Column(
                    children: [
                      Text(
                        'تهانينا !',
                        style: TextStyle(
                            color: primaryColor,
                            fontFamily: 'cairo',
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: size.height * .009,
                      ),
                      Text(
                        'لقد أكملت بنجاح عملية التسجيل.',
                        style: TextStyle(
                            color: textColor,
                            fontFamily: 'cairo',
                            fontSize: 20),
                      )
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: size.height * .3,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const HomeScreen(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                          transitionDuration: const Duration(milliseconds: 90),
                        ),
                        (route) => false,
                      );
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 12)),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(primaryColor),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                    ),
                    child: GestureDetector(
                      child: const Text(
                        'انهاء',
                        style: TextStyle(
                          fontFamily: 'cairo',
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
