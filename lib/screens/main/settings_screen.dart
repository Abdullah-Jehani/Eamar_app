import 'package:eamar_app/helpers/colors.dart';
import 'package:eamar_app/providers/auth_provider.dart';
import 'package:eamar_app/screens/auth/login_screen.dart';
import 'package:eamar_app/screens/profile/profile_screen.dart';
import 'package:eamar_app/screens/secondary/next_version_screen.dart';
import 'package:eamar_app/widgets/settings/setting_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<AuthProvider>(
      builder: (context, auth, _) {
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
                        child: Image.network(
                          'http://192.168.1.7:8080/storage/${auth.profilePhoto}',
                          width: 64,
                          height: 64,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/home/profilePicture.jpg',
                              width: 64,
                              height: 64,
                              fit: BoxFit.cover,
                            );
                          },
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
                            auth.currentUserName!,
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
                            auth.phoneNumber!,
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
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const ProfileScreen(),
                      ),
                    );
                  },
                  child: const SettingWidget(
                    img: 'assets/images/home/profileIcon.png',
                    hradline: 'البيانات الشخصية',
                  ),
                ),
                SizedBox(
                  height: size.height * .03,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const NextVersionScreen(),
                      ),
                    );
                  },
                  child: const SettingWidget(
                    img: 'assets/images/home/notificationIcon.png',
                    hradline: 'الاشعارات',
                  ),
                ),
                SizedBox(
                  height: size.height * .03,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const NextVersionScreen(),
                      ),
                    );
                  },
                  child: const SettingWidget(
                    img: 'assets/images/home/securityIcon.png',
                    hradline: 'الامان',
                  ),
                ),
                SizedBox(
                  height: size.height * .03,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const NextVersionScreen(),
                      ),
                    );
                  },
                  child: const SettingWidget(
                    img: 'assets/images/home/AppSettings.png',
                    hradline: 'اعدادات التطبيق',
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
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const NextVersionScreen(),
                      ),
                    );
                  },
                  child: const SettingWidget(
                    img: 'assets/images/home/languageIcon.png',
                    hradline: 'لغة التطبيق',
                  ),
                ),
                SizedBox(
                  height: size.height * .03,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const NextVersionScreen(),
                      ),
                    );
                  },
                  child: const SettingWidget(
                    img: 'assets/images/home/helpCenter.png',
                    hradline: 'مركز المساعدة',
                  ),
                ),
                SizedBox(
                  height: size.height * .03,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const NextVersionScreen(),
                      ),
                    );
                  },
                  child: const SettingWidget(
                    img: 'assets/images/home/rateApp.png',
                    hradline: 'قيم التطبيق',
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
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const NextVersionScreen(),
                      ),
                    );
                    // Handle Dark Theme toggle
                  },
                  child: const SettingWidget(
                    img: 'assets/images/home/DarkTheme.png',
                    hradline: 'الوضع الليلي',
                  ),
                ),
                SizedBox(
                  height: size.height * .03,
                ),
                GestureDetector(
                  onTap: () {
                    Provider.of<AuthProvider>(context, listen: false).logout();
                    Navigator.pushAndRemoveUntil(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const LoginScreen()),
                        (route) => false);
                  },
                  child: const SettingWidget(
                    img: 'assets/images/home/signout.png',
                    hradline: 'تسجيل الخروج',
                  ),
                ),
                SizedBox(
                  height: size.height * .03,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
