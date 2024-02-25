import 'package:eamar_app/helpers/colors.dart';
import 'package:flutter/cupertino.dart';
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
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: size.height * .070),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * .030),
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
          )
        ],
      ),
    );
  }
}
