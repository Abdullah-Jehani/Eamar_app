import 'package:eamar_app/widgets/reportSubmittions/custom_close_widget.dart';
import 'package:flutter/material.dart';

class ClassificationScreen extends StatefulWidget {
  const ClassificationScreen({super.key});

  @override
  State<ClassificationScreen> createState() => _ClassificationScreenState();
}

class _ClassificationScreenState extends State<ClassificationScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * .06),
        child: Column(
          children: [
            SizedBox(
              height: size.height * .09,
            ),
            const CustomClose()
          ],
        ),
      ),
    );
  }
}
