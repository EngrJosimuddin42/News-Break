import 'package:get/get.dart';
import '../controllers/community_controller.dart';
import '../controllers/me_controller.dart';
import '../controllers/notification_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<CommunityController>(() => CommunityController());
    Get.lazyPut<NotificationController>(() => NotificationController());
    Get.lazyPut<MeController>(() => MeController());
  }
}