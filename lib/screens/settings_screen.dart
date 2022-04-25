import 'package:artsen_van/controllers/global_controller.dart';
import 'package:artsen_van/screens/authentication/login_screen.dart';
import 'package:artsen_van/utils/constants.dart';
import 'package:artsen_van/utils/util_functions.dart';
import 'package:artsen_van/widgets/custom_button.dart';
import 'package:artsen_van/widgets/small_round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return GetBuilder<GlobalController>(
      builder: (controller) => Scaffold(
          backgroundColor:
          controller.isLightTheme.value ? COLOR_OFFWHITE : COLOR_DARK_BLUE,
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.all(DEFAULT_PADDING),
              height: Get.height,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        controller.isLightTheme.value
                            ? 'assets/images/logo-light.png'
                            : 'assets/images/logo-dark.png',
                        width: Get.width * 0.5,
                      ),
                      SmallButton(
                        icon: Icons.arrow_back_ios_outlined,
                        onPressed: () => Get.back(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'SETTINGS',
                    style: !controller.isLightTheme.value
                        ? themeData.textTheme.headline1
                        : themeData.textTheme.headline2,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 18.0),
                    width: double.infinity * 0.9,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: controller.isLightTheme.value
                              ? Colors.grey.shade400
                              : Colors.transparent,
                          blurRadius: 10.0, // soften the shadow
                          offset: const Offset(
                            1.0, // Move to right 10  horizontally
                            5.0, // Move to bottom 10 Vertically
                          ),
                        )
                      ],
                      color: controller.isLightTheme.value
                          ? Colors.white
                          : COLOR_DARK_BLUE,
                      borderRadius: BorderRadius.circular(10.0),
                      border: !controller.isLightTheme.value
                          ? Border.all(color: Colors.cyan)
                          : Border.all(color: COLOR_OFFWHITE),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'FONT SIZE',
                          style: !controller.isLightTheme.value
                              ? themeData.textTheme.headline3
                              : themeData.textTheme.headline4,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        fontToggleButton(controller),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'CONTRAST',
                          style: !controller.isLightTheme.value
                              ? themeData.textTheme.headline3
                              : themeData.textTheme.headline4,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        themeToggleButton(controller),
                        const SizedBox(height: 15),
                        Text(
                          'AUDIO SPEED',
                          style: !controller.isLightTheme.value
                              ? themeData.textTheme.headline3
                              : themeData.textTheme.headline4,
                        ),
                        const SizedBox(height: 15),
                        Slider(
                            activeColor: Colors.cyan,
                            value: controller.audioSpeed,
                            divisions: 2,
                            min: 0.5,
                            max: 1.5,
                            onChanged: (speedValue) {
                              controller.changeAudioPlaybackSpeed(speedValue);
                            }),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '0.5x',
                                style: !controller.isLightTheme.value
                                    ? themeData.textTheme.headline5
                                    : themeData.textTheme.headline6,
                              ),
                              Text(
                                '1x',
                                style: !controller.isLightTheme.value
                                    ? themeData.textTheme.headline5
                                    : themeData.textTheme.headline6,
                              ),
                              Text(
                                '1.5x',
                                style: !controller.isLightTheme.value
                                    ? themeData.textTheme.headline5
                                    : themeData.textTheme.headline6,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  Center(child: CustomButton(text: 'Logout', onPressed: () async{
                    controller.signOut();

                    },))
                ],
              ),
            ),
          )),
    );
  }

  FlutterToggleTab themeToggleButton(GlobalController value) {
    return FlutterToggleTab(
      // width in percent, to set full width just set to 100
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      width: Get.width * 0.22,
      borderRadius: 30,
      height: 45,
      selectedIndex: value.isLightTheme.value ? 0 : 1,
      selectedBackgroundColors: const [Colors.cyan, Color(0xff21e3e3)],
      unSelectedBackgroundColors: const [Color(0xaab2f5f5)],
      isShadowEnable: false,
      selectedTextStyle: const TextStyle(
          color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
      unSelectedTextStyle: const TextStyle(
        color: Colors.black87,
        fontSize: 12,
      ),
      labels: const ["LIGHT", "DARK"],
      selectedLabelIndex: (index) {
        value.changeTheme();
      },
    );
  }

  FlutterToggleTab fontToggleButton(GlobalController value) {
    return FlutterToggleTab(
      // width in percent, to set full width just set to 100
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      width: Get.width * 0.22,
      borderRadius: 30,
      height: 45,
      selectedIndex: value.isFontLarge.value ? 1 : 0,
      selectedBackgroundColors: const [Colors.cyan, Color(0xff21e3e3)],
      unSelectedBackgroundColors: const [Color(0xaab2f5f5)],
      selectedTextStyle: const TextStyle(
          color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
      unSelectedTextStyle: const TextStyle(
        color: Colors.black87,
        fontSize: 12,
      ),
      labels: const ["SMALL", "BIG"],
      selectedLabelIndex: (index) {
        value.changeFont();
      },
    );
  }
}
