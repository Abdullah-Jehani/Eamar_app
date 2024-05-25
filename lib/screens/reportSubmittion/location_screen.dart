import 'package:eamar_app/providers/report_provider.dart';
import 'package:eamar_app/widgets/reportSubmittions/custom_close_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ReportProvider>(
      builder: (context, cardProvider, _) {
        return const Scaffold(
            body: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            CustomClose()
          ],
        ));
      },
    );
  }
}
