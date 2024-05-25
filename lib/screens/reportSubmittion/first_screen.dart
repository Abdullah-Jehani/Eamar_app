import 'package:eamar_app/helpers/colors.dart';
import 'package:eamar_app/providers/report_provider.dart';
import 'package:eamar_app/screens/reportSubmittion/camera_screen.dart';
import 'package:eamar_app/widgets/helper/close_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider

// widget of card report
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
  final int id; // Add id to the widget
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

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

List<Map<String, dynamic>> reports = [
  {
    'id': 1,
    'image': 'assets/images/home/road.png',
    'text': 'الطرق والشوارع',
  },
  {
    'id': 2,
    'image': 'assets/images/home/light.png',
    'text': ' الانارة والمرافق الخدمية ',
  },
  {
    'id': 3,
    'image': 'assets/images/home/building.png',
    'text': ' المباني والبنايات قيد الانشاء',
  },
  {
    'id': 4,
    'image': 'assets/images/home/public.png',
    'text': 'المظهر العام',
  },
  {
    'id': 5,
    'image': 'assets/images/home/store.png',
    'text': 'الاسواق والمتاجر',
  },
];

class _FirstScreenState extends State<FirstScreen> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: size.height * .09,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * .06),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: size.width * .03),
                  child: const CloseWidget(),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'اختر تصنيف البلاغ',
                      style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'cairo',
                          fontSize: 20),
                    ),
                    SizedBox(
                      height: size.height * .015,
                    ),
                    const Text(
                      'قم بتحديد نوع البلاغ الذي تود تقديمه',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'cairo',
                          fontSize: 14),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * .01,
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 12,
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                  ),
                  itemCount: reports.length,
                  itemBuilder: (context, index) {
                    return ReportCardWidget(
                      image: reports[index]['image']!,
                      text: reports[index]['text']!,
                      id: reports[index]['id'], // Pass id to the widget
                      onTap: () {
                        // Get the ReportProvider instance from context
                        final reportProvider =
                            Provider.of<ReportProvider>(context, listen: false);
                        // Update the selected id
                        reportProvider.selectedId = reports[index]['id'];

                        setState(() {
                          selectedIndex = index;
                        });
                        Navigator.pushAndRemoveUntil(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => const CameraScreen()),
                            (route) => false);
                      },
                      isSelected: selectedIndex == index,
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * .06,
            ),
            child: Text(
              textAlign: TextAlign.end,
              'تحديد الفئة المناسبة أمر مهم لضمان معالجة أفضل للبلاغ. من خلال اختيار الفئة الصحيحة، يتسنى لنا توجيه الجهود وتنظيم العمليات بشكل أفضل، مما يسهم في تحسين تجربة المستخدم وتسريع حل المشكلة.',
              style: TextStyle(
                  color: textColor, fontFamily: 'cairo', fontSize: 12),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
