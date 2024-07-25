import 'package:eamar_app/helpers/colors.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  const ButtonWidget({super.key, required this.text, this.route});

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
  final String text;
  final Widget? route;
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                widget.route!,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 01),
          ),
        );
      },
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(horizontal: 14),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      child: SizedBox(
        height: size.height * 0.034,
        child: Center(
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'cairo',
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
