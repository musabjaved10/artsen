import 'package:artsen_van/controllers/course_controller.dart';
import 'package:artsen_van/controllers/global_controller.dart';
import 'package:get/get.dart';


class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<GlobalController>(GlobalController());
    Get.put<CourseController>(CourseController());
  }
}