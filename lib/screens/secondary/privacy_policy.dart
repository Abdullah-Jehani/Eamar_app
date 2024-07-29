import 'package:eamar_app/helpers/colors.dart';
import 'package:eamar_app/screens/details/account_details.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/uil.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * .06,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * .05),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const AccountDetails(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                      transitionDuration: const Duration(milliseconds: 90),
                    ),
                    (route) => false,
                  );
                },
                child: Expanded(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10, top: 4),
                        child: Iconify(
                          Uil.arrow_left,
                          color: primaryColor,
                          size: 30,
                        ),
                      ),
                      Text(
                        'الرجوع',
                        style: TextStyle(
                          color: primaryColor,
                          fontFamily: 'cairo',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Image.asset(
              'assets/images/secondary/policyGuy.png',
              width: size.width * 1,
              height: size.height * .35,
            ),
            Text(
              'اتفاقية المستخدم وشروط الخدمة',
              style: TextStyle(
                  color: primaryColor,
                  fontFamily: 'cairo',
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * .05, vertical: size.height * .035),
              child: Column(
                children: [
                  const Text(
                    textAlign: TextAlign.right,
                    'يُطلب من مستخدمي التطبيق تقديم معلومات دقيقة وصادقة عند تقديم التقارير أو التعامل مع خدمات التطبيق. تقع على عاتق المستخدم مسؤولية التأكد من أن البيانات التي يقدمها، بما في ذلك المعلومات الشخصية والتفاصيل المتعلقة بالمشكلات المبلغ عنها، صحيحة وحديثة.',
                    style: TextStyle(
                        color: Colors.black, fontFamily: 'cairo', fontSize: 15),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: size.height * .035),
                    child: const Text(
                      'باستخدام التطبيق، يقر المستخدمون بأن دقة وسلامة المعلومات المبلغ عنها أمر بالغ الأهمية لحل فعال لتحديات المجتمع. يجب على المستخدمين بذل العناية في التحقق من المعلومات التي يقدمونها بأفضل ما لديهم من معرفة وقدرة.',
                      style: TextStyle(fontFamily: 'cairo', fontSize: 15),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: size.height * .035),
                    child: const Text(
                      'افهم أن تقديم معلومات غير دقيقة أو خاطئة قد يعيق عملية الحل ويعوق الجهود المبذولة لمعالجة المشكلات المبلغ عنها على الفور. يحتفظ التطبيق بالحق في اتخاذ الإجراء المناسب، بما في ذلك على سبيل المثال لا الحصر تقديم التقارير التي يتبين أنها مضللة أو غير دقيقة عن عمد.',
                      style: TextStyle(fontFamily: 'cairo', fontSize: 15),
                      textAlign: TextAlign.right,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
