import 'package:eamar_app/helpers/colors.dart';
import 'package:eamar_app/screens/main/center_screen.dart';
import 'package:eamar_app/screens/main/settings_screen.dart';
import 'package:eamar_app/widgets/home/card_widget.dart';
import 'package:eamar_app/widgets/home/headline_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * .030),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(top: size.height * .070),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Iconify(MaterialSymbols.notifications_outline_rounded,
                        color: textColor, size: 32),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: size.height * .005),
                          child: const Text(
                            ',صباح الخير',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'cairo',
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Text(
                          'عبدالله',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: primaryColor,
                            fontFamily: 'cairo',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.height * .035,
              ),
              const HeadlineWidget(text: 'الخدمات'),
              SizedBox(
                height: size.height * .008,
              ),
              const CardWidget(
                route: CenterScreen(),
                head: 'قم بالتبليغ عن مظاهر التشوه البصري',
                tail: 'ساهم في تحسين المشهد الحضاري للمدينه',
                textButton: 'ارفع بلاغ',
                img: 'assets/images/home/guywithphone.png',
              ),
              SizedBox(
                height: size.height * .035,
              ),
              const HeadlineWidget(text: 'الحساب'),
              SizedBox(
                height: size.height * .008,
              ),
              const CardWidget(
                route: SettingsScreen(),
                head: 'التحكم بمعلوماتك الشخصية ',
                tail: 'بإمكانك تعديل معلومات الاتصال بحرية',
                textButton: 'تعديل الحساب',
                img: 'assets/images/home/editaccount.png',
              ),
              SizedBox(
                height: size.height * .035,
              ),
              const HeadlineWidget(text: 'متابعة البلاغات'),
              SizedBox(
                height: size.height * .008,
              ),
              const CardWidget(
                route: CenterScreen(),
                head: ' بامكان المستخدم متابعة الشكاوى التي ',
                tail: 'قدمها ومعرفة آخر التحديثات  ',
                textButton: 'تتبع البلاغات',
                img: 'assets/images/home/trackreports.png',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
