import 'package:eamar_app/helpers/colors.dart';
import 'package:eamar_app/providers/report_provider.dart';
import 'package:eamar_app/screens/reports/report_details.dart';
import 'package:eamar_app/widgets/center/card_widget.dart';
import 'package:eamar_app/widgets/home/button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CenterScreen extends StatefulWidget {
  const CenterScreen({super.key, Key? key2});

  @override
  State<CenterScreen> createState() => _CenterScreenState();
}

class _CenterScreenState extends State<CenterScreen> {
  List<Map<String, dynamic>> allReports = [];
  List<Map<String, dynamic>> displayedReports = [];
  late ReportProvider reportProvider;

  @override
  void initState() {
    super.initState();
    reportProvider = Provider.of<ReportProvider>(context, listen: false);
    _fetchReports();
  }

  Future<void> _fetchReports() async {
    await reportProvider.fetchReports();
    setState(() {
      allReports = reportProvider.reports;
      displayedReports =
          allReports; // Initialize displayedReports with all reports
    });
  }

  void runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = allReports;
    } else {
      results = allReports.where((report) {
        String issueType = report["report_classification_id"].toString() ?? "";
        String issueSpecific = report["description"] ?? "";

        return issueType.toLowerCase().contains(enteredKeyword.toLowerCase()) ||
            issueSpecific.toLowerCase().contains(enteredKeyword.toLowerCase());
      }).toList();
    }
    setState(() {
      displayedReports = results;
    });
  }

  TextEditingController searchController = TextEditingController();

  int calculateDaysSince(String createdAt) {
    DateTime createdDate = DateTime.parse(createdAt);
    DateTime currentDate = DateTime.now();
    return currentDate.difference(createdDate).inDays;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: allReports.isNotEmpty
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * .04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: size.height * .06),
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
                        color: textColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      prefixIcon: const Icon(Icons.search),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: textColor.withOpacity(.4),
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * .02),
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
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: displayedReports.isNotEmpty
                        ? GestureDetector(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        const ReportDetails()),
                                (route) => false,
                              );
                            },
                            child: ListView.builder(
                              itemCount: displayedReports.length,
                              itemBuilder: (context, index) {
                                final report = displayedReports[index];
                                int days = calculateDaysSince(report[
                                    "created_at"]); // Calculate days since created

                                return ReportCard(
                                  key: ValueKey(report["id"]),
                                  issueType: report["report_classification_id"]
                                      .toString(), // Ensure it matches the expected type
                                  issueDetail: report["description"] ??
                                      'No Issue Details',
                                  days: days,
                                );
                              },
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.only(bottom: size.height * .1),
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
                                      fontFamily: 'cairo',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            )
          : Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/NoReportedIssueFoundeed.png'),
                  SizedBox(height: size.height * .05),
                  const Text(
                    'عذرا, يبدو انه لا يوجد لديك أي بلاغات سابقة !',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'cairo',
                    ),
                  ),
                  SizedBox(height: size.height * .04),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * .3),
                    child: const ButtonWidget(text: 'ارفع بلاغ'),
                  ),
                ],
              ),
            ),
    );
  }
}
