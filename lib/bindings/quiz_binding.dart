import 'package:artsen_van/controllers/quiz_controller.dart';
import 'package:get/get.dart';


class QuizBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<QuizController>(QuizController());
  }
}