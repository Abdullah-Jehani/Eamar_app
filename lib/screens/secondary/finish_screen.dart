import 'dart:async';

import 'package:confetti/confetti.dart';
import 'package:eamar_app/helpers/colors.dart';
import 'package:eamar_app/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

class FinishScreen extends StatefulWidget {
  const FinishScreen({Key? key}) : super(key: key);

  @override
  _FinishScreenState createState() => _FinishScreenState();
}

class _FinishScreenState extends State<FinishScreen> {
  bool isPlaying = false;
  final controller = ConfettiController();

  @override
  void initState() {
    super.initState();
    // Start the confetti animation
    Timer(const Duration(milliseconds: 500), () {
      startConfetti();
    });
  }

  @override
  void dispose() {
    // Dispose the confetti controller
    controller.dispose();
    isPlaying = false;
    super.dispose();
  }

  void startConfetti() {
    setState(() {
      isPlaying = true;
    });

    controller.play();
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Align(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.45,
              ),
              ConfettiWidget(
                confettiController: controller,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: true,
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                  Colors.purple,
                ],
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          '! تهانينا ',
                          style: TextStyle(
                            color: primaryColor,
                            fontFamily: 'cairo',
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.009,
                        ),
                        Text(
                          '.لقد أكملت بنجاح عملية التسجيل',
                          style: TextStyle(
                            color: textColor,
                            fontFamily: 'cairo',
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: size.height * 0.35,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const HomeScreen(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                          transitionDuration: const Duration(milliseconds: 90),
                        ),
                        (route) => false,
                      );
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 12,
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(primaryColor),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                    child: GestureDetector(
                      child: const Text(
                        'انهاء',
                        style: TextStyle(
                          fontFamily: 'cairo',
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
