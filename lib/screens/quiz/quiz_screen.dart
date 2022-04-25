import 'package:artsen_van/controllers/global_controller.dart';
import 'package:artsen_van/controllers/quiz_controller.dart';
import 'package:artsen_van/screens/courses/course_review_screen.dart';
import 'package:artsen_van/screens/settings_screen.dart';
import 'package:artsen_van/utils/constants.dart';
import 'package:artsen_van/widgets/custom_button.dart';
import 'package:artsen_van/widgets/small_round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final quizId = Get.arguments[0];
  final _quizController = Get.find<QuizController>();

  @override
  void initState() {
    super.initState();
    if (quizId != null) {
      _quizController.getQuizById(quizId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GetBuilder<GlobalController>(builder: (controller) {
      return Scaffold(
        backgroundColor:
            controller.isLightTheme.value ? COLOR_OFFWHITE : COLOR_DARK_BLUE,
        body: SafeArea(
          child: Obx(() => _quizController.isQuizLoading.value
              ? Center(
                  child: SpinKitFadingCube(
                  color: Colors.cyan,
                ))
              : Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(DEFAULT_PADDING),
                  child: quizId == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'No Quiz yet',
                              style: !controller.isLightTheme.value
                                  ? textTheme.headline1
                                  : textTheme.headline2,
                            ),
                            CustomButton(
                              text: 'GO BACK',
                              onPressed: () => Get.back(),
                            )
                          ],
                        )
                      : Column(
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
                                  onPressed: () =>
                                      Get.to(() => const SettingsScreen()),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 14,
                            ),

                            // ***** Quiz Container ******
                            GetBuilder<QuizController>(
                                builder: (quizController) {
                              return Container(
                                padding: EdgeInsets.all(16.0),
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
                                        blurRadius: 8.0, // soften the shadow
                                        offset: Offset(
                                          1.0, // Move to right 10  horizontally
                                          4.0, // Move to bottom 10 Vertically
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
                                      '${quizController.currentIndex + 1}/${quizController.numOfQuestions}.${quizController.currentQuestion['title']}',
                                      style: !controller.isLightTheme.value
                                          ? textTheme.headline5
                                          : textTheme.headline6,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: Get.height * 0.28,
                                      child: ListView.builder(
                                          itemCount:
                                              quizController.options.length,
                                          itemBuilder: (context, index) {
                                            return Option(
                                              globalController: controller,
                                              quizController: quizController,
                                              textTheme: textTheme,
                                              index: index,
                                            );
                                          }),
                                    ),
                                    Divider(
                                      height: 10,
                                      endIndent: 20,
                                      color: controller.isLightTheme.value ? Colors.black : Colors.white,
                                    ),
                                    Text(
                                        quizController
                                            .currentQuestion['description'],
                                        style: !controller.isLightTheme.value
                                            ? textTheme.bodyText1
                                            : textTheme.bodyText2,
                                        softWrap: true),
                                    SizedBox(
                                      height: 14,
                                    ),
                                    quizController.quizFinished == true
                                     ? Center(
                                        child: CustomButton(
                                          text: 'SUBMIT',
                                          onPressed: () => Get.to(() => CourseReviewScreen(), arguments: [quizId]),
                                        ))
                                    :quizController.isAnswered == true
                                        ? Center(
                                            child: CustomButton(
                                            text: 'NEXT',
                                            onPressed: () => quizController
                                                .getNextQuestion(),
                                          ))
                                        : SizedBox()
                                  ],
                                ),
                              );
                            }),
                          ],
                        ),
                )),
        ),
      );
    });
  }
}

class Option extends StatefulWidget {
   Option({
    Key? key,
    required this.textTheme,
    required this.quizController,
    required this.index,
    required this.globalController,
  }) : super(key: key);

  final TextTheme textTheme;
  final QuizController quizController;
  final GlobalController globalController;
  final int index;

  @override
  State<Option> createState() => _OptionState();
}

class _OptionState extends State<Option> {
  bool isCorrect = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () {
          widget.quizController.checkFinished();
          if(!widget.quizController.isAnswered){
            setState(() {
              isCorrect = widget.quizController.isCorrectlyAnswered(widget.index);
            });
          }

        },
        horizontalTitleGap: -5,
        dense: true,
        leading: getRightLeadingIcon(),
        trailing: getRightIcon(),
        title: Text(
          widget.quizController.options[widget.index]['answer'],
          style: !widget.globalController.isLightTheme.value
              ? widget.textTheme.bodyText1
              : widget.textTheme.bodyText2,
        ));
  }

  getRightIcon(){
    if(widget.quizController.isAnswered && widget.quizController.correctIndex == widget.index ){
      return Icon(Icons.check_circle, color: Colors.green,);
    }
    else if(widget.quizController.isAnswered && !isCorrect && widget.quizController.selectedIndex == widget.index){
      return Icon(Icons.dangerous_rounded, color: Colors.red,);
    }
    else {
      return Icon(null);
    }
  }

  getRightLeadingIcon(){
    if(widget.quizController.isAnswered && widget.quizController.selectedIndex == widget.index){
      return Icon(Icons.circle, color: Colors.cyan,size: 20,);
    }else{
      return Icon(Icons.circle_outlined,size: 20, color: widget.globalController.isLightTheme.value ? Colors.black : Colors.white,);
    }
  }
}
