import 'dart:io';

import 'package:eamar_app/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/uil.dart';
import 'package:image_picker/image_picker.dart';

class AccountPhoto extends StatefulWidget {
  const AccountPhoto({super.key});

  @override
  State<AccountPhoto> createState() => _AccountPhotoState();
}

class _AccountPhotoState extends State<AccountPhoto> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  void removePhoto() {
    setState(() {
      _image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: _image != null
            ? Row(
                children: [
                  GestureDetector(
                    onTap: removePhoto,
                    child: Text(
                      'ازالة ',
                      style: TextStyle(
                        color: danger,
                        fontFamily: 'cairo',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              )
            : const Row(),
        actions: [
          Text(
            _image != null ? 'التالي' : 'تخطي في الوقت الراهن ',
            style: TextStyle(
                color: primaryColor,
                fontFamily: 'cairo',
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10, top: 4),
            child: Iconify(
              Uil.arrow_right,
              color: primaryColor,
              size: 30,
            ),
          ),
        ],
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(
              height: size.height * .08,
            ),
            Text(
              'اختر صورة',
              style: TextStyle(
                  color: primaryColor,
                  fontFamily: 'cairo',
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * .060,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * .04),
              child: Text(
                textAlign: TextAlign.center,
                'سيتم استخدام الصورة التي تختارها كصورة ملف شخصي لحسابك',
                style: TextStyle(
                  color: textColor,
                  fontFamily: 'cairo',
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(
              height: size.height * .02,
            ),
            GestureDetector(
              onTap: () async {
                final XFile? image =
                    await _picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  setState(() {
                    _image = File(image.path);
                  });
                }
              },
              child: Container(
                width: size.width * .55,
                height: size.height * .4,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black38, width: 2),
                ),
                child: CircleAvatar(
                  radius: 120,
                  backgroundColor: Colors.white,
                  backgroundImage: _image != null ? FileImage(_image!) : null,
                  child: _image == null
                      ? SvgPicture.asset('assets/icons/octicon_person-24.svg')
                      : null,
                ),
              ),
            ),
            SizedBox(
              height: size.height * .05,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * .07),
              child: Text(
                textAlign: TextAlign.center,
                'يمكنك تخطي تحميل الصور في الوقت الحالي سيكون لديك خيار اختيار صورة لاحقًا في قسم إعدادات الحساب',
                style: TextStyle(
                    color: textColor, fontFamily: 'cairo', fontSize: 14),
              ),
            )
          ],
        ),
      ),
    );
  }
}
