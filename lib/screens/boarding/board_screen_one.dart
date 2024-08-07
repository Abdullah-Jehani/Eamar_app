import 'package:eamar_app/helpers/colors.dart';
import 'package:eamar_app/providers/auth_provider.dart';
import 'package:eamar_app/screens/auth/login_screen.dart';
import 'package:eamar_app/screens/boarding/board_screen_two.dart';
import 'package:eamar_app/widgets/board/boarding_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BoardScreenOne extends StatefulWidget {
  const BoardScreenOne({super.key});

  @override
  State<BoardScreenOne> createState() => _BoardScreenOneState();
}

class _BoardScreenOneState extends State<BoardScreenOne> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<AuthProvider>(builder: (context, auth, _) {
      return Scaffold(
          backgroundColor: secondaryColor,
          body: BoardingWidget(
              image:
                  'assets/images/board/fba23001-d14b-4de9-8a1b-32982ac0aa31.png',
              heading: 'الإبلاغ عن المشاكل وحلها بشكل فعال',
              subgeading:
                  'تجعل منصتنا من السهل للغاية الإبلاغ عن تحديات المجتمع وحلها. من خلال بضع نقرات فقط على هاتفك، يمكنك الإبلاغ بسهولة عن أي مشكلة تواجهها',
              colors: [primaryColor, greyColor, greyColor],
              widths: [size.width * .20, 10.0, 10.0],
              onClickNext: () {
                setState(() {
                  Navigator.pushAndRemoveUntil(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const BoardScreenTwo(),
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
                });
              },
              onClickSkip: () {
                setState(() {
                  auth.isFirstTime == false;
                  auth.setFirstTime(false);
                  Navigator.pushAndRemoveUntil(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const LoginScreen()),
                      (route) => false);
                });
              }));
    });
  }
}
