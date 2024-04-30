import 'package:eamar_app/helpers/colors.dart';
import 'package:eamar_app/widgets/helper/close_widget.dart';
import 'package:eamar_app/widgets/helper/report_status.dart';
import 'package:eamar_app/widgets/report/row_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ReportDetails extends StatefulWidget {
  const ReportDetails({super.key});

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
                  ReportStatus(bgColor: caution, text: 'معلق'),
                  SizedBox(
                    height: size.height * .04,
                  ),
                  const RowWidget(
                    headLine: 'تصنيف البلاغ',
                    subHead: 'الأنارة والمرافق الخدمية',
                  ),
                  SizedBox(
                    height: size.height * .04,
                  ),
                  const RowWidget(
                    headLine: 'التصنيف التخصصي',
                    subHead: 'أعمدة الأنارة',
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
                        textAlign: TextAlign.right,
                        'حتى تم, احداث سبتمبر ٣٠ جهة. هو تحت ليبين بمعارضة كما الشتاء للسيطرة, في إجلاء أجزاء الإنزال بحق. مكّن  من يكن قررت هاربر تغييرات, وتم إذ كردة الأرض الإمتعاض. بها هو دفّة إعلان لتقليعة, لم معقل استرجاع قبل. قد ',
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
                  const RowWidget(
                    headLine: 'مرسل البلاغ',
                    subHead: 'عبدالله الجهاني',
                  ),
                  SizedBox(
                    height: size.height * .04,
                  ),
                  const RowWidget(
                    headLine: 'موقع البلاغ',
                    subHead: 'بنغازي - الهواري ',
                  ),
                  SizedBox(
                    height: size.height * .04,
                  ),
                  const RowWidget(
                    headLine: 'تاريخ البلاغ',
                    subHead: '02/09/2024',
                  ),
                  SizedBox(
                    height: size.height * .1,
                  ),
                  Text(
                    textAlign: TextAlign.right,
                    '.بمجرد تقديم التقرير، سيتم إحالته للسلطات المحلية للمراجعة والتحقق. يتطلب حل المشكلة المبلغ عنها وقتًا قد يختلف حسب طبيعة المشكلة وأولويتها. نشكرك على صبرك وتفهمك أثناء انتظار الإجراءات المناسبة',
                    style: TextStyle(
                        color: textColor, fontSize: 12, fontFamily: 'cairo'),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
