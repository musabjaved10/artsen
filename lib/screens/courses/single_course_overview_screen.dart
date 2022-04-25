import 'package:artsen_van/bindings/media_binding.dart';
import 'package:artsen_van/controllers/course_controller.dart';
import 'package:artsen_van/controllers/global_controller.dart';
import 'package:artsen_van/screens/courses/chapter_screen.dart';
import 'package:artsen_van/screens/settings_screen.dart';
import 'package:artsen_van/utils/constants.dart';
import 'package:artsen_van/widgets/small_round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:number_to_words/number_to_words.dart';

class SingleCourseOverViewScreen extends StatefulWidget {
  const SingleCourseOverViewScreen({Key? key}) : super(key: key);

  @override
  State<SingleCourseOverViewScreen> createState() =>
      _CourseOverViewScreenState();
}

class _CourseOverViewScreenState extends State<SingleCourseOverViewScreen> {
  final courseId = Get.arguments[0];
  final _courseController = Get.find<CourseController>();

  @override
  void initState() {
    super.initState();
    _courseController.getSingleCourseById(courseId);
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return GetBuilder<GlobalController>(
        builder: (controller) => Scaffold(
              backgroundColor: controller.isLightTheme.value
                  ? COLOR_OFFWHITE
                  : COLOR_DARK_BLUE,
              body: SafeArea(
                child: Container(
                  padding: EdgeInsets.all(DEFAULT_PADDING),
                  height: Get.height,
                  width: double.infinity,
                  child: Obx(
                    () => _courseController.isSingleCourseLoading.value
                        ? Center(
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
                                    controller.isLightTheme.value
                                        ? 'assets/images/logo-light.png'
                                        : 'assets/images/logo-dark.png',
                                    width: Get.width * 0.5,
                                  ),
                                  SmallButton(
                                    icon: Icons.settings,
                                    onPressed: () =>
                                        Get.to(() => SettingsScreen()),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              Text(
                                '${_courseController.singleCourse.title}',
                                style: !controller.isLightTheme.value
                                    ? themeData.textTheme.headline1
                                    : themeData.textTheme.headline2,
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Container(
                                padding: EdgeInsets.all(12.0),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: controller.isLightTheme.value
                                            ? Colors.transparent
                                            : Colors.cyan),
                                    boxShadow: [
                                      BoxShadow(
                                        color: controller.isLightTheme.value
                                            ? Colors.grey.shade400
                                            : Colors.transparent,
                                        blurRadius: 10.0, // soften the shadow
                                        offset: Offset(
                                          1.0, // Move to right 10  horizontally
                                          5.0, // Move to bottom 10 Vertically
                                        ),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(14.0),
                                    color: controller.isLightTheme.value
                                        ? Colors.white
                                        : COLOR_DARK_BLUE),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _courseController
                                          .singleCourse.description,
                                      style: !controller.isLightTheme.value
                                          ? themeData.textTheme.bodyText1
                                          : themeData.textTheme.bodyText2,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      _courseController.singleCourse.status,
                                      style: !controller.isLightTheme.value
                                          ? themeData.textTheme.headline5
                                          : themeData.textTheme.headline6,
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    progressBar(controller),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                  child: ListView.builder(
                                physics: const BouncingScrollPhysics(
                                    parent: AlwaysScrollableScrollPhysics()),
                                itemCount: _courseController
                                    .singleCourse.chapters.length,
                                itemBuilder: (context, index) => ChapterTile(
                                  index: index,
                                  controller: controller,
                                  themeData: themeData,
                                  id: _courseController
                                      .singleCourse.chapters[index]['id'],
                                  title: _courseController
                                      .singleCourse.chapters[index]['title'],
                                  description: _courseController.singleCourse
                                      .chapters[index]['description'],
                                  is_completed: _courseController.singleCourse
                                      .chapters[index]['is_completed'],
                                  picture: _courseController
                                      .singleCourse.chapters[index]['picture'],
                                  time_to_complete: _courseController
                                      .singleCourse
                                      .chapters[index]['time_to_complete'],
                                ),
                              )),
                              SizedBox(
                                height: 12,
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ));
  }

  Container progressBar(GlobalController controller) {
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
              width: constraints.maxWidth *
                  (_courseController.singleCourse.progressValue / 100),
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

class ChapterTile extends StatelessWidget {
  const ChapterTile({
    Key? key,
    required this.themeData,
    required this.id,
    required this.is_completed,
    required this.title,
    required this.description,
    required this.picture,
    required this.time_to_complete,
    required this.controller,
    required this.index,
  }) : super(key: key);

  final GlobalController controller;
  final ThemeData themeData;
  final int id;
  final int index;
  final bool is_completed;
  final String title;
  final String description;
  final String picture;
  final int time_to_complete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => ChapterScreen(), arguments: [id], binding: MediaBinding()),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.0),
        width: double.infinity,
        decoration: BoxDecoration(
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
          color: controller.isLightTheme.value ? Colors.white : COLOR_DARK_BLUE,
          borderRadius: BorderRadius.circular(14.0),
          border: !controller.isLightTheme.value
              ? Border.all(color: Colors.cyan)
              : Border.all(color: COLOR_OFFWHITE),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/doctor.jpg'))),
              ),
              SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CHAPTER ${NumberToWord().convert('en-in', index + 1).toUpperCase()}',
                      style: !controller.isLightTheme.value
                          ? themeData.textTheme.headline3
                          : themeData.textTheme.headline4,
                    ),
                    SizedBox(height: 2),
                    is_completed
                        ? Row(
                            children: [
                              Text(
                                'COMPLETED',
                                style: !controller.isLightTheme.value
                                    ? themeData.textTheme.headline5?.copyWith(fontWeight: FontWeight.w400)
                                    : themeData.textTheme.headline6?.copyWith(fontWeight: FontWeight.w400),
                              ),
                              Icon(Icons.check, color: Colors.green,)
                            ],
                          )
                        : SizedBox(),
                    Divider(height: 5,  endIndent: 80, color: controller.isLightTheme.value ? Colors.black87 : Colors.white,),
                    SizedBox(height: 8,),
                    Text(title,style: !controller.isLightTheme.value
                        ? themeData.textTheme.headline5?.copyWith(fontWeight: FontWeight.bold)
                        : themeData.textTheme.headline6?.copyWith(fontWeight: FontWeight.bold)),
                    SizedBox(height: 14,),
                    Text('Time to Complete',style: !controller.isLightTheme.value
                        ? themeData.textTheme.bodyText1?.copyWith(fontWeight: FontWeight.bold)
                        : themeData.textTheme.bodyText2?.copyWith(fontWeight: FontWeight.bold)),
                    Text('$time_to_complete Min',style: !controller.isLightTheme.value
                        ? themeData.textTheme.bodyText1
                        : themeData.textTheme.bodyText2)
                    // Text(
                    //   description,
                    //   style: !controller.isLightTheme.value
                    //       ? themeData.textTheme.bodyText1
                    //       : themeData.textTheme.bodyText2,
                    //   maxLines: 5,
                    //   softWrap: true,
                    //   overflow: TextOverflow.clip,
                    // ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


}



