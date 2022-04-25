import 'package:artsen_van/bindings/course_binding.dart';
import 'package:artsen_van/controllers/global_controller.dart';
import 'package:artsen_van/screens/authentication/signup_screen.dart';
import 'package:artsen_van/screens/courses/enrolled_courses_screen.dart';
import 'package:artsen_van/utils/constants.dart';
import 'package:artsen_van/widgets/custom_button.dart';
import 'package:artsen_van/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: COLOR_DARK_BLUE,
      body: Container(
        height: Get.height,
        width: double.infinity,
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              'assets/images/splash_logo.png',
              width: Get.width * 0.7,
            ),
            SizedBox(
              height: Get.height * 0.1,
            ),
            Container(
              width: Get.width * 0.9,
              padding: EdgeInsets.symmetric(
                  vertical: Get.height * 0.04, horizontal: Get.width * 0.04),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0)),
              child: Column(
                children: [
                  Text(
                    'LOGIN',
                    style: themeData.textTheme.headline2,
                  ),
                  CustomTextField(
                    label: 'Email',
                    controller: globalController.emailController,
                    prefixIcon: Icon(Icons.email),
                    suffixText: '@artsenvanmorgen.nl',
                  ),
                  CustomTextField(
                    label: 'Password',
                    controller: globalController.passController,
                    prefixIcon: Icon(Icons.lock),
                    hasIcon: true,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Get.off(() => const SignUpScreen()),
                      child: Text(
                        "I'm a new user",
                        style: themeData.textTheme.bodyText2,
                      ),
                    ),
                  ),
                  CustomButton(
                      text: 'LOGIN',
                      width: Get.width * 0.6,
                      margin: Get.height * 0.02,
                      onPressed: () => globalController.login(
                          globalController.emailController.text,
                          globalController.passController.text)),
                  Divider(
                    height: 10,
                    indent: 50,
                    endIndent: 50,
                    thickness: 2,
                  ),
                  Text(
                    'Forgot Password',
                    style: themeData.textTheme.bodyText2,
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
