import 'package:artsen_van/controllers/global_controller.dart';
import 'package:artsen_van/utils/constants.dart';
import 'package:artsen_van/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GetBuilder<GlobalController>(
      builder: (value) => Scaffold(
        backgroundColor:
            value.isLightTheme.value ? COLOR_DARK_BLUE : Colors.black,
        body: Container(
          width: Get.width,
          height: Get.height,
          child: Center(
            child: CustomButton(
              text: 'Change Theme',
              height: Get.height * 0.08,
              width: Get.width * 0.5,
              onPressed: () => value.changeTheme(),
            ),
          ),
        ),
      ),
    ));
  }
}



