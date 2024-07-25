import 'package:flutter/material.dart';
import 'package:eamar_app/helpers/colors.dart';

class RowWidget extends StatelessWidget {
  final String headLine;
  final Widget subHead;

  const RowWidget({super.key, required this.headLine, required this.subHead});

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        Text(
          (' :') + headLine,
          style: TextStyle(color: darkBlue, fontSize: 18, fontFamily: 'cairo'),
        ),
        Expanded(
          child: subHead,
        ),
      ],
    );
  }
}
