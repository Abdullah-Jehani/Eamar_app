import 'package:eamar_app/helpers/colors.dart';
import 'package:eamar_app/screens/auth/login_screen.dart';
import 'package:eamar_app/screens/boarding/board_screen_one.dart';
import 'package:eamar_app/widgets/board/boarding_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BoardScreenThree extends StatefulWidget {
  const BoardScreenThree({super.key});

  @override
  State<BoardScreenThree> createState() => _BoardScreenThreeState();
}

class _BoardScreenThreeState extends State<BoardScreenThree> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: secondaryColor,
        body: BoardingWidget(
          textButton: 'المتابعة',
          image: 'assets/images/board/13b2676f-b476-46d4-abc5-e23c1fac96d5.png',
          heading: 'كن جزءا في التحول الي مكان افضل',
          subgeading:
              'يساهم كل تقرير تقوم به من خلال تطبيق إعمار في الجهد الجماعي لإنشاء مدينة نظيفة وجميلة لجميع السكان. تقريرًا واحدًا في كل مرة. معًا، يمكننا بناء مدينة نفخر بها.',
          colors: [greyColor, greyColor, primaryColor],
          widths: [10.0, 10.0, size.width * .20],
          onClickNext: () {
            setState(() {
              Navigator.pushAndRemoveUntil(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => const BoardScreenOne()),
                  (route) => false);
            });
          },
          onClickSkip: () {
            setState(() {
              Navigator.pushAndRemoveUntil(
                  context,
                  CupertinoPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false);
            });
          },
        ));
  }
}
