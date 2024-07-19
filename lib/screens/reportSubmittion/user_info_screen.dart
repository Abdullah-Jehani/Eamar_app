import 'package:eamar_app/widgets/reportSubmittions/custom_close_widget.dart';
import 'package:flutter/material.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [CustomClose()],
      ),
    );
  }
}
