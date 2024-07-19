import 'package:eamar_app/helpers/colors.dart';
import 'package:flutter/material.dart';

class ReportCardWidget extends StatefulWidget {
  const ReportCardWidget({super.key, required this.image, required this.text});
  final String image;
  final String text;
  @override
  State<ReportCardWidget> createState() => _ReportCardWidgetState();
}

class _ReportCardWidgetState extends State<ReportCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black, width: .2),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 180, // Set the desired height for the image container
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        Image.asset(
                          widget.image,
                          fit: BoxFit.contain,
                          width: 130,
                          height: 130,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.text,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'cairo',
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
