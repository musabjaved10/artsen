import 'package:artsen_van/controllers/media_controller.dart';
import 'package:get/get.dart';


class MediaBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MediaController>(MediaController());
  }
}