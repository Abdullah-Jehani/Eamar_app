import 'package:eamar_app/helpers/colors.dart';
import 'package:eamar_app/screens/secondary/tabs_screen.dart';
import 'package:eamar_app/widgets/reportSubmittions/button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LastSreen extends StatefulWidget {
  const LastSreen({super.key});

  @override
  State<LastSreen> createState() => _LastSreenState();
}

class _LastSreenState extends State<LastSreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * .3,
            ),
            Center(
              child: Image.asset('assets/images/home/policyGuy.png'),
            ),
            SizedBox(
              height: size.height * .04,
            ),
            Text(
              '! تم ارسال البلاغ بنجاح ',
              style: TextStyle(
                  color: primaryColor,
                  fontFamily: 'cairo',
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * .2,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const TabsScreen()),
                      (route) => false);
                },
                child: const ReportButton(text: 'انهاء'))
          ],
        ),
      ),
    );
  }
}
