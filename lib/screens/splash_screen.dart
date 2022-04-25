import 'dart:async';

import 'package:artsen_van/bindings/course_binding.dart';
import 'package:artsen_van/screens/authentication/login_screen.dart';
import 'package:artsen_van/screens/courses/single_course_overview_screen.dart';
import 'package:artsen_van/screens/courses/enrolled_courses_screen.dart';
import 'package:artsen_van/screens/root.dart';
import 'package:artsen_van/screens/testScreen.dart';
import 'package:artsen_van/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () => Get.off(() => Root()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR_DARK_BLUE,
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Center(
          child: Image.asset('assets/images/splash_logo.png',  width: Get.width * 0.9,),
        ),
      ),
    );
  }
}
