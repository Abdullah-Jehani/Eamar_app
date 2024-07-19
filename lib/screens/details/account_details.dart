import 'package:eamar_app/helpers/colors.dart';
import 'package:eamar_app/providers/auth_provider.dart';
import 'package:eamar_app/screens/details/account_photo.dart';
import 'package:eamar_app/screens/secondary/privacy_policy.dart';
import 'package:eamar_app/widgets/register/input_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/uil.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class AccountDetails extends StatefulWidget {
  const AccountDetails({super.key});

  @override
  State<AccountDetails> createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  bool isChecked = true;
  DateTime dateTime = DateTime(2000, 2, 1);
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  final phoneregex = RegExp(r'^(091|092|093|094)\d{7}$');
  final dateRegex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
  bool isValid = false;
  bool isLogginIn = false;

  validator() async {
    if (isChecked &&
        phoneregex.hasMatch(phoneNumberController.text) &&
        addressController.text.length > 3 &&
        dateRegex.hasMatch(dateController.text)) {
      setState(() {
        isValid = true;
      });
    } else {
      setState(() {
        isValid = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<AuthProvider>(
      builder: (context, auth, _) {
        return Scaffold(
          appBar: AppBar(
            shadowColor: Colors.white,
            backgroundColor: Colors.white,
            actions: [
              GestureDetector(
                onTap: () {
                  validator();
                  if (isValid) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AccountPhoto(
                          phoneNumber: phoneNumberController.text.toString(),
                          address: addressController.text.toString(),
                          dob: dateController.text.toString(),
                        ),
                      ),
                    );
                  } else {
                    SnackBar snackBar = const SnackBar(
                      content: Text('Your input is invalid'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: Text(
                  'التالي ',
                  style: TextStyle(
                      color: isValid && isChecked && !isLogginIn
                          ? primaryColor
                          : greyColor,
                      fontFamily: 'cairo',
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, top: 4),
                child: Iconify(
                  Uil.arrow_right,
                  color: isValid && !isLogginIn && isChecked
                      ? primaryColor
                      : greyColor,
                  size: 30,
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: size.height * .03,
                ),
                Padding(
                  padding: EdgeInsets.only(right: size.width * 0.090),
                  child: Text(
                    'اقتربت من النهاية',
                    style: TextStyle(
                      color: primaryColor,
                      fontFamily: 'cairo',
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                SizedBox(
                  height: size.height * .025,
                ),
                Padding(
                  padding: EdgeInsets.only(right: size.width * .090),
                  child: Text(
                    'نريد معلومات اكثر لكي نقوم بانشاء الحساب',
                    style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontFamily: 'cairo',
                        fontWeight: FontWeight.normal),
                    textAlign: TextAlign.right,
                  ),
                ),
                SizedBox(
                  height: size.height * .06,
                ),
                Form(
                  onChanged: () {
                    validator();
                  },
                  child: Column(
                    children: [
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
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * .070),
                        child: InputFieldWidget(
                          isArabic: false,
                          text: '09XXXXXXXX',
                          controller: phoneNumberController,
                          isPassword: false,
                          icon:
                              const Icon(CupertinoIcons.device_phone_portrait),
                        ),
                      ),
                      SizedBox(
                        height: size.height * .06,
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
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * .070),
                        child: InputFieldWidget(
                          controller: addressController,
                          isPassword: false,
                          isArabic: true,
                          icon: const Icon(CupertinoIcons.location_solid),
                          text: 'بنغازي-ليبيا',
                        ),
                      ),
                      SizedBox(
                        height: size.height * .06,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: size.width * 0.090),
                        child: const Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            'تاريخ الميلاد',
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
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * .070),
                        child: InputFieldWidget(
                          controller: dateController,
                          isPassword: false,
                          isArabic: false,
                          icon: const Icon(LineIcons.birthdayCake),
                          text: '2002-12-3',
                        ),
                      ),
                      SizedBox(
                        height: size.height * .05,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsets.only(right: size.width * .090),
                                child: RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'cairo',
                                      fontSize: 14,
                                    ),
                                    children: [
                                      const TextSpan(
                                        text:
                                            'قد قرأت ووافقت على سياسة الخصوصية وشروط الخدمة  ',
                                      ),
                                      WidgetSpan(
                                        alignment: PlaceholderAlignment.middle,
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                CupertinoPageRoute(
                                                    builder: (context) =>
                                                        const PrivacyPolicy()),
                                                (route) => false);
                                          },
                                          child: Text(
                                            'سياسة الخصوصية',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor,
                                              fontSize: 15,
                                              fontFamily: 'cairo',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: size.width * .070),
                              child: Checkbox(
                                activeColor: primaryColor,
                                checkColor: Colors.white,
                                side: BorderSide(color: textColor),
                                value: isChecked,
                                onChanged: (newValue) {
                                  setState(() {
                                    isChecked = !isChecked;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
