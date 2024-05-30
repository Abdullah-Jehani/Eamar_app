import 'package:eamar_app/helpers/colors.dart';
import 'package:flutter/material.dart';

class ReportButton extends StatefulWidget {
  const ReportButton({super.key, required this.text});

  @override
  State<ReportButton> createState() => _ReportButtonState();
  final String text;
}

class _ReportButtonState extends State<ReportButton> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * .02),
      child: Container(
        height: size.height * 0.06,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Center(
          child: Text(
            widget.text,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'cairo',
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
