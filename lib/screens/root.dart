import 'package:artsen_van/controllers/global_controller.dart';
import 'package:artsen_van/screens/authentication/login_screen.dart';
import 'package:artsen_van/screens/courses/enrolled_courses_screen.dart';
import 'package:artsen_van/screens/courses/single_course_overview_screen.dart';
import 'package:artsen_van/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class Root extends StatefulWidget {
  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  final _controller = Get.find<GlobalController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return _controller.user == null
          ? const LoginScreen()
          : _controller.isLoading.value
              ? const Scaffold(
        backgroundColor: COLOR_OFFWHITE,
                  body: Center(
                      child: SpinKitFadingCube(
                    color: Colors.cyan,
                  )),
                )
              : const EnrolledCoursesScreen();
    });
  }
}
