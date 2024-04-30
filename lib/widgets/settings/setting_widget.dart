import 'package:eamar_app/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ooui.dart';

class SettingWidget extends StatefulWidget {
  const SettingWidget({super.key, required this.img, required this.hradline});
  final String img;
  final String hradline;

  @override
  State<SettingWidget> createState() => _SettingWidgetState();
}

class _SettingWidgetState extends State<SettingWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * .04),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Container(
            decoration: BoxDecoration(
              color: containerColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                widget.img,
              ),
            ),
          ),
          SizedBox(
            width: size.width * .02,
          ),
          Text(
            widget.hradline,
            style: TextStyle(
              color: darkBlue,
              fontSize: 14,
              fontFamily: 'cairo',
            ),
          ),
          const Expanded(
            child: Align(
                alignment: Alignment.centerLeft,
                child: Iconify(
                  Ooui.next_rtl,
                  size: 16,
                )),
          ),
        ],
      ),
    );
  }
}
