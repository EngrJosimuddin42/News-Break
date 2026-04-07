import 'package:get/get.dart';
import '../controllers/tag_location_controller.dart';

class TagLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TagLocationController>(() => TagLocationController());
  }
}