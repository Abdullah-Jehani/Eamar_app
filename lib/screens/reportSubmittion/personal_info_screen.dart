import 'package:eamar_app/helpers/colors.dart';
import 'package:eamar_app/providers/report_provider.dart';
import 'package:eamar_app/screens/reportSubmittion/report_decription_screen.dart';
import 'package:eamar_app/widgets/reportSubmittion/report_input_field.dart';
import 'package:eamar_app/widgets/reportSubmittions/button_widget.dart';
import 'package:eamar_app/widgets/reportSubmittions/custom_close_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController titlNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _resetControllers();
    _updateButtonState();

    userNameController.addListener(() {
      _updateButtonState();
    });
    titlNameController.addListener(() {
      _updateButtonState();
    });
    phoneNumberController.addListener(() {
      _updateButtonState();
    });
  }

  void _resetControllers() {
    userNameController.clear();
    titlNameController.clear();
    phoneNumberController.clear();
  }

  @override
  void dispose() {
    userNameController.dispose();
    titlNameController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = userNameController.text.isNotEmpty &&
          titlNameController.text.isNotEmpty &&
          _isValidPhoneNumber(phoneNumberController.text);
    });
  }

  bool _isValidPhoneNumber(String phoneNumber) {
    if (phoneNumber.length != 10) {
      return false;
    }
    final allowedPrefixes = ['091', '092', '094', '093'];
    return allowedPrefixes.any((prefix) => phoneNumber.startsWith(prefix));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<ReportProvider>(
      builder: (context, reportProvider, _) {
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
                  child: ReportInpufField(
                    isArabic: true,
                    text: ' ثلاثة احرف عربية علي الاقل',
                    controller: userNameController,
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
                  child: ReportInpufField(
                    controller: titlNameController,
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
                  child: ReportInpufField(
                    isNumber: true,
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
                GestureDetector(
                  onTap: () {
                    if (_isButtonEnabled) {
                      reportProvider.userName = userNameController.text;
                      reportProvider.title = titlNameController.text;
                      reportProvider.phoneNumber = phoneNumberController.text;
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const ReportDescription(),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(milliseconds: 1200),
                          showCloseIcon: true,
                          content: Text(
                            textAlign: TextAlign.right,
                            'من فضلك ادخل رقم هاتف صحيح',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'cairo',
                                fontSize: 16),
                          ),
                        ),
                      );
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * .04),
                    child: ReportButton(
                      text: 'التالي',
                      bgColor: _isButtonEnabled ? primaryColor : greyColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
