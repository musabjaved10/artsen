import 'package:artsen_van/controllers/course_controller.dart';
import 'package:artsen_van/controllers/global_controller.dart';
import 'package:artsen_van/screens/settings_screen.dart';
import 'package:artsen_van/utils/constants.dart';
import 'package:artsen_van/widgets/custom_button.dart';
import 'package:artsen_van/widgets/small_round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:get/get.dart';

class CourseReviewScreen extends StatefulWidget {
  const CourseReviewScreen({Key? key}) : super(key: key);

  @override
  State<CourseReviewScreen> createState() => _CourseReviewScreenState();
}

class _CourseReviewScreenState extends State<CourseReviewScreen> {
  final quizId = Get.arguments[0];
  final courseController = Get.find<CourseController>();


  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return GetBuilder<GlobalController>(
      builder: (controller) => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: controller.isLightTheme.value
            ? COLOR_OFFWHITE
            : COLOR_DARK_BLUE,
        body:  SafeArea(
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
                            icon: Icons.settings,
                            onPressed: () => Get.to(() => SettingsScreen()),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'REVIEW COURSE',
                        style: !controller.isLightTheme.value
                            ? themeData.textTheme.headline1
                            : themeData.textTheme.headline2,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 14.0),
                        decoration: BoxDecoration(
                          border: !controller.isLightTheme.value
                              ? Border.all(color: Colors.cyan)
                              : Border.all(color: COLOR_OFFWHITE),
                          borderRadius: BorderRadius.circular(10.0),
                          color: controller.isLightTheme.value
                              ? Colors.white
                              : COLOR_DARK_BLUE,
                          boxShadow: [
                            BoxShadow(
                                color: controller.isLightTheme.value
                                    ? Colors.grey.shade400
                                    : Colors.transparent,
                                blurRadius: 10.0,
                                offset: Offset(1.0, 5.0))
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${courseController.singleCourse.title}',
                              style: !controller.isLightTheme.value
                                  ? themeData.textTheme.headline3
                                  : themeData.textTheme.headline4,
                            ),
                            SizedBox(height: 16),
                            RatingBar.builder(
                              unratedColor: controller.isLightTheme.value ? Colors.grey.shade300 : Colors.white,
                              initialRating: 3,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.cyan,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                            SizedBox(height: 12,),
                            Container(
                              padding: EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                border: !controller.isLightTheme.value
                                    ? Border.all(color: COLOR_OFFWHITE, width: 1.5)
                                    : Border.all(color: Colors.cyan, width: 1.5),
                                borderRadius: BorderRadius.circular(10.0),
                                color: controller.isLightTheme.value
                                    ? Colors.white
                                    : COLOR_DARK_BLUE,
                              ),
                                child: TextField(
                                  style: !controller.isLightTheme.value ? themeData.textTheme.bodyText1 : themeData.textTheme.bodyText2,
                                  decoration: InputDecoration(
                                    focusedBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    hintText: 'Message',
                                    hintStyle: !controller.isLightTheme.value ? themeData.textTheme.bodyText1 : themeData.textTheme.bodyText2,
                                  ),
                                  minLines: 8,
                                  maxLines: 14,
                                ),
                            ),
                            SizedBox(height: 12,),
                            CustomButton(text: 'Submit', onPressed: () => courseController.submitCourseReview(courseController.singleCourse.id),)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )),
    );
  }
}
