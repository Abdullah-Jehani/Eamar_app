import 'package:eamar_app/helpers/colors.dart';
import 'package:eamar_app/widgets/home/button_widget.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  const CardWidget(
      {super.key,
      required this.head,
      required this.tail,
      required this.textButton,
      required this.img,
      required this.route});

  @override
  State<CardWidget> createState() => _CardWidgetState();
  final String head;
  final String tail;
  final String textButton;
  final String img;
  final Widget route;
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          height: size.height * .2,
          width: size.width * .94,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: secondaryColor,
            border: Border.all(color: textColor, width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textDirection: TextDirection.rtl,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    right: size.width * .05, top: size.height * .03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      widget.head,
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'cairo',
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(
                      height: size.height * .015,
                    ),
                    Text(
                      widget.tail,
                      style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'cairo',
                          fontSize: 13),
                    ),
                    SizedBox(
                      height: size.height * .025,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: size.width * .03),
                      child: ButtonWidget(
                        text: widget.textButton,
                        route: widget.route,
                      ),
                    )
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    width: size.width * .23,
                    height: size.height * .19,
                    widget.img,
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
