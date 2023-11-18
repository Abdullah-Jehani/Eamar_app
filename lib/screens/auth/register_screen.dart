import 'package:eamar_app/helpers/colors.dart';
import 'package:eamar_app/providers/auth_provider.dart';
import 'package:eamar_app/screens/auth/login_screen.dart';
import 'package:eamar_app/widgets/register/input_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/uil.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final emailRegex =
      RegExp(r'^[\w+\-+=_]+(\.[\w+\-+=_]+)*@([\w\-+=_]+\.)+[a-zA-Z]{2,7}$');
  bool isValid = false;
  bool hidePass = true;

  validator() async {
    if (userNameController.text.length > 2 &&
        emailController.text.isNotEmpty &&
        emailRegex.hasMatch(emailController.text) &&
        passwordController.text.length > 7 &&
        confirmPasswordController.text == passwordController.text) {
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
    Size size = MediaQuery.of(context).size;

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
                      Provider.of<AuthProvider>(context, listen: false)
                          .register({
                        "name": userNameController.text.toString(),
                        "email": emailController.text.toString(),
                        "password": passwordController.text.toString()
                      }, context).then((value) {
                        if (value.first) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => const LoginScreen()),
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
          body: SingleChildScrollView(
            child: Align(
              alignment: Alignment.topRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: size.height * .005,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: size.width * 0.090),
                    child: Text(
                      ' أنشئ حساب',
                      style: TextStyle(
                        color: primaryColor,
                        fontFamily: 'cairo',
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  SizedBox(
                    height: size.height * .015,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: size.width * .090),
                    child: Text(
                      'قم بادخل بياناتك الشخصية',
                      style: TextStyle(
                          color: textColor, fontSize: 16, fontFamily: 'cairo'),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  SizedBox(
                    height: size.height * .040,
                  ),
                  Form(
                    onChanged: () {
                      validator();
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: size.width * 0.090),
                          child: const Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              'اسم المستخدم',
                              style: TextStyle(
                                fontFamily: 'cairo',
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * .015,
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * .070),
                            child: InputFieldWidget(
                                isArabic: true,
                                text: ' ثلاثة احرف عربية علي الاقل',
                                // validator: (value) {

                                //   if (value!.isEmpty) {
                                //     return 'من فضلك ادخل اسم مستخدم';
                                //   }
                                //   if (value.length < 3) {
                                //     return 'please enter real name';
                                //   }
                                //   return '';
                                // },
                                controller: userNameController,
                                isPassword: false,
                                icon: const Icon(Icons.person))),
                        SizedBox(
                          height: size.height * .025,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: size.width * 0.090),
                          child: const Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              'البريد الالكتروني',
                              style: TextStyle(
                                fontFamily: 'cairo',
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * .015,
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * .070),
                            child: InputFieldWidget(
                                controller: emailController,
                                // validator: (value) {
                                //   if (value!.isEmpty) {
                                //     return 'please enter an email';
                                //   }
                                //   if (value.length < 9) {
                                //     return 'please enter a valid email';
                                //   }
                                //   if (value.contains('@') == false) {
                                //     return 'please enter a valid email';
                                //   }
                                //   if (value.contains('.') == false) {
                                //     return 'please enter a valid email';
                                //   }
                                //   return '';
                                // },
                                isPassword: false,
                                icon: const Icon(Icons.email),
                                text: 'johndoe@gmail.com')),
                        SizedBox(
                          height: size.height * .025,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: size.width * 0.090),
                          child: const Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              'كلمة المرور',
                              style: TextStyle(
                                fontFamily: 'cairo',
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * .015,
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * .070),
                            child: InputFieldWidget(
                                controller: passwordController,
                                // validator: (value) {
                                //   if (value!.isEmpty) {
                                //     return 'please enter a password';
                                //   }
                                //   if (value.length < 8) {
                                //     return 'password must be 9 characters long';
                                //   }
                                //   return '';
                                // },
                                isPassword: true,
                                icon: const Icon(Icons.visibility),
                                text: 'ثماني خانات علي الاقل')),
                        SizedBox(
                          height: size.height * .025,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: size.width * 0.090),
                          child: const Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              'اعد ادخال كلمة المرور',
                              style: TextStyle(
                                fontFamily: 'cairo',
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * .015,
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * .070),
                            child: InputFieldWidget(
                                controller: confirmPasswordController,
                                // validator: (value) {
                                //   if (value!.isEmpty) {
                                //     return 'please enter a password';
                                //   }
                                //   if (value.length < 9) {
                                //     return 'please enter the same password';
                                //   }
                                //   return '';
                                // },
                                isPassword: true,
                                icon: const Icon(Icons.visibility),
                                text: 'اعد ادخال كلمة المرور')),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * .040,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        const Text(
                          'لديك حساب بالفعل ؟',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'cairo',
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: size.height * .009,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()),
                                  (route) => false);
                            },
                            child: Container(
                              width: size.width * .80,
                              height: size.height * .07,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                color: secondaryColor,
                              ),
                              child: Center(
                                child: Text(
                                  'تسجيل دخول',
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontFamily: 'cairo',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ));
    });
  }
}
