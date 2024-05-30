import 'package:eamar_app/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/ooui.dart';

// ignore: must_be_immutable
class LocationCard extends StatefulWidget {
  const LocationCard({super.key, required this.location});
  final String? location;

  @override
  State<LocationCard> createState() => _LocationCardState();
}

class _LocationCardState extends State<LocationCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * .95,
      height: size.height * .14,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: secondaryColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * .04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: size.height * .02,
                ),
                const Text(
                  'عنوان البلاغ',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'cairo'),
                ),
                SizedBox(
                  height: size.height * .02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Iconify(
                      Ooui.next_rtl,
                      size: 18,
                    ),
                    Row(
                      children: [
                        Text(
                          widget.location ?? 'ادخل موقع البلاغ من هنا',
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'cairo',
                            fontSize: 14,
                          ),
                        ),
                        Iconify(
                          Mdi.location,
                          color: primaryColor,
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
