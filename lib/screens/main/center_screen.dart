import 'package:flutter/material.dart';

class CenterScreen extends StatefulWidget {
  const CenterScreen({super.key});

  @override
  State<CenterScreen> createState() => _CenterScreenState();
}

class _CenterScreenState extends State<CenterScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('center screen ')],
      ),
    );
  }
}
