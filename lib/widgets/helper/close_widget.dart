import 'package:eamar_app/helpers/colors.dart';
import 'package:eamar_app/screens/secondary/tabs_screen.dart';
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
            CupertinoPageRoute(builder: (context) => const TabsScreen()),
            (route) => false);
      },
      child: Container(
        decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(24))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Text(
            'X',
            style: TextStyle(
                color: primaryColor, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
