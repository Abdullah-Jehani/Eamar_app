import 'dart:io';

import 'package:eamar_app/providers/report_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NextScreen extends StatefulWidget {
  const NextScreen({super.key});

  @override
  State<NextScreen> createState() => _NextScreenState();
}

class _NextScreenState extends State<NextScreen> {
  @override
  Widget build(BuildContext context) {
    final reportProvider = Provider.of<ReportProvider>(context);
    return Image.file(
      File(reportProvider.imagePath!),
      width: 10,
      height: 10,
    );
  }
}
