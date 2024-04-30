import 'package:eamar_app/helpers/colors.dart';
import 'package:eamar_app/screens/main/center_screen.dart';
import 'package:eamar_app/screens/reports/report_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CloseWidget extends StatefulWidget {
  const CloseWidget({super.key});

  @override
  State<CloseWidget> createState() => _CloseWidgetState();
}

class _CloseWidgetState extends State<CloseWidget> {
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(builder: (context) => const CenterScreen()),
            (route) => false);
      },
      child: Container(
        decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(24))),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Text(
            'X',
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
