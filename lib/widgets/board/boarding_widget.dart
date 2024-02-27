import 'package:eamar_app/helpers/colors.dart';
import 'package:eamar_app/widgets/dots_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ep.dart';

// ignore: must_be_immutable
class BoardingWidget extends StatefulWidget {
  BoardingWidget(
      {super.key,
      required this.image,
      required this.heading,
      required this.subgeading,
      required this.colors,
      required this.widths,
      required this.onClickNext,
      required this.onClickSkip,
      this.textButton});

  final String image;
  final String heading;
  final String subgeading;
  List colors = [Color, Color, Color];
  List widths = [double, double, double];
  final Function onClickNext;
  final Function onClickSkip;
  String? textButton;

  @override
  State<BoardingWidget> createState() => _BoardingWidgetState();
}

class _BoardingWidgetState extends State<BoardingWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: size.height * .15,
          ),
          Image.asset(
            widget.image,
            height: size.height * .40,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * .025),
            child: Text(
              widget.heading,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: primaryColor,
                fontSize: 30,
                fontFamily: 'cairo',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            height: size.height * .03,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * .040),
            child: Text(
              widget.subgeading,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'cairo',
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          SizedBox(
            height: size.height * .05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DotsWidget(width: widget.widths[0], color: widget.colors[0]),
              SizedBox(
                width: size.width * 0.03,
              ),
              DotsWidget(width: widget.widths[1], color: widget.colors[1]),
              SizedBox(
                width: size.width * 0.03,
              ),
              DotsWidget(width: widget.widths[2], color: widget.colors[2]),
            ],
          ),
          SizedBox(
            height: size.height * .060,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  widget.onClickSkip();
                },
                child: const Text(
                  'تخطي',
                  style: TextStyle(
                      color: Colors.black, fontFamily: 'cairo', fontSize: 18),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    widget.onClickNext();
                  });
                },
                child: Container(
                  width: 110,
                  height: 40,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        widget.textButton ?? 'التالي',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'cairo'),
                      ),
                      const Iconify(
                        Ep.arrow_right,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
