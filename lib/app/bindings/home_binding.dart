import 'package:get/get.dart';
import '../controllers/community/community_controller.dart';
import '../controllers/me/me_controller.dart';
import '../controllers/notification/notification_controller.dart';
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