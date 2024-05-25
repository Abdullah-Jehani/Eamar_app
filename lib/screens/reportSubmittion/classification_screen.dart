import 'package:eamar_app/helpers/colors.dart';
import 'package:eamar_app/providers/report_provider.dart';
import 'package:eamar_app/screens/reportSubmittion/location_screen.dart';
import 'package:eamar_app/widgets/reportSubmittions/custom_close_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReportCardWidget extends StatefulWidget {
  const ReportCardWidget({
    super.key,
    required this.image,
    required this.text,
    required this.id, // Add id to the widget
    required this.onTap,
    required this.isSelected,
  });
  final String image;
  final String text;
  final int id; // Change the id type to double
  final VoidCallback onTap;
  final bool isSelected;

  @override
  State<ReportCardWidget> createState() => _ReportCardWidgetState();
}

class _ReportCardWidgetState extends State<ReportCardWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: widget.isSelected ? primaryColor : Colors.black,
                width: widget.isSelected ? 2.5 : 0.2,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 180,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          Image.asset(
                            widget.image,
                            fit: BoxFit.contain,
                            width: 115,
                            height: 115,
                          ),
                          SizedBox(
                            height: size.height * .009,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * .02),
                            child: Text(
                              widget.text,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'cairo',
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ClassificationScreen extends StatefulWidget {
  const ClassificationScreen({super.key});

  @override
  State<ClassificationScreen> createState() => _ClassificationScreenState();
}

// Create a list of lists to store the sub-arrays (sub-reports)
List<List<Map<String, dynamic>>> subReports = [
  // Sub-reports for id: 1
  [
    {
      'id': 1,
      'image': 'assets/images/sub_report_1_1.png',
      'text': 'تشجير الارصفة'
    },
    {
      'id': 2,
      'image': 'assets/images/sub_report_1_2.png',
      'text': 'ارصفة متهالكة'
    },
    {
      'id': 3,
      'image': 'assets/images/sub_report_1_2.png',
      'text': 'المطبات العشوائية'
    },
    {
      'id': 4,
      'image': 'assets/images/sub_report_2_1.png',
      'text': 'حفر الشوارع'
    },
    {
      'id': 5,
      'image': 'assets/images/sub_report_2_2.png',
      'text': 'سياج طريق مصدوم'
    },
    {
      'id': 6,
      'image': 'assets/images/sub_report_3_1.png',
      'text': 'اغطية الصرف الصحي'
    },
    {
      'id': 7,
      'image': 'assets/images/sub_report_3_2.png',
      'text': 'عدم دهان الشوارع'
    },
    {
      'id': 8,
      'image': 'assets/images/sub_report_3_2.png',
      'text': 'السيارات التالفة'
    },
    // ... more sub-reports for id: 1
  ],
  // Sub-reports for id: 2
  [
    {
      'id': 9,
      'image': 'assets/images/sub_report_1_1.png',
      'text': 'تشجير الارصفة'
    },
    {
      'id': 10,
      'image': 'assets/images/sub_report_1_2.png',
      'text': 'ارصفة متهالكة'
    },
    {
      'id': 11,
      'image': 'assets/images/sub_report_1_2.png',
      'text': 'المطبات العشوائية'
    },
    {
      'id': 12,
      'image': 'assets/images/sub_report_2_1.png',
      'text': 'حفر الشوارع'
    },
    {
      'id': 13,
      'image': 'assets/images/sub_report_2_2.png',
      'text': 'سياج طريق مصدوم'
    },
    {
      'id': 14,
      'image': 'assets/images/sub_report_3_1.png',
      'text': 'اغطية الصرف الصحي'
    },
    {
      'id': 15,
      'image': 'assets/images/sub_report_3_2.png',
      'text': 'عدم دهان الشوارع'
    },
    {
      'id': 16,
      'image': 'assets/images/sub_report_3_2.png',
      'text': 'السيارات التالفة'
    },
    // ... more sub-reports for id: 2
  ],
  [
    {
      'id': 17,
      'image': 'assets/images/sub_report_1_1.png',
      'text': 'تشجير الارصفة'
    },
    {
      'id': 18,
      'image': 'assets/images/sub_report_1_2.png',
      'text': 'ارصفة متهالكة'
    },
    {
      'id': 19,
      'image': 'assets/images/sub_report_1_2.png',
      'text': 'المطبات العشوائية'
    },
    {
      'id': 20,
      'image': 'assets/images/sub_report_2_1.png',
      'text': 'حفر الشوارع'
    },
    {
      'id': 21,
      'image': 'assets/images/sub_report_2_2.png',
      'text': 'سياج طريق مصدوم'
    },
    {
      'id': 22,
      'image': 'assets/images/sub_report_3_1.png',
      'text': 'اغطية الصرف الصحي'
    },
    {
      'id': 23,
      'image': 'assets/images/sub_report_3_2.png',
      'text': 'عدم دهان الشوارع'
    },
    {
      'id': 24,
      'image': 'assets/images/sub_report_3_2.png',
      'text': 'السيارات التالفة'
    },
    // ... more sub-reports for id: 2
  ],
  [
    {
      'id': 25,
      'image': 'assets/images/sub_report_4_1.png',
      'text': 'Sub Report 4.1'
    },
    {
      'id': 26,
      'image': 'assets/images/sub_report_4_2.png',
      'text': 'Sub Report 4.2'
    },
    // ... more sub-reports for id: 2
  ],
  [
    {
      'id': 27,
      'image': 'assets/images/sub_report_5_1.png',
      'text': 'Sub Report 5.1'
    },
    {
      'id': 28,
      'image': 'assets/images/sub_report_5_2.png',
      'text': 'Sub Report 5.2'
    },
  ],
];

int? selectedIndex;
List<Map<String, dynamic>> reports = [
  {
    'id': 1, // Make the id type double for consistency
    'image': 'assets/images/home/road.png',
    'text': 'الطرق والشوارع',
  },
  {
    'id': 2, // Make the id type double for consistency
    'image': 'assets/images/home/light.png',
    'text': ' الانارة والمرافق الخدمية ',
  },
  {
    'id': 3, // Make the id type double for consistency
    'image': 'assets/images/home/building.png',
    'text': ' المباني والبنايات قيد الانشاء',
  },
  {
    'id': 4, // Make the id type double for consistency
    'image': 'assets/images/home/public.png',
    'text': 'المظهر العام',
  },
  {
    'id': 5, // Make the id type double for consistency
    'image': 'assets/images/home/store.png',
    'text': 'الاسواق والمتاجر',
  },
];

class _ClassificationScreenState extends State<ClassificationScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<ReportProvider>(
      builder: (context, reportProvider, child) {
        // Get the selected report ID
        final selectedReportId = reportProvider.selectedReportId;

        // Calculate the index of the sub-reports list based on the selected report ID
        final subReportIndex =
            selectedReportId != null && selectedReportId <= subReports.length
                ? selectedReportId - 1
                : 0;

        return Scaffold(
          // Scaffold inside Consumer
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * .06),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * .09,
                ),
                const CustomClose(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    'اختر التصنيف التخصصي',
                    style: TextStyle(
                        color: textColor,
                        fontFamily: 'cairo',
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                // Display the sub-reports based on the selected report ID
                if (selectedReportId != null)
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 12,
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                          ),
                          itemCount: subReports[subReportIndex].length,
                          itemBuilder: (context, index) {
                            return ReportCardWidget(
                              image: subReports[subReportIndex][index]
                                  ['image']!,
                              text: subReports[subReportIndex][index]['text']!,
                              id: subReports[subReportIndex][index]
                                  ['id'], // Pass id to the widget
                              onTap: () {
                                final reportProvider =
                                    Provider.of<ReportProvider>(context,
                                        listen: false);
                                // Update the selected classification id
                                reportProvider.selectedClassId =
                                    subReports[subReportIndex][index]['id'];

                                setState(() {
                                  selectedIndex = index;
                                });
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            const LocationScreen()));
                              },
                              isSelected: selectedIndex == index,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
