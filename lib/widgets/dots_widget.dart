import 'package:flutter/material.dart';

class DotsWidget extends StatefulWidget {
  const DotsWidget({super.key, required this.width, required this.color});

  final double width;
  final Color color;

  @override
  State<DotsWidget> createState() => _DotsWidgetState();
}

class _DotsWidgetState extends State<DotsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: 10,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
