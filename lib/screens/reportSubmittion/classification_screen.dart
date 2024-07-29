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
    this.image,
    required this.text,
    required this.id,
    required this.onTap,
    required this.isSelected,
  });

  final String? image;
  final String text;
  final int id;
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
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          SizedBox(
                            height: size.height * .08,
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

class _ClassificationScreenState extends State<ClassificationScreen> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<ReportProvider>(
      builder: (context, reportProvider, child) {
        final selectedReportId = reportProvider.selectedReportId;

        // Trigger data fetch when a report classification is selected
        if (selectedReportId != null &&
            reportProvider.subClassifications.isEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            reportProvider.fetchSubClassifications(selectedReportId);
          });
        }

        return Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * .06),
            child: Column(
              children: [
                SizedBox(height: size.height * .09),
                GestureDetector(
                  onTap: () => {
                    Provider.of<ReportProvider>(context, listen: false)
                        .clearAllData(),
                  },
                  child: const CustomClose(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    'اختر التصنيف التخصصي',
                    style: TextStyle(
                      color: textColor,
                      fontFamily: 'cairo',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Show loading indicator if fetching
                if (reportProvider.isLocating)
                  const Center(child: CircularProgressIndicator()),
                if (reportProvider.subClassifications.isNotEmpty)
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 12,
                        ),
                        itemCount: reportProvider.subClassifications.length,
                        itemBuilder: (context, index) {
                          final subclassification =
                              reportProvider.subClassifications[index];
                          return ReportCardWidget(
                            text: subclassification['name']!,
                            id: subclassification['id'],
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                              reportProvider.selectedClassId =
                                  subclassification['id'];
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        const LocationScreen()),
                              );
                            },
                            isSelected: selectedIndex == index,
                          );
                        },
                      ),
                    ),
                  ),
                if (reportProvider.subClassifications.isEmpty &&
                    !reportProvider.isLocating)
                  const Center(child: Text('No sub-classifications available')),
              ],
            ),
          ),
        );
      },
    );
  }
}
