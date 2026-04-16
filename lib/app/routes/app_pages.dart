import 'package:get/get.dart';
import '../bindings/community_binding.dart';
import '../modules/community/community_create_post_view.dart';
import '../bindings/create_post_binding.dart';
import '../modules/create_post/create_post_view.dart';
import '../bindings/edit_tabs_binding.dart';
import '../modules/edit_tabs/edit_tabs_view.dart';
import '../bindings/fullscreen_binding.dart';
import '../modules/fullscreen/fullscreen_view.dart';
import '../bindings/home_binding.dart';
import '../modules/home/home_view.dart';
import '../bindings/signin_binding.dart';
import '../modules/signin/signin_view.dart';
import '../bindings/splash_binding.dart';
import '../modules/splash/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.FULLSCREEN,
      page: () => const FullscreenView(),
      binding: FullscreenBinding(),
    ),
    GetPage(
      name: _Paths.SIGNIN,
      page: () => const SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_TABS,
      page: () => const EditTabsView(),
      binding: EditTabsBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_POST,
      page: () => const CreatePostView(),
      binding: CreatePostBinding(),
    ),
    GetPage(
      name: _Paths.COMMUNITY_CREATE_POST,
      page: () => const CommunityCreatePostView(),
      binding: CommunityBinding(),
    ),
  ];
}