import 'dart:ui';

import 'package:eamar_app/helpers/colors.dart';
import 'package:eamar_app/widgets/home/button_widget.dart';
import 'package:flutter/material.dart';

class ReportCard extends StatefulWidget {
  const ReportCard(
      {super.key,
      required this.issueType,
      required this.issueDetail,
      required this.days});

  @override
  State<ReportCard> createState() => _ReportCardState();
  final String issueType;
  final String issueDetail;
  final int days;
}

class _ReportCardState extends State<ReportCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(bottom: size.height * .02),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black, width: 1),
              color: secondaryColor,
            ),
            width: size.width * 1,
            height: size.height * 0.15,
          ),
          Padding(
            padding: EdgeInsets.only(
                top: size.height * 0.025, right: size.height * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      widget.issueType,
                      style: TextStyle(
                        color: primaryColor,
                        fontFamily: 'cairo',
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: size.height * 0.015),
                      child: Text(
                        widget.issueDetail,
                        style: const TextStyle(
                            color: Colors.black, fontFamily: 'cairo'),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: size.height * 0.01, left: size.height * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ' قبل ${widget.days} يوم ',
                      style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'cairo',
                          fontSize: 13),
                    ),
                    SizedBox(
                      height: size.height * 0.025,
                    ),
                    const ButtonWidget(
                      text: 'عرض بيانات البلاغ',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
