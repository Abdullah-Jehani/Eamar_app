import 'dart:async';

import 'package:eamar_app/helpers/colors.dart';
import 'package:eamar_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 5), () {
      Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const ScreenRouter(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 90),
        ),
        (route) => false,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(color: primaryColor),
      child: Column(
        children: [
          SizedBox(
            height: size.height * .35,
          ),
          SvgPicture.asset('assets/images/secondary/Eamrprimaryicon.svg'),
          SizedBox(
            height: size.height * .03,
          ),
          const Text(
            'منصة اعمار',
            style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontFamily: 'cairo',
                fontWeight: FontWeight.w100),
          )
        ],
      ),
    ));
  }
}
