import 'package:eamar_app/helpers/colors.dart';
import 'package:eamar_app/screens/reports/report_details.dart';
import 'package:eamar_app/widgets/center/card_widget.dart';
import 'package:eamar_app/widgets/home/button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CenterScreen extends StatefulWidget {
  const CenterScreen({super.key, Key? key2});

  @override
  State<CenterScreen> createState() => _CenterScreenState();
}

class _CenterScreenState extends State<CenterScreen> {
  List<Map<String, dynamic>> reports = [
    {
      "id": 1,
      'issueType': 'الانارة والمرافق الخدمية',
      "issueDetails": 'أعمدة الانارة',
      "days": 12
    },
    {
      "id": 2,
      'issueType': 'البنية التحتية للطرق',
      "issueDetails": 'تشققات الطريق',
      "days": 122
    },
    {
      "id": 3,
      'issueType': 'البنية التحتية للطرق',
      "issueDetails": 'تشققات الطريق',
      "days": 13
    },
  ];
  List<Map<String, dynamic>> foundReports = [];
  @override
  initState() {
    foundReports = reports;
    super.initState();
  }

  void runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = reports;
    } else {
      results = reports
          .where((user) => user["issueType"]
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      foundReports = results;
    });
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: reports.isNotEmpty
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * .04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: size.height * .06,
                    ),
                    TextField(
                      controller: searchController,
                      maxLength: 24,
                      onChanged: (value) => runFilter(value),
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                        hintText: 'البحث عن البلاغات',
                        hintStyle: TextStyle(
                            fontFamily: 'cairo',
                            fontSize: 18,
                            color: textColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        prefixIcon: const Icon(
                          Icons.search,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: textColor.withOpacity(
                                .4), // Set the focused border color here
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * .02,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: size.width * .03),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            children: [
                              Text(
                                'الاحدث',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    decorationColor: primaryColor,
                                    decorationThickness: 2.0,
                                    color: primaryColor,
                                    fontSize: 18,
                                    fontFamily: 'cairo',
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                        child: foundReports.isNotEmpty
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              const ReportDetails()),
                                      (route) => false);
                                },
                                child: ListView.builder(
                                  itemCount: foundReports
                                      .length, // Set the number of items in the list to 1
                                  itemBuilder: (context, index) {
                                    return ReportCard(
                                      key: ValueKey(foundReports[index]["id"]),
                                      issueType: foundReports[index]
                                          ["issueType"],
                                      issueDetail: foundReports[index]
                                          ["issueDetails"],
                                      days: foundReports[index]["days"],
                                    );
                                  },
                                ),
                              )
                            : Padding(
                                padding:
                                    EdgeInsets.only(bottom: size.height * .2),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/icons/NoResultsFounded.png',
                                        width: size.width * .6,
                                      ),
                                      Text(
                                        'عذرا , يبدو انه لايوجد نتائج لبحثك',
                                        style: TextStyle(
                                            color: textColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'cairo'),
                                      )
                                    ],
                                  ),
                                ),
                              )),
                  ],
                ),
              )
            : Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/icons/NoReportedIssueFoundeed.png'),
                    SizedBox(
                      height: size.height * .05,
                    ),
                    const Text(
                      'عذرا, يبدو انه لا يوجد لديك أي بلاغات سابقة !',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'cairo'),
                    ),
                    SizedBox(
                      height: size.height * .04,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * .3),
                      child: const ButtonWidget(text: 'ارفع بلاغ'),
                    )
                  ],
                ),
              ));
  }
}
