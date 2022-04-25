import 'dart:ui';
import 'package:artsen_van/bindings/global_bindings.dart';
import 'package:artsen_van/controllers/global_controller.dart';
import 'package:artsen_van/screens/courses/single_course_overview_screen.dart';
import 'package:artsen_van/screens/courses/course_review_screen.dart';
import 'package:artsen_van/screens/courses/enrolled_courses_screen.dart';
import 'package:artsen_van/screens/settings_screen.dart';
import 'package:artsen_van/screens/splash_screen.dart';
import 'package:artsen_van/screens/testScreen.dart';
import 'package:artsen_van/utils/constants.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());

  // for preview

  // runApp(
  //   DevicePreview(
  //     enabled: !kReleaseMode,
  //     builder: (context) => MyApp(), // Wrap your app
  //   ),
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    double screenWidth = window.physicalSize.width;
    return GetBuilder<GlobalController>(
      init: GlobalController(),
      builder: (value) => Sizer(
        builder: (context, orientation, deviceType) => GetMaterialApp(
          // builder: DevicePreview.appBuilder,
          debugShowCheckedModeBanner: false,
          initialBinding: GlobalBinding(),
          title: 'Flutter Demo',
          theme: ThemeData(
              primarySwatch: Colors.cyan,
              textTheme: value.isFontLarge.value ? TEXT_THEME_DEFAULT : TEXT_THEME_SMALL,
              fontFamily: "Montserrat"),
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
