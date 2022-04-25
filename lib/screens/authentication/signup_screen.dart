import 'package:artsen_van/controllers/global_controller.dart';
import 'package:artsen_van/screens/authentication/login_screen.dart';
import 'package:artsen_van/utils/constants.dart';
import 'package:artsen_van/widgets/custom_button.dart';
import 'package:artsen_van/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
              height: Get.height * 0.05,
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
                    'SIGN UP',
                    style: themeData.textTheme.headline2,
                  ),
                  CustomTextField(
                    label: 'Full Name',
                    controller: globalController.fullNameController,
                    prefixIcon: Icon(Icons.badge),
                  ),
                  CustomTextField(
                    label: 'E-mail',
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
                      onPressed: () => Get.off(() => const LoginScreen()),
                      child: Text(
                        "I'm already a member",
                        style: themeData.textTheme.bodyText2,
                      ),
                    ),
                  ),
                  CustomButton(
                    text: 'SIGN UP',
                    width: Get.width * 0.6,
                    margin: Get.height * 0.02,
                    onPressed: () => globalController.registerUser(
                        globalController.emailController.text,
                        globalController.passController.text,
                        globalController.fullNameController.text),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
