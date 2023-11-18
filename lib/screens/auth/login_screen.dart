import 'package:eamar_app/helpers/colors.dart';
import 'package:eamar_app/providers/auth_provider.dart';
import 'package:eamar_app/screens/auth/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/uil.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final emailRegex =
      RegExp(r'^[\w+\-+=_]+(\.[\w+\-+=_]+)*@([\w\-+=_]+\.)+[a-zA-Z]{2,7}$');
  bool isValid = false;
  bool hidePass = true;
  validator() async {
    if (emailController.text.isNotEmpty &&
        emailRegex.hasMatch(emailController.text) &&
        passwordController.text.length > 7) {
      setState(() {
        isValid = true;
      });
    } else {
      setState(() {
        isValid = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, auth, _) {
      return Scaffold(
          appBar: AppBar(
              elevation: 0,
              shadowColor: Colors.white,
              backgroundColor: Colors.white,
              actions: [
                GestureDetector(
                  onTap: () {
                    validator();
                    if (isValid) {
                      Provider.of<AuthProvider>(context, listen: false).login({
                        "email": emailController.text.toString(),
                        "password": passwordController.text.toString()
                      }, context).then((value) {
                        if (value.first) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => const RegisterScreen()),
                            (route) => false,
                          );
                        } else {
                          SnackBar snackBar =
                              SnackBar(content: Text(value.last));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      });
                    } else {
                      SnackBar snackBar = const SnackBar(
                        content: Text('Your input is invalid'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: Text(
                    'التالي ',
                    style: TextStyle(
                        color: isValid ? primaryColor : greyColor,
                        fontFamily: 'cairo',
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10, top: 4),
                  child: Iconify(
                    Uil.arrow_right,
                    color: isValid ? primaryColor : greyColor,
                    size: 30,
                  ),
                )
              ]),
          body: const Column(
            children: [],
          ));
    });
  }
}
