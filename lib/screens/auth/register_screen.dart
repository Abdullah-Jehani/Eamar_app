import 'package:eamar_app/helpers/colors.dart';
import 'package:eamar_app/providers/auth_provider.dart';
import 'package:eamar_app/screens/auth/login_screen.dart';
import 'package:eamar_app/screens/details/account_details.dart';
import 'package:eamar_app/widgets/register/input_field_widget.dart';
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
  final emailRegex =
      RegExp(r'^[\w+\-+=_]+(\.[\w+\-+=_]+)*@([\w\-+=_]+\.)+[a-zA-Z]{2,7}$');
  bool isValid = false;
  bool hidePass = true;
  bool isLogginIn = false;

  validator() async {
    if (userNameController.text.length > 2 &&
        emailController.text.isNotEmpty &&
        emailRegex.hasMatch(emailController.text) &&
        passwordController.text.length > 7 == true) {
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
            shadowColor: Colors.white,
            backgroundColor: Colors.white,
            actions: [
              GestureDetector(
                onTap: () {
                  validator();
                  if (isValid) {
                    setState(() {
                      isLogginIn = true;
                    });
                    Provider.of<AuthProvider>(context, listen: false).register({
                      "name": userNameController.text.toString(),
                      "email": emailController.text.toString(),
                      "password": passwordController.text.toString()
                    }, context).then((value) {
                      if (value.first) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const AccountDetails(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                            transitionDuration:
                                const Duration(milliseconds: 90),
                          ),
                          (route) => false,
                        );
                      } else {
                        setState(() {
                          isLogginIn = false;
                        });
                        SnackBar snackBar = SnackBar(content: Text(value.last));
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
                      color: isValid && !isLogginIn ? primaryColor : greyColor,
                      fontFamily: 'cairo',
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, top: 4),
                child: Iconify(
                  Uil.arrow_right,
                  color: isValid && !isLogginIn ? primaryColor : greyColor,
                  size: 30,
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: size.height * .03,
                ),
                Padding(
                  padding: EdgeInsets.only(right: size.width * 0.090),
                  child: Text(
                    ' أنشئ حساب',
                    style: TextStyle(
                      color: primaryColor,
                      fontFamily: 'cairo',
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
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
                        color: textColor,
                        fontSize: 16,
                        fontFamily: 'cairo',
                        fontWeight: FontWeight.normal),
                    textAlign: TextAlign.right,
                  ),
                ),
                SizedBox(
                  height: size.height * .05,
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
                              controller: userNameController,
                              isPassword: false,
                              icon: const Icon(Icons.person))),
                      SizedBox(
                        height: size.height * .05,
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
                              isPassword: false,
                              icon: const Icon(Icons.email),
                              text: 'johndoe@gmail.com')),
                      SizedBox(
                        height: size.height * .05,
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
                              isPassword: true,
                              icon: const Icon(Icons.visibility),
                              text: 'ثماني خانات علي الاقل')),
                      SizedBox(
                        height: size.height * .040,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: size.width * 0.090),
                        child: const Align(
                          alignment: Alignment.topRight,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * .010,
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
                            fontWeight: FontWeight.normal),
                      ),
                      SizedBox(
                        height: size.height * .03,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        const LoginScreen(),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                                transitionDuration:
                                    const Duration(milliseconds: 90),
                              ),
                            );
                          },
                          child: Container(
                            width: size.width * .87,
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
          ));
    });
  }
}
