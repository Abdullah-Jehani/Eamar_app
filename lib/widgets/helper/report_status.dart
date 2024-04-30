import 'package:flutter/material.dart';

class ReportStatus extends StatefulWidget {
  const ReportStatus({super.key, required this.bgColor, required this.text});
  final Color bgColor;
  final String text;

  @override
  State<ReportStatus> createState() => _ReportStatusState();
}

class _ReportStatusState extends State<ReportStatus> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.bgColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
        child: Text(
          widget.text,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'cairo',
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
