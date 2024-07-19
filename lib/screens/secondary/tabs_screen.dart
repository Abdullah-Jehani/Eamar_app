import 'package:eamar_app/helpers/colors.dart';
import 'package:eamar_app/screens/main/center_screen.dart';
import 'package:eamar_app/screens/main/home_screen.dart';
import 'package:eamar_app/screens/main/settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:unicons/unicons.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int currentIndex = 0;
  final tabs = const [
    HomeScreen(),
    CenterScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: GNav(
          backgroundColor: Colors.transparent,
          color: Colors.black,
          activeColor: primaryColor,
          onTabChange: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
          tabs: [
            GButton(
              icon: UniconsLine.home_alt,
              iconColor: textColor,
              iconSize: 30,
              iconActiveColor: primaryColor,
            ),
            GButton(
              icon: CupertinoIcons.news,
              iconColor: textColor,
              iconSize: 32,
              iconActiveColor: primaryColor,
            ),
            GButton(
              icon: Icons.settings_outlined,
              iconColor: textColor,
              iconSize: 30,
              iconActiveColor: primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
