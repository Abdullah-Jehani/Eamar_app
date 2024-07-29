import 'package:eamar_app/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/uil.dart';

class NextVersionScreen extends StatefulWidget {
  const NextVersionScreen({super.key});

  @override
  State<NextVersionScreen> createState() => _NextVersionScreenState();
}

class _NextVersionScreenState extends State<NextVersionScreen> {
  void _navigateBack() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: _navigateBack,
          child: Iconify(
            Uil.arrow_left,
            color: primaryColor,
            size: 12,
          ),
        ),
        title: GestureDetector(
          onTap: _navigateBack,
          child: Text(
            'الرجوع',
            style: TextStyle(
              color: primaryColor,
              fontFamily: 'cairo',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: const Center(
        child: Text(
          'سيتم توفير هذه الخاصية في المستقبل',
          style:
              TextStyle(fontFamily: 'cairo', fontSize: 20, color: Colors.black),
        ),
      ),
    );
  }
}
