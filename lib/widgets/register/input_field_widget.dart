import 'package:eamar_app/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputFieldWidget extends StatefulWidget {
  const InputFieldWidget({
    Key? key,
    required this.controller,
    required this.isPassword,
    required this.icon,
    required this.text,
    this.isArabic = false,
    this.isNumber = false,
    this.isEmail = false,
  }) : super(key: key);

  final TextEditingController controller;
  final bool isPassword;
  final Icon icon;
  final String text;
  final bool isArabic;
  final bool isNumber;
  final bool isEmail;

  @override
  State<InputFieldWidget> createState() => _InputFieldWidgetState();
}

class _InputFieldWidgetState extends State<InputFieldWidget> {
  RegExp arabicPattern = RegExp(r'^[\u0600-\u06FF\s\-/]+$');
  RegExp englishNumbersSpecialCharsPattern =
      RegExp(r'^[a-zA-Z0-9\s!@#$%^&*(),.?":{}|<>+=\-*/]+$');

  bool hidePass = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: [
        widget.isArabic
            ? FilteringTextInputFormatter.allow(arabicPattern)
            : widget.isEmail
                ? FilteringTextInputFormatter.deny(RegExp(r'\s'))
                : FilteringTextInputFormatter.allow(
                    englishNumbersSpecialCharsPattern),
      ],
      keyboardType: widget.isNumber
          ? TextInputType.number
          : widget.isEmail
              ? TextInputType.emailAddress
              : TextInputType.text,
      textDirection: TextDirection.rtl,
      obscureText: widget.isPassword ? hidePass : !hidePass,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.controller,
      style: TextStyle(
        color: Colors.black.withOpacity(.9),
        fontFamily: 'cairo',
        fontSize: 14,
      ),
      cursorColor: primaryColor,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF8F8F8),
        hintText: widget.text,
        hintStyle: TextStyle(
          color: textColor,
          fontFamily: 'cairo',
          fontSize: 14,
        ),
        prefixIcon: widget.isPassword
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    hidePass = !hidePass;
                  });
                },
                child: Icon(hidePass ? Icons.visibility_off : Icons.visibility),
              )
            : Icon(
                widget.icon.icon,
              ),
        errorMaxLines: 1,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: greyColor),
          borderRadius: BorderRadius.circular(12),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    );
  }
}
