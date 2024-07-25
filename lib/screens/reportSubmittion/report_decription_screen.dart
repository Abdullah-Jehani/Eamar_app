import 'package:eamar_app/helpers/colors.dart';
import 'package:eamar_app/providers/report_provider.dart';
import 'package:eamar_app/screens/reportSubmittion/last_screen.dart';
import 'package:eamar_app/widgets/reportSubmittions/button_widget.dart';
import 'package:eamar_app/widgets/reportSubmittions/custom_close_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReportDescription extends StatefulWidget {
  const ReportDescription({super.key});

  @override
  State<ReportDescription> createState() => _ReportDescriptionState();
}

class _ReportDescriptionState extends State<ReportDescription> {
  TextEditingController descriptionController = TextEditingController();
  bool isClicked = false; // Initial value set to false

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<ReportProvider>(
      builder: (context, report, _) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * .04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: size.height * .1,
                  ),
                  const CustomClose(),
                  SizedBox(
                    height: size.height * .04,
                  ),
                  Text(
                    'ادخل وصف البلاغ بشكل دقيق',
                    style: TextStyle(
                        color: textColor,
                        fontFamily: 'cairo',
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: size.height * .04,
                  ),
                  Text(
                    'وصف البلاغ',
                    style: TextStyle(
                      color: textColor,
                      fontFamily: 'cairo',
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: size.height * .014,
                  ),
                  Container(
                    height: size.height * 0.28,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: textColor,
                      ),
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                    child: TextField(
                      maxLength: 180,
                      controller: descriptionController,
                      maxLines: 4, // Allow unlimited lines
                      style: TextStyle(
                          color: textColor, fontFamily: 'cairo', fontSize: 14),
                      decoration: const InputDecoration(
                        hintTextDirection: TextDirection.rtl,
                        border: InputBorder.none,
                        hintText: ' الرجاء ادخال وصف عن البلاغ ....',
                        hintStyle: TextStyle(
                          fontFamily: 'cairo',
                          fontSize: 14,
                        ),
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                  SizedBox(
                    height: size.height * .08,
                  ),
                  const Text(
                    textAlign: TextAlign.right,
                    'اقر واتعهد بصحة كافة البيانات والمرفقات التي تم رفعها على التطبيق وأتحمل كافة المسؤولية القانونية حيال البلاغات الكاذبة',
                    style: TextStyle(
                        color: Colors.black, fontFamily: 'cairo', fontSize: 14),
                  ),
                  SizedBox(
                    height: size.height * .02,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: secondaryColor,
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * .01),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'اقر واتعهد على ما تم ذكره أعلاه',
                            style: TextStyle(
                                color: primaryColor,
                                fontFamily: 'cairo',
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          Checkbox(
                            value: isClicked,
                            onChanged: (value) {
                              setState(() {
                                isClicked =
                                    value!; // Update the value correctly
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .095,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (isClicked && descriptionController.text.isNotEmpty) {
                        // Update the report provider with the description
                        report.description = descriptionController.text;

                        // Call the submitReport method to submit the data
                        await report.submitReport();

                        // Navigate to the next screen if the report is submitted successfully
                        Navigator.pushAndRemoveUntil(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const LastSreen(),
                          ),
                          (route) => false,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            showCloseIcon: true,
                            content: Text(
                              textAlign: TextAlign.right,
                              'الرجاء ادخال وصف للبلاغ',
                              style:
                                  TextStyle(fontFamily: 'cairo', fontSize: 14),
                            ),
                          ),
                        );
                      }
                    },
                    child: ReportButton(
                      text: 'تقديم البلاغ',
                      bgColor:
                          isClicked && descriptionController.text.isNotEmpty
                              ? primaryColor
                              : greyColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
