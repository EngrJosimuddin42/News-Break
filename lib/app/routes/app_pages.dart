import 'package:get/get.dart';
import '../modules/community/bindings/community_binding.dart';
import '../modules/community/views/community_create_post_view.dart';
import '../modules/create_post/bindings/create_post_binding.dart';
import '../modules/create_post/views/create_post_view.dart';
import '../modules/edit_tabs/bindings/edit_tabs_binding.dart';
import '../modules/edit_tabs/views/edit_tabs_view.dart';
import '../modules/fullscreen/bindings/fullscreen_binding.dart';
import '../modules/fullscreen/views/fullscreen_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/signin/bindings/signin_binding.dart';
import '../modules/signin/views/signin_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

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