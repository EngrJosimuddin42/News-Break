import 'package:get/get.dart';
import '../../community/controllers/community_controller.dart';
import '../../me/controllers/me_controller.dart';
import '../../notification/controllers/notification_controller.dart';
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