import 'package:eamar_app/helpers/colors.dart';
import 'package:eamar_app/widgets/helper/close_widget.dart';
import 'package:eamar_app/widgets/helper/report_status.dart';
import 'package:eamar_app/widgets/report/row_widget.dart';
import 'package:flutter/material.dart';

class ReportDetails extends StatefulWidget {
  final Map<String, dynamic> report;

  const ReportDetails({super.key, required this.report});

  @override
  State<ReportDetails> createState() => _ReportDetailsState();
}

class _ReportDetailsState extends State<ReportDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * .07,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: size.width * .03),
                  child: const CloseWidget(),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(right: size.width * .03),
                      child: Text(
                        'بيانات البلاغ',
                        style: TextStyle(
                            color: darkBlue, fontSize: 24, fontFamily: 'cairo'),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * .03,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * .035),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: TextDirection.rtl,
                children: [
                  ReportStatus(
                    bgColor: widget.report['status'] == 'Pinned'
                        ? caution
                        : widget.report['status'] == 'Completed'
                            ? success
                            : danger,
                    text: widget.report['status'] == 'Pinned'
                        ? 'قيد المراجعة'
                        : widget.report['status'] == 'Completed'
                            ? 'تم الانتهاء'
                            : 'مرفوض',
                  ),
                  SizedBox(
                    height: size.height * .04,
                  ),
                  RowWidget(
                    headLine: 'تصنيف البلاغ',
                    subHead: widget.report['report_classification'].toString(),
                  ),
                  SizedBox(
                    height: size.height * .04,
                  ),
                  RowWidget(
                    headLine: 'التصنيف التخصصي',
                    subHead: widget.report['sub_classification_id'].toString(),
                  ),
                  SizedBox(
                    height: size.height * .04,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    textDirection: TextDirection.rtl,
                    children: [
                      Text(
                        ' :وصف البلاغ',
                        style: TextStyle(
                            color: darkBlue, fontSize: 18, fontFamily: 'cairo'),
                      ),
                      SizedBox(
                        height: size.height * .009,
                      ),
                      Text(
                        widget.report['description'] ?? '',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: textColor,
                            fontFamily: 'cairo',
                            fontSize: 16),
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.height * .04,
                  ),
                  RowWidget(
                    headLine: 'مرسل البلاغ',
                    subHead:
                        '${widget.report['first_name']} ${widget.report['last_name']}',
                  ),
                  SizedBox(
                    height: size.height * .04,
                  ),
                  RowWidget(
                    headLine: 'موقع البلاغ',
                    subHead: widget.report['location_name'] ?? '',
                  ),
                  SizedBox(
                    height: size.height * .04,
                  ),
                  RowWidget(
                    headLine: 'تاريخ البلاغ',
                    subHead: widget.report['created_at'] ?? '',
                  ),
                  SizedBox(
                    height: size.height * .1,
                  ),
                  Text(
                    textAlign: TextAlign.right,
                    '.بمجرد تقديم التقرير، سيتم إحالته للسلطات المحلية للمراجعة والتحقق. يتطلب حل المشكلة المبلغ عنها وقتًا قد يختلف حسب طبيعة المشكلة وأولويتها. نشكرك على صبرك وتفهمك أثناء انتظار الإجراءات المناسبة',
                    style: TextStyle(
                        color: textColor, fontSize: 12, fontFamily: 'cairo'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
