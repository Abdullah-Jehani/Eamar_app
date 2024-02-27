import 'package:flutter/material.dart';

class HeadlineWidget extends StatefulWidget {
  const HeadlineWidget({super.key, required this.text});

  @override
  State<HeadlineWidget> createState() => _HeadlineWidgetState();
  final String text;
}

class _HeadlineWidgetState extends State<HeadlineWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: const TextStyle(
          color: Colors.black,
          fontFamily: 'cairo',
          fontSize: 20,
          fontWeight: FontWeight.w400),
    );
  }
}
