import 'package:get/get.dart';
import '../../models/what_we_do_model.dart';

class WhatWeDoController extends GetxController {

  var isLoading = true.obs;




  final String heroImagePath = 'assets/images/phone_image.png';
  final String safetyImagePath = 'assets/images/phone.png';

  // Hero & Alert Static Data
  final String userStats = 'Over 50 Million Users';
  final String welcomeHeadline = "Welcome to the nation's\nleading news app";
  final String safetyTitle = 'Stay alert,\nStay safe';
  final String safetyDesc = 'Stay safe and informed with immediate access to local crime and police alerts and incident reports in your neighborhood';

  // CTA Sections List
  final List<WhatWeDoSection> ctaSections = [
    WhatWeDoSection(
      tag: 'For Contributors',
      title: 'Share Your Stories',
      subtitle: 'Earn recognition and revenue by sharing important stories from your community',
      buttonLabel: 'Become a contributor',
      pageKey: 'contributor',
    ),
    WhatWeDoSection(
      tag: 'For Publishers',
      title: 'Expand Your Reach',
      subtitle: 'Broaden your audience and increase your visibility and revenue by sharing your content with millions of new readers on the platform',
      buttonLabel: 'Publish on NewsBreak',
      pageKey: 'publish',
    ),
    WhatWeDoSection(
      tag: 'For Advertisers',
      title: 'Connect Effectively',
      subtitle: 'Reach more than 40 million users across the U.S. and engage with your target audience at the right moment.',
      buttonLabel: 'Advertise on NewsBreak',
      pageKey: 'advertise',
    ),
  ];
}