import 'package:eamar_app/helpers/colors.dart';
import 'package:eamar_app/screens/secondary/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:eamar_app/providers/report_provider.dart';
import 'package:eamar_app/widgets/report/row_widget.dart';
import 'package:eamar_app/widgets/reportSubmittions/button_widget.dart';
import 'package:eamar_app/widgets/helper/close_widget.dart';
import 'package:eamar_app/widgets/helper/report_status.dart';

class ReportDetails extends StatefulWidget {
  final Map<String, dynamic> report;

  const ReportDetails({super.key, required this.report});

  @override
  State<ReportDetails> createState() => _ReportDetailsState();
}

class _ReportDetailsState extends State<ReportDetails> {
  String formatDate(String dateStr) {
    final dateTime = DateTime.parse(dateStr);
    final formattedDate = dateTime.toString().split(' ').first;
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final String status = widget.report['status'];
    final bool isPinned = status == 'Pinned';

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
              height: size.height * .05,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * .035),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: TextDirection.rtl,
                children: [
                  ReportStatus(
                    bgColor: isPinned
                        ? caution
                        : (status == 'Completed' ? success : danger),
                    text: isPinned
                        ? 'قيد المراجعة'
                        : (status == 'Completed' ? 'تم الانهاء' : 'مرفوض'),
                  ),
                  SizedBox(
                    height: size.height * .04,
                  ),
                  RowWidget(
                    headLine: 'تصنيف البلاغ',
                    subHead: Text(
                      widget.report['classification_name'].toString(),
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: 16, fontFamily: 'cairo', color: textColor),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .04,
                  ),
                  RowWidget(
                    headLine: 'التصنيف التخصصي',
                    subHead: Text(
                      widget.report['sub_classification_name'].toString(),
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: 16, fontFamily: 'cairo', color: textColor),
                    ),
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
                    subHead: Text(
                      '${widget.report['first_name']} ${widget.report['last_name']}',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: 16, fontFamily: 'cairo', color: textColor),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .04,
                  ),
                  RowWidget(
                    headLine: 'موقع البلاغ',
                    subHead: Text(
                      widget.report['location_name'] ?? '',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: 16, fontFamily: 'cairo', color: textColor),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .04,
                  ),
                  RowWidget(
                    headLine: 'تاريخ البلاغ',
                    subHead: Text(
                      formatDate(widget.report['created_at']),
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: 16, fontFamily: 'cairo', color: textColor),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .04,
                  ),
                  if (!isPinned)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      textDirection: TextDirection.rtl,
                      children: [
                        Text(
                          ' :الرد علي البلاغ',
                          style: TextStyle(
                              color: darkBlue,
                              fontSize: 18,
                              fontFamily: 'cairo'),
                        ),
                        SizedBox(
                          height: size.height * .009,
                        ),
                        Text(
                          widget.report['feedback'] ?? '',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: textColor,
                              fontFamily: 'cairo',
                              fontSize: 16),
                        )
                      ],
                    ),
                  SizedBox(
                    height: size.height * .05,
                  ),
                  Text(
                    textAlign: TextAlign.right,
                    '.بمجرد تقديم التقرير، سيتم إحالته للسلطات المحلية للمراجعة والتحقق. يتطلب حل المشكلة المبلغ عنها وقتًا قد يختلف حسب طبيعة المشكلة وأولويتها. نشكرك على صبرك وتفهمك أثناء انتظار الإجراءات المناسبة',
                    style: TextStyle(
                        color: textColor, fontSize: 12, fontFamily: 'cairo'),
                  ),
                  SizedBox(
                    height: size.height * .04,
                  ),
                  if (!isPinned)
                    GestureDetector(
                      onTap: () async {
                        final reportProvider =
                            Provider.of<ReportProvider>(context, listen: false);
                        final reportId = widget.report['id'];
                        final bool isSuccess =
                            await reportProvider.deleteReport(reportId);

                        if (isSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              showCloseIcon: true,
                              content: Text(
                                'تم حذف البلاغ',
                                style: TextStyle(
                                    color: Colors.white, fontFamily: 'cairo'),
                              ),
                            ),
                          );
                          Navigator.pushAndRemoveUntil(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => TabsScreen()),
                            (route) => false,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'حدث خطأ أثناء حذف البلاغ , الرجاء التحقق من الاتصال بالانترنت',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'cairo')),
                            ),
                          );
                        }
                      },
                      child: const ReportButton(
                        text: 'اغلاق البلاغ',
                      ),
                    ),
                  SizedBox(
                    height: size.height * .02,
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
