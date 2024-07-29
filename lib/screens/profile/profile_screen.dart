import 'dart:async';

import 'package:eamar_app/helpers/colors.dart';
import 'package:eamar_app/screens/secondary/tabs_screen.dart';
import 'package:eamar_app/widgets/helper/close_widget.dart';
import 'package:eamar_app/widgets/register/input_field_widget.dart';
import 'package:eamar_app/widgets/reportSubmittions/button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eamar_app/providers/auth_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late AuthProvider authProvider;

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      authProvider = Provider.of<AuthProvider>(context, listen: false);

      // Load user data and update controllers
      await authProvider.loadUserData();
      setState(() {
        usernameController.text = authProvider.currentUserName ?? '';
        emailController.text = authProvider.currentEmail ?? '';
        addressController.text = authProvider.address ?? '';
        phoneNumberController.text = authProvider.phoneNumber ?? '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: size.height * .09,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: size.width * .03),
                child: const CloseWidget(),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(right: size.width * .03),
                    child: Text(
                      'البيانات الشخصية',
                      style: TextStyle(
                          color: darkBlue, fontSize: 22, fontFamily: 'cairo'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: size.height * .07,
          ),
          Padding(
            padding: EdgeInsets.only(right: size.width * 0.090),
            child: const Align(
              alignment: Alignment.topRight,
              child: Text(
                'اسم المستخدم',
                style: TextStyle(
                  fontFamily: 'cairo',
                  fontSize: 15,
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * .015,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * .070),
            child: InputFieldWidget(
              isArabic: true,
              text: 'ثلاثة احرف عربية علي الاقل',
              controller: usernameController,
              isPassword: false,
              icon: const Icon(Icons.person),
            ),
          ),
          SizedBox(
            height: size.height * .05,
          ),
          Padding(
            padding: EdgeInsets.only(right: size.width * 0.090),
            child: const Align(
              alignment: Alignment.topRight,
              child: Text(
                'البريد الالكتروني',
                style: TextStyle(
                  fontFamily: 'cairo',
                  fontSize: 15,
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * .015,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * .070),
            child: InputFieldWidget(
                isEmail: true,
                controller: emailController,
                isPassword: false,
                icon: const Icon(Icons.email),
                text: 'johndoe@gmail.com'),
          ),
          SizedBox(
            height: size.height * .05,
          ),
          Padding(
            padding: EdgeInsets.only(right: size.width * 0.090),
            child: const Align(
              alignment: Alignment.topRight,
              child: Text(
                'العنوان',
                style: TextStyle(
                  fontFamily: 'cairo',
                  fontSize: 15,
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * .015,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * .070),
            child: InputFieldWidget(
              controller: addressController,
              isPassword: false,
              isArabic: true,
              icon: const Icon(CupertinoIcons.location_solid),
              text: 'بنغازي-ليبيا',
            ),
          ),
          SizedBox(
            height: size.height * .05,
          ),
          Padding(
            padding: EdgeInsets.only(right: size.width * 0.090),
            child: const Align(
              alignment: Alignment.topRight,
              child: Text(
                'رقم الهاتف',
                style: TextStyle(
                  fontFamily: 'cairo',
                  fontSize: 15,
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * .015,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * .070),
            child: InputFieldWidget(
              isNumber: true,
              isArabic: false,
              text: '09XXXXXXXX',
              controller: phoneNumberController,
              isPassword: false,
              icon: const Icon(CupertinoIcons.device_phone_portrait),
            ),
          ),
          SizedBox(
            height: size.height * .07,
          ),
          GestureDetector(
            onTap: () async {
              // Validate input
              if (usernameController.text.isEmpty ||
                  emailController.text.isEmpty ||
                  addressController.text.isEmpty ||
                  phoneNumberController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('يجب تعبئة جميع الحقول')),
                );
                return;
              }

              // Call update function
              final result = await authProvider.updateUserData(
                username: usernameController.text,
                email: emailController.text,
                address: addressController.text,
                phoneNumber: phoneNumberController.text,
                context: context,
              );

              // Show result and navigate back
              if (result[0] == true) {
                // Refetch the user data to update UI
                await authProvider.loadUserData();
                setState(() {
                  usernameController.text = authProvider.currentUserName ?? '';
                  emailController.text = authProvider.currentEmail ?? '';
                  addressController.text = authProvider.address ?? '';
                  phoneNumberController.text = authProvider.phoneNumber ?? '';
                });

                // Show success SnackBar
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('تم تحديث بياناتك بنجاح'),
                    duration:
                        Duration(seconds: 2), // Ensure this matches the delay
                  ),
                );

                // Delay navigation until SnackBar is dismissed
                Future.delayed(const Duration(seconds: 2), () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const TabsScreen()),
                    (route) => false,
                  );
                });
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(result[1])),
                );
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * .03),
              child: const ReportButton(
                text: 'تحديث',
              ),
            ),
          ),
          SizedBox(
            height: size.height * .05,
          ),
        ]),
      ),
    );
  }
}
