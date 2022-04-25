import 'package:artsen_van/controllers/course_controller.dart';
import 'package:artsen_van/controllers/global_controller.dart';
import 'package:artsen_van/screens/courses/single_course_overview_screen.dart';
import 'package:artsen_van/screens/settings_screen.dart';
import 'package:artsen_van/utils/constants.dart';
import 'package:artsen_van/widgets/custom_button.dart';
import 'package:artsen_van/widgets/small_round_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class EnrolledCoursesScreen extends StatefulWidget {
  const EnrolledCoursesScreen({Key? key}) : super(key: key);

  @override
  State<EnrolledCoursesScreen> createState() => _EnrolledCoursesScreenState();
}

class _EnrolledCoursesScreenState extends State<EnrolledCoursesScreen> {
  final globalController = Get.find<GlobalController>();
  final courseController = Get.find<CourseController>();

  @override
  void initState() {
    super.initState();
    courseController.getAllEnrolledCourses();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return GetBuilder<GlobalController>(
        builder: (value) => Scaffold(
              backgroundColor:
                  value.isLightTheme.value ? COLOR_OFFWHITE : COLOR_DARK_BLUE,
              body: SafeArea(
                child: Container(
                    padding: EdgeInsets.all(DEFAULT_PADDING/2),
                    width: double.infinity,
                    height: Get.height,
                    child: Obx(
                      () => courseController.isLoading.value
                          ? const Center(
                              child: SpinKitFadingCube(
                                color: Colors.cyan,
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      value.isLightTheme.value
                                          ? 'assets/images/logo-light.png'
                                          : 'assets/images/logo-dark.png',
                                      width: Get.width * 0.5,
                                    ),
                                    SmallButton(
                                      icon: Icons.settings,
                                      onPressed: () =>
                                          Get.to(() => const SettingsScreen()),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                Text(
                                  'Enrolled Courses',
                                  style: !value.isLightTheme.value
                                      ? themeData.textTheme.headline1
                                      : themeData.textTheme.headline2,
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Expanded(
                                  child: ListView.builder(
                                      padding: EdgeInsets.all(4.0),
                                      physics: const BouncingScrollPhysics(
                                          parent:
                                              AlwaysScrollableScrollPhysics()),
                                      itemCount: courseController
                                          .enrolledCourses.length,
                                      itemBuilder: (context, index) {
                                        return CourseTile(
                                          id: courseController
                                              .enrolledCourses[index].id,
                                          title: courseController
                                              .enrolledCourses[index].title,
                                          tag: courseController
                                              .enrolledCourses[index].tag,
                                          description: courseController
                                              .enrolledCourses[index]
                                              .description,
                                          progressValue: courseController
                                              .enrolledCourses[index].progressValue,
                                          controller: globalController,
                                          status: courseController
                                              .enrolledCourses[index].status,
                                        ); // return courses widget here
                                      }),
                                )
                              ],
                            ),
                    )),
              ),
            ));
  }
}

class CourseTile extends StatelessWidget {
  const CourseTile({
    Key? key,
    required this.title,
    required this.id,
    required this.tag,
    required this.description,
    required this.progressValue,
    required this.controller,
    required this.status,
  }) : super(key: key);

  final int id;
  final String title;
  final String tag;
  final String description;
  final String status;
  final int progressValue;
  final GlobalController controller;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: controller.isLightTheme.value ? COLOR_WHITE : COLOR_DARK_BLUE,
        border: Border.all(
            color: controller.isLightTheme.value
                ? Colors.transparent
                : Colors.cyan),
        boxShadow: [
          BoxShadow(
            color: controller.isLightTheme.value
                ? Colors.grey.shade400
                : Colors.transparent,
            blurRadius: 8.0,
            // soften the shadow
            offset: Offset(
              1.0,
              // Move to right 10  horizontally
              4.0, // Move to bottom 10 Vertically
            ),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: !controller.isLightTheme.value
                ? themeData.textTheme.headline3
                : themeData.textTheme.headline4,
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
            decoration: BoxDecoration(
                color: !controller.isLightTheme.value
                    ? COLOR_OFFWHITE
                    : COLOR_BLACK,
                borderRadius: BorderRadius.circular(50)),
            child: Text(
              tag,
              style: controller.isLightTheme.value
                  ? themeData.textTheme.subtitle1
                  : themeData.textTheme.subtitle2,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            description,
            style: !controller.isLightTheme.value
                ? themeData.textTheme.bodyText1
                : themeData.textTheme.bodyText2,
          ),
          const SizedBox(
            height: 18,
          ),
          Text(
            status,
            style: !controller.isLightTheme.value
                ? themeData.textTheme.headline5
                : themeData.textTheme.headline6,
          ),
          const SizedBox(
            height: 8,
          ),
          progressBar(),
          CustomButton(
            text: 'CONTINUE',
            height: 45,
            onPressed: () =>
                Get.to(() => SingleCourseOverViewScreen(), arguments: [id]),
          )
        ],
      ),
    );
  }

  Container progressBar() {
    return Container(
      width: double.infinity,
      height: 12,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          width: 0.8,
          color: controller.isLightTheme.value ? COLOR_GREY : Colors.cyan,
        ),
      ),
      child: Stack(
        children: [
          LayoutBuilder(builder: (context, constraints) {
            print(constraints.maxWidth);
            return Container(
              width: constraints.maxWidth * (progressValue / 100),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  gradient: const LinearGradient(
                      colors: [Colors.cyan, COLOR_LIGHT_BLUE],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight)),
            );
          }),
        ],
      ),
    );
  }
}
