import 'package:artsen_van/controllers/global_controller.dart';
import 'package:artsen_van/screens/settings_screen.dart';
import 'package:artsen_van/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

final _controller = Get.find<GlobalController>();

void showSnackBar(String title, msg, {icon}) {
  final controller = Get.find<GlobalController>();
  if (controller.isLightTheme.value) {
    Get.snackbar(
      title,
      msg,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: COLOR_DARK_BLUE,
      colorText: COLOR_WHITE,
      icon: icon == null && title == 'Success'
          ? const Icon(
              Icons.check_circle,
              color: Colors.cyan,
            )
          : icon == null && title == 'Error'
              ? const Icon(
                  Icons.dangerous,
                  color: Colors.red,
                )
              : icon,
    );
  } else {
    Get.snackbar(
      title,
      msg,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: COLOR_OFFWHITE,
      colorText: Colors.black,
      icon: icon == null && title == 'Success'
          ? const Icon(
              Icons.check_circle,
              color: Colors.cyan,
            )
          : icon == null && title == 'Error'
              ? const Icon(
                  Icons.dangerous,
                  color: Colors.red,
                )
              : icon,
    );
  }
}

 showCustomDialog(title) async {
  Get.defaultDialog(
      backgroundColor:
          _controller.isLightTheme.value ? COLOR_OFFWHITE : COLOR_DARK_BLUE,
      radius: 8.0,
      titlePadding: EdgeInsets.all(16.0),
      contentPadding: EdgeInsets.all(16.0),
      title: '$title',
      titleStyle: TextStyle(
          fontSize: 22,
          color: _controller.isLightTheme.value ? COLOR_BLACK : COLOR_WHITE),
      content: SpinKitFadingCube(
        color: Colors.cyan,
        size: 65.0,
      ));

}

 closeCustomDialog() {
  if (Get.isDialogOpen == true) {
     Get.back(closeOverlays: true);
  }
  return;
}
