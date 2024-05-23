import 'package:eamar_app/widgets/helper/close_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ooui.dart';

class CustomClose extends StatefulWidget {
  const CustomClose({super.key});

  @override
  State<CustomClose> createState() => _CustomCloseState();
}

class _CustomCloseState extends State<CustomClose> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(left: size.width * .03),
          child: const CloseWidget(),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Text(
                'السابق',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'cairo',
                    fontSize: 16),
              ),
            ),
            const Iconify(
              Ooui.next_ltr,
              color: Colors.black,
              size: 18,
            ),
          ],
        )
      ],
    );
  }
}
