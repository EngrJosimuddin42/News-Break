import 'package:get/get.dart';
import '../controllers/ad_banner_controller.dart';
import '../controllers/comment_controller.dart';
import '../controllers/community/community_controller.dart';
import '../controllers/me/me_controller.dart';
import '../controllers/notification/notification_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/reels/reels_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<CommentController>(() => CommentController(), fenix: true);
    Get.lazyPut<ReelsController>(() => ReelsController(), fenix: true);
    Get.lazyPut<CommunityController>(() => CommunityController(), fenix: true);
    Get.lazyPut<AdBannerController>(() => AdBannerController(), fenix: true);
    Get.lazyPut<NotificationController>(() => NotificationController(), fenix: true);
    Get.lazyPut<MeController>(() => MeController(), fenix: true);
  }
}