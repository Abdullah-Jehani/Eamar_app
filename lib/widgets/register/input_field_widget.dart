import 'package:eamar_app/helpers/colors.dart';
import 'package:flutter/material.dart';

class InputFieldWidget extends StatefulWidget {
  const InputFieldWidget(
      {super.key,
      required this.controller,
      required this.isPassword,
      required this.icon,
      required this.text});

  final TextEditingController controller;
  final bool isPassword;
  final Icon icon;
  final String text;

  @override
  State<InputFieldWidget> createState() => _InputFieldWidgetState();
}

class _InputFieldWidgetState extends State<InputFieldWidget> {
  bool hidePass = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textDirection: TextDirection.rtl,
      obscureText: widget.isPassword ? hidePass : !hidePass,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.controller,
      style: TextStyle(color: textColor, fontFamily: 'cairo', fontSize: 15),
      cursorColor: primaryColor,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillInputColor,
        hintText: widget.text,
        hintStyle: TextStyle(
          color: textColor,
          fontFamily: 'cairo',
          fontSize: 15,
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
            : Icon(widget.icon.icon),
        errorMaxLines: 1,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: greyColor),
            borderRadius: BorderRadius.circular(12)),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    );
  }
}
