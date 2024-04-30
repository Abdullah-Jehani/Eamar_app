import 'package:eamar_app/helpers/colors.dart';
import 'package:flutter/material.dart';

class RowWidget extends StatefulWidget {
  const RowWidget({super.key, required this.headLine, required this.subHead});
  final String headLine;
  final String subHead;

  @override
  State<RowWidget> createState() => _RowWidgetState();
}

class _RowWidgetState extends State<RowWidget> {
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        Text(
          (' :') + widget.headLine,
          style: TextStyle(color: darkBlue, fontSize: 18, fontFamily: 'cairo'),
        ),
        Text(
          widget.subHead,
          style: TextStyle(color: textColor, fontFamily: 'cairo', fontSize: 16),
        ),
      ],
    );
  }
}
