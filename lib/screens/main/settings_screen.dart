import 'package:eamar_app/helpers/colors.dart';
import 'package:eamar_app/widgets/settings/setting_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ooui.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          textDirection: TextDirection.rtl,
          children: [
            SizedBox(
              height: size.height * .09,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * .04),
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.asset(
                      'assets/images/home/profilePicture.jpg',
                      width: 64,
                      height: 64,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: size.width * .03,
                  ),
                  Column(
                    textDirection: TextDirection.rtl,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        textDirection: TextDirection.rtl,
                        'عبدالله الجهاني',
                        style: TextStyle(
                            color: darkBlue,
                            fontSize: 14,
                            fontFamily: 'cairo',
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: size.height * .009,
                      ),
                      Text(
                        '094 0000 615',
                        style: TextStyle(
                            color: textColor2,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'poppins',
                            fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * .03,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * .04),
              child: Divider(
                color: lineColor,
                thickness: 2,
              ),
            ),
            SizedBox(
              height: size.height * .03,
            ),
            const SettingWidget(
              img: 'assets/images/home/profileIcon.png',
              hradline: 'البيانات الشخصية',
            ),
            SizedBox(
              height: size.height * .03,
            ),
            const SettingWidget(
              img: 'assets/images/home/notificationIcon.png',
              hradline: 'الاشعارات',
            ),
            SizedBox(
              height: size.height * .03,
            ),
            const SettingWidget(
              img: 'assets/images/home/securityIcon.png',
              hradline: 'الامان',
            ),
            SizedBox(
              height: size.height * .03,
            ),
            const SettingWidget(
              img: 'assets/images/home/AppSettings.png',
              hradline: 'اعدادات التطبيق',
            ),
            SizedBox(
              height: size.height * .03,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * .04),
              child: Divider(
                color: lineColor,
                thickness: 2,
              ),
            ),
            SizedBox(
              height: size.height * .03,
            ),
            const SettingWidget(
              img: 'assets/images/home/languageIcon.png',
              hradline: 'لغةالتطبيق',
            ),
            SizedBox(
              height: size.height * .03,
            ),
            const SettingWidget(
              img: 'assets/images/home/helpCenter.png',
              hradline: 'مركز المساعدة',
            ),
            SizedBox(
              height: size.height * .03,
            ),
            const SettingWidget(
              img: 'assets/images/home/rateApp.png',
              hradline: 'قيم التطبيق',
            ),
            SizedBox(
              height: size.height * .03,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * .04),
              child: Divider(
                color: lineColor,
                thickness: 2,
              ),
            ),
            SizedBox(
              height: size.height * .03,
            ),
            const SettingWidget(
              img: 'assets/images/home/DarkTheme.png',
              hradline: 'الوضع الليلي',
            ),
            SizedBox(
              height: size.height * .03,
            ),
            const SettingWidget(
              img: 'assets/images/home/signout.png',
              hradline: 'تسجيل الخروج',
            ),
            SizedBox(
              height: size.height * .03,
            ),
          ],
        ),
      ),
    );
  }
}
