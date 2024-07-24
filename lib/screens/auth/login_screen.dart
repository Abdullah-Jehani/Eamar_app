import 'package:eamar_app/helpers/colors.dart';
import 'package:eamar_app/providers/auth_provider.dart';
import 'package:eamar_app/screens/auth/register_screen.dart';
import 'package:eamar_app/screens/secondary/tabs_screen.dart';
import 'package:eamar_app/widgets/register/input_field_widget.dart';
import 'package:flutter/material.dart';
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
  bool isLogginIn = false;

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
    Size size = MediaQuery.of(context).size;
    return Consumer<AuthProvider>(builder: (context, auth, _) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * .005,
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(right: size.width * .090),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: size.height * .060,
                      ),
                      Text(
                        '! سجل الدخول الان',
                        style: TextStyle(
                            color: primaryColor,
                            fontFamily: 'cairo',
                            fontWeight: FontWeight.bold,
                            fontSize: 26),
                      ),
                      SizedBox(
                        height: size.height * .0090,
                      ),
                      Text(
                        'املأ بيانات حسابك',
                        style: TextStyle(
                            color: textColor,
                            fontFamily: 'cairo',
                            fontSize: 18,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * .050,
              ),
              Padding(
                padding: EdgeInsets.only(right: size.width * .090),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    'البريد الالكتروني',
                    style: TextStyle(
                        color: textColor, fontSize: 16, fontFamily: 'cairo'),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * .015,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: size.width * .070, right: size.width * .090),
                child: InputFieldWidget(
                    controller: emailController,
                    isPassword: false,
                    icon: const Icon(Icons.mail_rounded),
                    text: 'ادخل بريدك الالكتروني'),
              ),
              SizedBox(
                height: size.height * .040,
              ),
              Padding(
                padding: EdgeInsets.only(right: size.width * .090),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    'كلمة المرور',
                    style: TextStyle(
                        color: textColor, fontSize: 16, fontFamily: 'cairo'),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * .015,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: size.width * .070, right: size.width * .090),
                child: InputFieldWidget(
                    controller: passwordController,
                    isPassword: true,
                    icon: const Icon(Icons.mail_rounded),
                    text: 'ادخل كلمة المرور'),
              ),
              SizedBox(
                height: size.height * .025,
              ),
              Padding(
                  padding: EdgeInsets.only(
                      right: size.width * .050, left: size.width * .050),
                  child: isLogginIn
                      ? CircularProgressIndicator(
                          color: primaryColor,
                        )
                      : TextButton(
                          onPressed: () {
                            validator();
                            if (isValid == true) {
                              setState(() {
                                isLogginIn = true;
                              });
                              Provider.of<AuthProvider>(context, listen: false)
                                  .login({
                                "email": emailController.text.toString(),
                                "password": passwordController.text.toString()
                              }, context).then((value) {
                                if (value.first) {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          const TabsScreen(),
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
                                  SnackBar snackBar = SnackBar(
                                    content: Text(value.last),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              });
                            } else {
                              SnackBar snackBar = const SnackBar(
                                content: Text('Your input is invalid'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            height: size.height * .07,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              color: secondaryColor,
                            ),
                            child: Center(
                              child: Text(
                                'سجل الدخول',
                                style: TextStyle(
                                    color: primaryColor,
                                    fontFamily: 'cairo',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )),
              SizedBox(
                height: size.height * .010,
              ),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'أو',
                  style: TextStyle(
                    fontFamily: 'cairo',
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * .025,
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: size.width * .050, left: size.width * .050),
                child: Container(
                  width: size.width * .85,
                  height: size.height * .07,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                      border: Border.all(color: fillInputColor, width: 4)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/icons/Google_Icons-09-512 1.png'),
                      const Text(
                        'Continue with Google',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'poppins',
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * .010,
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: size.width * .050, left: size.width * .050),
                child: Container(
                  width: size.width * .85,
                  height: size.height * .07,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: faceBook,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: size.width * .040),
                        child: Image.asset(
                            'assets/icons/🦆 icon _facebook 1_.png'),
                      ),
                      const Text(
                        'Continue with Facebook',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'poppins',
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * .020,
              ),
              const Text(
                'لاتمتلك حساب ؟',
                style: TextStyle(
                    color: Colors.black, fontFamily: 'cairo', fontSize: 16),
              ),
              SizedBox(
                height: size.height * .020,
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: size.width * .050, left: size.width * .050),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const RegisterScreen(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        transitionDuration: const Duration(milliseconds: 90),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: size.height * .07,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: secondaryColor,
                    ),
                    child: Center(
                      child: Text(
                        'أنشئ حساب',
                        style: TextStyle(
                            color: primaryColor,
                            fontFamily: 'cairo',
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
