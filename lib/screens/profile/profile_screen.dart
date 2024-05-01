import 'package:eamar_app/helpers/colors.dart';
import 'package:eamar_app/widgets/helper/close_widget.dart';
import 'package:eamar_app/widgets/register/input_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

TextEditingController usernameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController addressController = TextEditingController();
TextEditingController phoneNumberController = TextEditingController();

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(children: [
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
          text: ' ثلاثة احرف عربية علي الاقل',
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
          isArabic: false,
          text: '09XXXXXXXX',
          controller: phoneNumberController,
          isPassword: false,
          icon: const Icon(CupertinoIcons.device_phone_portrait),
        ),
      ),
    ]));
  }
}
