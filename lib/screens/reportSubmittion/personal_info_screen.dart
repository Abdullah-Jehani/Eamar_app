import 'package:eamar_app/helpers/colors.dart';
import 'package:eamar_app/screens/profile/profile_screen.dart';
import 'package:eamar_app/widgets/register/input_field_widget.dart';
import 'package:eamar_app/widgets/reportSubmittions/button_widget.dart';
import 'package:eamar_app/widgets/reportSubmittions/custom_close_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

TextEditingController userNameController = TextEditingController();
TextEditingController titlNameController = TextEditingController();
TextEditingController phoneNumberController = TextEditingController();

class _PersonalInfoState extends State<PersonalInfo> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * .1,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * .04),
              child: const CustomClose(),
            ),
            SizedBox(
              height: size.height * .05,
            ),
            Text(
              'قم بادخال معلوماتك الشخصية',
              style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: 'cairo'),
            ),
            SizedBox(
              height: size.height * .1,
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
                icon: const Icon(LineIcons.user),
              ),
            ),
            SizedBox(
              height: size.height * .05,
            ),
            SizedBox(
              height: size.height * .015,
            ),
            Padding(
              padding: EdgeInsets.only(right: size.width * 0.090),
              child: const Align(
                alignment: Alignment.topRight,
                child: Text(
                  'اسم العائلة',
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
                icon: const Icon(LineIcons.user),
                text: 'ادخل اسمك العائلة',
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
                icon: const Icon(
                  Icons.phone_android_rounded,
                ),
              ),
            ),
            SizedBox(
              height: size.height * .1,
            ),
            const ReportButton(text: 'التالي')
          ],
        ),
      ),
    );
  }
}
