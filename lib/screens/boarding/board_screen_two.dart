import 'package:eamar_app/helpers/colors.dart';
import 'package:eamar_app/providers/auth_provider.dart';
import 'package:eamar_app/screens/auth/login_screen.dart';
import 'package:eamar_app/screens/boarding/board_screen_three.dart';
import 'package:eamar_app/widgets/board/boarding_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BoardScreenTwo extends StatefulWidget {
  const BoardScreenTwo({super.key});

  @override
  State<BoardScreenTwo> createState() => _BoardScreenTwoState();
}

class _BoardScreenTwoState extends State<BoardScreenTwo> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<AuthProvider>(builder: (context, auth, _) {
      return Scaffold(
          backgroundColor: secondaryColor,
          body: BoardingWidget(
              image:
                  'assets/images/board/30af14e3-23ef-4718-b80e-ff08822ee226.png',
              heading: 'ميزة الإبلاغ الدقيقة المستندة إلى الموقع',
              subgeading:
                  'أصبح الإبلاغ عن المشكلات في مجتمعك أسهل من أي وقت مضى. ما عليك سوى فتح التطبيق وتحديد الموقع الدقيق للمشكلة على الخريطة وتقديم وصف موجز. ',
              colors: [greyColor, primaryColor, greyColor],
              widths: [10.0, size.width * .20, 10.0],
              onClickNext: () {
                setState(() {
                  Navigator.pushAndRemoveUntil(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const BoardScreenThree()),
                      (route) => false);
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
