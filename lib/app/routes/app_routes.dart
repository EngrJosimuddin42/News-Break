part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const SPLASH = _Paths.SPLASH;
  static const FULLSCREEN = _Paths.FULLSCREEN;
  static const SIGNIN = _Paths.SIGNIN;
  static const HOME = _Paths.HOME;
  static const EDIT_TABS = _Paths.EDIT_TABS;
  static const CREATE_POST = _Paths.CREATE_POST;
  static const TAG_LOCATION = _Paths.TAG_LOCATION;
}

abstract class _Paths {
  _Paths._();
  static const SPLASH = '/splash';
  static const FULLSCREEN = '/fullscreen';
  static const SIGNIN = '/signin';
  static const HOME = '/home';
  static const EDIT_TABS = '/edit-tabs';
  static const CREATE_POST = '/create-post';
  static const TAG_LOCATION = '/tag-location';
}