import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/widgets/app_snackbar.dart';
import 'package:share_plus/share_plus.dart';
import '../models/clip_model.dart';
import '../models/news_model.dart';
import 'auth_controller.dart';
import '../routes/app_pages.dart';
import '../modules/ai/nbot_sheet.dart';
import '../modules/location/choose_location_sheet.dart';
import '../modules/location/manage_location_view.dart';
import '../modules/search/search_page_view.dart';

class HomeController extends GetxController {

  // Tab list
  final RxList<String> tabs = <String>['Reactions', 'For you', 'Local', 'Local Tv', 'Entertainment', 'Sports', 'Food', 'Health', 'Beauty', 'Weather'].obs;

  final RxInt selectedTabIndex = 0.obs;
  final RxInt selectedNavIndex = 0.obs;
  final selectedLocation = Rxn<Map<String, String>>();
  bool isLiked(int id) => likedNewsIds.contains(id);
  var likedNewsIds = <int>{}.obs;
  var isLoading = false.obs;
  var isHourly = true.obs;
  var currentTemp = "44°F".obs;
  var weatherCondition = "Rain".obs;
  var rainProbability = "71%".obs;
  var showAd = true.obs;
  final RxList<double> rainBarData = [0.06, 0.02, 0.04, 0.03, 0.08, 0.02, 0.05].obs;
  var chartData = <double>[0.06, 0.02, 0.04, 0.03, 0.08, 0.02, 0.05].obs;
  String get locationTitle => selectedLocation.value?['city'] ?? 'Choose Your Location';

  // Auth check
  bool get isLoggedIn => AuthController.to.user.value != null;
  String get userName => AuthController.to.user.value?.name ?? '';

  void onNavTap(int index) {
    selectedNavIndex.value = index;
  }

  void onTabTap(int index) {
    selectedTabIndex.value = index;
  }

  void onEditTabs() => Get.toNamed(Routes.EDIT_TABS, arguments: tabs);

  void onAI() {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const NBotSheet());
  }

  void toggleFollow(dynamic item) {
    if (item == null) return;
    item.isFollowing = !(item.isFollowing ?? false);
    int currentFollowers = _parseStatCount(item.totalFollowers.toString());
    if (item.isFollowing) {
      currentFollowers++;
    } else {
      currentFollowers = currentFollowers > 0 ? currentFollowers - 1 : 0;
    }
    item.totalFollowers = formatCount(currentFollowers);
    update();
  }

  int _parseStatCount(String count) {
    count = count.toLowerCase().replaceAll(',', '');
    if (count.contains('k')) {
      return (double.parse(count.replaceAll('k', '')) * 1000).toInt();
    } else if (count.contains('m')) {
      return (double.parse(count.replaceAll('m', '')) * 1000000).toInt();
    }
    return int.tryParse(count) ?? 0;
  }

  String formatCount(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return count.toString();
  }

  void onSearch() => Get.to(() => const SearchPageView());

  void onManageLocation() {
    Get.to(() => const ManageLocationView());
  }

  void onChooseLocation() {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const ChooseLocationSheet());
  }

  void setLocation(Map<String, String> location) {
    selectedLocation.value = location;
  }

  void onCreatePost() {
    if (isLoggedIn) {
      Get.toNamed(Routes.CREATE_POST);
    } else {
      Get.toNamed(Routes.SIGNIN);
    }
  }

  void onFollow(String publisher) {
    if (!isLoggedIn) Get.toNamed(Routes.SIGNIN);
  }

  void onDismiss(String publisher) {}

  void hideNews(NewsModel news) {
    reactionsNews.remove(news);
    forYouNews.remove(news);
    localNews.remove(news);
    localTvNews.remove(news);
    entertainmentNews.remove(news);
    sportsNews.remove(news);
    foodNews.remove(news);
    healthNews.remove(news);
    beautyNews.remove(news);
    weatherNews.remove(news);
    update();
    AppSnackbar.success(message: 'News hidden from your feed');
  }

  void onTryAgain() {}


  void onLikePressed(NewsModel news) {
    if (likedNewsIds.contains(news.id)) {
      likedNewsIds.remove(news.id);
    } else {
      likedNewsIds.add(news.id);
    }
  }

  void onCommentPressed(NewsModel news) {
    AppSnackbar.success(
        message: 'Opening comments for ${news.publisherName}');
  }

  void onSharePressed(NewsModel news) async {
    await Share.share(
      'Check out this news: ${news.title}\nRead more at: ${news.imageUrl}',
      subject: news.title,
    );
  }

  void onFollowPeople(int index) {
    if (!isLoggedIn) {
      Get.toNamed(Routes.SIGNIN);
      return;
    }
    suggestedPeople[index]['isFollowing'] = !suggestedPeople[index]['isFollowing'];
    suggestedPeople.refresh();
  }

  void onDismissPeople(int index) {
    suggestedPeople.removeAt(index);
  }

  // Reactions Tab
  final RxList<NewsModel> reactionsNews = <NewsModel>[
    NewsModel(
      id: 101,
      publisherName: 'shefinds',
      publisherImageUrl: 'https://images.unsplash.com/photo-1587300003388-59208cc962cb?w=800',
      publisherMeta: 'user · Beverly Hills, CA',
      timeAgo: '6d',
      title: "For seven long years, he served without ever asking for anything in return. His name is Sergeant Diesel...",
      imageUrl: 'https://images.unsplash.com/photo-1587300003388-59208cc962cb?w=800',
      category: 'Pets & Animals',
      author: 'Staff',
      body: 'Full content here...',
      likes: '1.2K',
      comments: '2.3K',
      shares: '1.5K',
      reactions: '1.4K',
      isVerified: true,
    ),
    NewsModel(
      id: 999999,
      publisherName: 'Bingo Fun',
      publisherImageUrl: 'https://images.unsplash.com/photo-1587300003388-59208cc962cb?w=800',
      publisherMeta: 'Sponsored',
      publisherType: 'Ad',
      totalFollowers: '1.2M',
      timeAgo: 'Now',
      title: "Bingo Fun Ad - Play and Win exciting prizes today!",
      imageUrl: 'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=800',
      category: 'Promotion',
      author: 'Bingo Team',
      body: 'This is an advertisement content...',
      likes: '10K',
      comments: '500',
      shares: '2K',
      reactions: '5.4K',
      isVerified: true,
      videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    ),
    NewsModel(
      id: 102,
      publisherName: 'ESPN',
      publisherMeta: 'Partner publisher · New York, NY',
      timeAgo: '3h',
      title: "NBA Playoffs: Underdog Team Clinches Surprising Victory...",
      imageUrl: 'https://images.unsplash.com/photo-1546519638-68e109498ffc?w=800',
      category: 'Sports',
      body: 'Full content here...',
      likes: '5.4K',
      comments: '2.3K',
      shares: '1.5K',
      reactions: '0',
      author: 'Sports Desk',
      videoUrl: 'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4',
      isVerified: true,
    ),
    NewsModel(
      id: 103,
      publisherName: 'BBC News',
      publisherMeta: 'Partner publisher · London, UK',
      timeAgo: '1d',
      title: "World Leaders Gather for Emergency Climate Summit...",
      imageUrl: 'https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=800',
      category: 'World',
      body: 'Full content here...',
      likes: '7.5K',
      comments: '2.3K',
      shares: '1.5K',
      reactions: '5.2K',
      author: 'Global Team',
      isVerified: true,
    ),
    NewsModel(
      id: 104,
      publisherName: 'TechCrunch',
      publisherMeta: 'Partner publisher · San Francisco, CA',
      timeAgo: '5h',
      title: "Apple Announces Revolutionary AI Features Coming to iPhone...",
      imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=800',
      category: 'Technology',
      body: 'Full content here...',
      likes: '3.2K',
      comments: '2.3K',
      shares: '1.5K',
      reactions: '2.8K',
      author: 'Tech Desk',
      isVerified: true,
    ),
  ].obs;

  // Local Tab
  final RxList<NewsModel> localNews = <NewsModel>[
    NewsModel(
      id: 101,
      publisherName: 'Daily news',
      publisherImageUrl: 'https://images.unsplash.com/photo-1588681664899-f142ff2dc9b1?w=800',
      publisherType: 'Partner publisher',
      publisherMeta: 'New York, NY',
      totalFollowers: '833.3K',
      imageUrl: 'https://images.unsplash.com/photo-1588681664899-f142ff2dc9b1?w=800',
      category: 'New York',
      author: 'Local Desk',
      timeAgo: '19h',
      title: "'The View' Fans Think Whoopi Goldberg Has 'Lost Her Mind' After She Suggests Donald Trump's Iran War Is A Distraction From Nancy Guthrie...",
      body: 'Full news content here...',
      videoUrl: 'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4',
      reactions: '1.4K',
      likes: '1.4K',
      comments: '4K',
      isVerified: true,
    ),
    NewsModel(
      id: 102,
      publisherName: 'Daily news',
      publisherType: 'Partner publisher',
      publisherMeta: 'New York, NY',
      totalFollowers: '833.3K',
      imageUrl: 'https://images.unsplash.com/photo-1557804506-669a67965ba0?w=800',
      category: 'New York',
      author: 'News Team',
      timeAgo: '2h',
      title: 'Local TV Coverage: Major Event Unfolds Across the City as Thousands Gather for Historic Moment',
      body: 'Full news content here...',
      reactions: '2.1K',
      likes: '3.4K',
      comments: '1.8K',
      isVerified: true,
    ),
  ].obs;

  // Extended Daily Weather
  final RxList<Map<String, String>> weatherDays = <Map<String, String>>[
    {
      'day': 'Today',
      'icon': 'assets/icons/weather_cloudy.png',
      'temp': '30°/40°'
    },
    {
      'day': '04/11',
      'icon': 'assets/icons/weather_sunny.png',
      'temp': '30°/40°'
    },
    {
      'day': '04/10',
      'icon': 'assets/icons/weather_sunny.png',
      'temp': '30°/40°'
    },
    {
      'day': '04/09',
      'icon': 'assets/icons/weather_storm.png',
      'temp': '30°/40°'
    },
    {
      'day': '04/08',
      'icon': 'assets/icons/weather_sunny.png',
      'temp': '30°/40°'
    },
    {
      'day': '04/07',
      'icon': 'assets/icons/weather_sunny.png',
      'temp': '30°/40°'
    },
    {
      'day': '04/06',
      'icon': 'assets/icons/weather_storm.png',
      'temp': '30°/40°'
    },
  ].obs;

  // Local Tv Tab
  final RxList<NewsModel> localTvNews = <NewsModel>[
    NewsModel(
      id: 101,
      publisherName: 'Daily news',
      publisherType: 'Partner publisher',
      publisherMeta: 'New York, NY',
      totalFollowers: '833.3K',
      imageUrl: 'https://images.unsplash.com/photo-1585829365295-ab7cd400c167?w=800',
      category: 'New York',
      author: 'Local Desk',
      timeAgo: '19h',
      title: "'The View' Fans Think Whoopi Goldberg Has 'Lost Her Mind' After She Suggests Donald Trump's Iran War Is A Distraction From Nancy Guthrie...",
      body: 'News detail content here...',
      reactions: '1.4K',
      likes: '1.4K',
      comments: '4K',
      isVerified: true,
    ),
    NewsModel(
      id: 102,
      publisherName: 'Daily news',
      publisherType: 'Partner publisher',
      publisherMeta: 'New York, NY',
      totalFollowers: '833.3K',
      imageUrl: 'https://images.unsplash.com/photo-1540575467063-178a50c2df87?w=800',
      category: 'New York',
      author: 'News Team',
      timeAgo: '2h',
      title: 'Local TV Coverage: Major Event Unfolds Across the City...',
      body: 'News detail content here...',
      reactions: '2.1K',
      likes: '3.4K',
      comments: '1.8K',
      isVerified: true,
    ),
  ].obs;

// Beauty Tab
  final RxList<NewsModel> beautyNews = <NewsModel>[
    NewsModel(
      id: 101,
      publisherName: 'shefinds',
      publisherMeta: 'Partner publisher',
      publisherType: 'Partner publisher',
      totalFollowers: '833.3K',
      imageUrl: 'https://images.unsplash.com/photo-1570172619644-dfd03ed5d881?w=800',
      category: 'OPINION',
      author: 'Shefinds Staff',
      timeAgo: '19h',
      title: "'The View' Fans Think Whoopi Goldberg Has 'Lost Her Mind'...",
      body: 'Full content here...',
      reactions: '1.4K',
      likes: '1.4K',
      comments: '4K',
    ),
    NewsModel(
      id: 102,
      publisherName: 'shefinds',
      publisherMeta: 'Partner publisher',
      publisherType: 'Partner publisher',
      totalFollowers: '833.3K',
      imageUrl: 'https://images.unsplash.com/photo-1596462502278-27bfdc403348?w=800',
      category: 'MAKEUP',
      timeAgo: '3h',
      author: 'Beauty Desk',
      title: 'The Best Drugstore Makeup Dupes...',
      body: 'Full content here...',
      reactions: '3.7K',
      likes: '8.2K',
      comments: '4.6K',
    ),
    NewsModel(
      id: 103,
      publisherName: 'Allure',
      publisherMeta: 'Partner publisher',
      publisherType: 'Partner publisher',
      totalFollowers: '2.1M',
      imageUrl: 'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?w=800',
      category: 'SKINCARE',
      author: 'Beauty Desk',
      timeAgo: '6h',
      title: 'Dermatologists Reveal the One Ingredient...',
      body: 'Full content here...',
      reactions: '5.4K',
      likes: '10.1K',
      comments: '6.3K',
    ),
    NewsModel(
      id: 104,
      publisherName: 'Vogue Beauty',
      publisherMeta: 'Partner publisher',
      publisherType: 'Partner publisher',
      totalFollowers: '4.6M',
      imageUrl: 'https://images.unsplash.com/photo-1487412947147-5cebf100ffc2?w=800',
      category: 'TRENDS',
      author: 'Beauty Desk',
      timeAgo: '12h',
      title: "Spring 2025's Biggest Beauty Trends...",
      body: 'Full content here...',
      reactions: '7.8K',
      likes: '14.3K',
      comments: '8.9K',
    ),
  ].obs;

  // Entertainment Tab
  final RxList<NewsModel> entertainmentNews = <NewsModel>[
    NewsModel(
      id: 101,
      publisherName: 'shefinds',
      publisherType: 'Partner publisher.',
      publisherMeta: 'Partner publisher.',
      totalFollowers: '833.3K',
      imageUrl: 'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=800',
      category: 'OPINION',
      author: 'Hollywood Desk',
      timeAgo: '19h',
      title: "'The View' Fans Think Whoopi Goldberg Has 'Lost Her Mind'...",
      body: 'Full news content...',
      reactions: '1.4K',
      likes: '1.4K',
      comments: '4K',
    ),
    NewsModel(
      id: 999999,
      publisherName: 'Bingo Fun',
      publisherImageUrl: 'https://images.unsplash.com/photo-1587300003388-59208cc962cb?w=800',
      publisherMeta: 'Sponsored',
      publisherType: 'Ad',
      totalFollowers: '1.2M',
      timeAgo: 'Now',
      title: "Bingo Fun Ad - Play and Win exciting prizes today!",
      imageUrl: 'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=800',
      category: 'Promotion',
      author: 'Bingo Team',
      body: 'This is an advertisement content...',
      likes: '10K',
      comments: '500',
      shares: '2K',
      reactions: '5.4K',
      isVerified: true,
      videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    ),
    NewsModel(
      id: 102,
      publisherName: 'shefinds',
      publisherType: 'Partner publisher.',
      publisherMeta: 'Partner publisher.',
      totalFollowers: '833.3K',
      imageUrl: 'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=800',
      category: 'ENTERTAINMENT',
      author: 'Variety Desk',
      timeAgo: '2h',
      title: 'Hollywood Stars React to the Latest Box Office Surprises...',
      body: 'Full news content...',
      reactions: '980',
      likes: '2.1K',
      comments: '1.8K',
    ),
    NewsModel(
      id: 103,
      publisherName: 'Variety',
      publisherType: 'Partner publisher.',
      publisherMeta: 'Entertainment Network',
      totalFollowers: '1.2M',
      imageUrl: 'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=800',
      category: 'MUSIC',
      author: 'Staff',
      timeAgo: '5h',
      title: 'Grammy-Winning Artist Announces Surprise Album Drop...',
      body: 'Full news content...',
      reactions: '3.4K',
      likes: '5.6K',
      comments: '2.2K',
    ),
    NewsModel(
      id: 104,
      publisherName: 'Entertainment Weekly',
      publisherType: 'Partner publisher.',
      publisherMeta: 'Media Partner',
      totalFollowers: '900K',
      imageUrl: 'https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?w=800',
      category: 'MOVIES',
      author: 'EW Staff',
      timeAgo: '8h',
      title: 'Exclusive: First Look at the Most Anticipated Sequel...',
      body: 'Full news content...',
      reactions: '2.7K',
      likes: '4.1K',
      comments: '3.3K',
    ),
  ].obs;

  // Sports Tab
  final RxList<NewsModel> sportsNews = <NewsModel>[
    NewsModel(
      id: 101,
      publisherName: 'shefinds',
      publisherType: 'Partner publisher',
      publisherMeta: 'Partner publisher',
      totalFollowers: '833.3K',
      imageUrl: 'https://images.unsplash.com/photo-1560272564-c83b66b1ad12?w=800',
      category: 'OPINION',
      author: 'Sports Desk',
      timeAgo: '19h',
      title: "'The View' Fans Think Whoopi Goldberg Has 'Lost Her Mind'...",
      body: 'Full content here...',
      reactions: '1.4K',
      likes: '1.4K',
      comments: '4K',
    ),
    NewsModel(
      id: 102,
      publisherName: 'shefinds',
      publisherType: 'Partner publisher',
      publisherMeta: 'Partner publisher',
      totalFollowers: '833.3K',
      imageUrl: 'https://images.unsplash.com/photo-1534787238916-9ba6764efd4f?w=800',
      category: 'CYCLING',
      author: 'Staff',
      timeAgo: '3h',
      title: 'Professional Cyclist Breaks World Record in Time Trial Event...',
      body: 'Full content here...',
      reactions: '654',
      likes: '1.2K',
      comments: '876',
    ),
    NewsModel(
      id: 103,
      publisherName: 'ESPN',
      publisherType: 'Partner publisher',
      publisherMeta: 'Global Sports Network',
      totalFollowers: '5.1M',
      imageUrl: 'https://images.unsplash.com/photo-1546519638-68e109498ffc?w=800',
      category: 'BASKETBALL',
      author: 'ESPN Staff',
      timeAgo: '6h',
      title: 'NBA Playoffs: Underdog Team Clinches Surprising Victory...',
      body: 'Full content here...',
      reactions: '8.9K',
      likes: '12.4K',
      comments: '7.8K',
    ),
    NewsModel(
      id: 104,
      publisherName: 'Sports Illustrated',
      publisherType: 'Partner publisher',
      publisherMeta: 'Media Partner',
      totalFollowers: '2.3M',
      imageUrl: 'https://images.unsplash.com/photo-1574629810360-7efbbe195018?w=800',
      category: 'FOOTBALL',
      author: 'SI Staff',
      timeAgo: '10h',
      title: 'Transfer Window: Top Club Confirms Signing of Star Striker...',
      body: 'Full content here...',
      reactions: '5.2K',
      likes: '9.1K',
      comments: '4.4K',
    ),
  ].obs;

  // Food Tab
  final RxList<NewsModel> foodNews = <NewsModel>[
    NewsModel(
      id: 101,
      publisherName: 'shefinds',
      publisherType: 'Partner publisher',
      publisherMeta: 'Global Food Network',
      totalFollowers: '833.3K',
      imageUrl: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=800',
      category: 'OPINION',
      author: 'Nutrition Desk',
      timeAgo: '19h',
      title: "'The View' Fans Think Whoopi Goldberg Has 'Lost Her Mind'...",
      body: 'Full content here...',
      reactions: '1.4K',
      likes: '1.4K',
      comments: '4K',
    ),
    NewsModel(
      id: 102,
      publisherName: 'shefinds',
      publisherType: 'Partner publisher',
      publisherMeta: 'Partner publisher',
      totalFollowers: '833.3K',
      imageUrl: 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800',
      category: 'NUTRITION',
      author: 'Staff',
      timeAgo: '4h',
      title: '10 Superfoods That Nutritionists Swear By for Boosting Energy...',
      body: 'Full content here...',
      reactions: '1.1K',
      likes: '2.3K',
      comments: '1.5K',
    ),
    NewsModel(
      id: 103,
      publisherName: 'Bon Appétit',
      publisherType: 'Partner publisher',
      publisherMeta: 'Partner publisher',
      totalFollowers: '1.8M',
      imageUrl: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=800',
      category: 'RECIPE',
      author: 'Nutrition Desk',
      timeAgo: '7h',
      title: 'This One-Pan Mediterranean Chicken Recipe Will Completely Transform...',
      body: 'Full content here...',
      reactions: '3.2K',
      likes: '6.7K',
      comments: '2.1K',
    ),
    NewsModel(
      id: 104,
      publisherName: 'Food Network',
      publisherType: 'Partner publisher',
      publisherMeta: 'Top Publisher',
      totalFollowers: '3.4M',
      imageUrl: 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=800',
      category: 'TRENDS',
      author: 'Staff',
      timeAgo: '11h',
      title: "2025's Hottest Food Trends: From Fermented Delights to Globally-Inspired...",
      body: 'Full content here...',
      reactions: '2.8K',
      likes: '4.5K',
      comments: '3.0K',
    ),
  ].obs;

  // For You News List
  final RxList<NewsModel> forYouNews = <NewsModel>[
    NewsModel(
      id: 101,
      publisherName: 'shefinds',
      publisherType: 'Partner publisher.',
      publisherMeta: 'Beverly Hills, CA',
      totalFollowers: '833.3K',
      imageUrl: 'https://images.unsplash.com/photo-1495020689067-958852a7765e?w=800',
      category: 'OPINION',
      author: 'Staff',
      timeAgo: '19h',
      title: "'The View' Fans Think Whoopi Goldberg Has 'Lost Her Mind'...",
      body: 'Full news content here...',
      reactions: '1.4K',
      likes: '1.4K',
      comments: '4K',
    ),
    NewsModel(
      id: 999999,
      publisherName: 'Bingo Fun',
      publisherImageUrl: 'https://images.unsplash.com/photo-1587300003388-59208cc962cb?w=800',
      publisherMeta: 'Sponsored',
      publisherType: 'Ad',
      totalFollowers: '1.2M',
      timeAgo: 'Now',
      title: "Bingo Fun Ad - Play and Win exciting prizes today!",
      imageUrl: 'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=800',
      category: 'Promotion',
      author: 'Bingo Team',
      body: 'This is an advertisement content...',
      likes: '10K',
      comments: '500',
      shares: '2K',
      reactions: '5.4K',
      isVerified: true,
      videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    ),
    NewsModel(
      id: 102,
      publisherName: 'Variety',
      publisherType: 'Partner publisher.',
      publisherMeta: 'Beverly Hills, CA',
      totalFollowers: '1.2M',
      imageUrl: 'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=800',
      category: 'ENTERTAINMENT',
      author: 'Staff',
      timeAgo: '3h',
      title: 'Grammy-Winning Artist Announces Surprise Album Drop and World Tour Starting Next Month',
      body: 'Full news content here...',
      reactions: '3.4K',
      likes: '5.6K',
      comments: '2.2K',
    ),
    NewsModel(
      id: 103,
      publisherName: 'ESPN',
      publisherType: 'Partner publisher.',
      publisherMeta: 'Los Angeles, CA',
      totalFollowers: '5.1M',
      imageUrl: 'https://images.unsplash.com/photo-1546519638-68e109498ffc?w=800',
      category: 'SPORTS',
      timeAgo: '6h',
      author: 'Entertainment Desk',
      title: 'NBA Playoffs: Underdog Team Clinches Surprising Victory in Game 7 Overtime Thriller',
      body: 'Full news content here...',
      reactions: '8.9K',
      likes: '12.4K',
      comments: '7.8K',
    ),
    NewsModel(
      id: 104,
      publisherName: 'Healthline',
      publisherType: 'Partner publisher.',
      publisherMeta: 'New York, NY',
      totalFollowers: '2.7M',
      imageUrl: 'https://images.unsplash.com/photo-1476480862126-209bfaa8edc8?w=800',
      category: 'HEALTH',
      author: 'Sports Desk',
      timeAgo: '9h',
      title: 'New Study Reveals the Surprising Link Between Sleep Quality and Long-Term Cardiovascular Health',
      body: 'Full news content here...',
      reactions: '4.3K',
      likes: '7.2K',
      comments: '3.1K',
    ),
  ].obs;

  // Local Clips List
  final RxList<ClipModel> forYouClips = <ClipModel>[
    const ClipModel(
      title: 'Play Time',
      subtitle: 'Love for animals',
      imageUrl: 'https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=400',
    ),
    const ClipModel(
      title: 'City Life',
      subtitle: 'Urban stories',
      imageUrl: 'https://images.unsplash.com/photo-1477959858617-67f85cf4f1df?w=400',
    ),
    const ClipModel(
      title: 'Nature Walk',
      subtitle: 'Explore outdoors',
      imageUrl: 'https://images.unsplash.com/photo-1448375240586-882707db888b?w=400',
    ),
  ].obs;

  // Health Tab
  final RxList<NewsModel> healthNews = <NewsModel>[
    NewsModel(
      id: 101,
      publisherName: 'shefinds',
      publisherType: 'Partner publisher',
      publisherMeta: 'Partner publisher',
      totalFollowers: '833.3K',
      imageUrl: 'https://images.unsplash.com/photo-1476480862126-209bfaa8edc8?w=800',
      category: 'OPINION',
      author: 'Health Desk',
      timeAgo: '19h',
      title: "'The View' Fans Think Whoopi Goldberg Has 'Lost Her Mind'...",
      body: 'Full content here...',
      reactions: '1.4K',
      likes: '1.4K',
      comments: '4K',
    ),
    NewsModel(
      id: 102,
      publisherName: 'shefinds',
      publisherType: 'Partner publisher',
      publisherMeta: 'Partner publisher',
      totalFollowers: '833.3K',
      imageUrl: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800',
      category: 'FITNESS',
      author: 'Fitness Coach',
      timeAgo: '2h',
      title: 'Morning Running Groups Are Changing Lives...',
      body: 'Full content here...',
      reactions: '2.1K',
      likes: '3.8K',
      comments: '1.9K',
    ),
    NewsModel(
      id: 103,
      publisherName: 'Healthline',
      publisherType: 'Partner publisher',
      publisherMeta: 'Health Partner',
      totalFollowers: '2.7M',
      imageUrl: 'https://images.unsplash.com/photo-1505576399279-565b52d4ac71?w=800',
      category: 'WELLNESS',
      author: 'WebMD Staff',
      timeAgo: '5h',
      title: 'New Study Reveals the Surprising Link Between Sleep Quality...',
      body: 'Full content here...',
      reactions: '4.3K',
      likes: '7.2K',
      comments: '3.1K',
    ),
    NewsModel(
      id: 104,
      publisherName: 'WebMD',
      publisherType: 'Partner publisher',
      publisherMeta: 'Verified Medical News',
      totalFollowers: '1.9M',
      imageUrl: 'https://images.unsplash.com/photo-1490645935967-10de6ba17061?w=800',
      category: 'NUTRITION',
      author: 'Dr. Smith',
      timeAgo: '9h',
      title: 'Doctors Are Now Recommending This Simple Daily Habit...',
      body: 'Full content here...',
      reactions: '6.1K',
      likes: '9.4K',
      comments: '5.5K',
    ),
  ].obs;

  // Weather Tab
  final RxList<NewsModel> weatherNews = <NewsModel>[
    NewsModel(
      id: 101,
      publisherName: 'shefinds',
      publisherType: 'Partner publisher',
      publisherMeta: 'Partner publisher',
      totalFollowers: '833.3K',
      imageUrl: 'https://images.unsplash.com/photo-1601297183305-6df142704ea2?w=800',
      category: 'OPINION',
      author: 'Staff',
      timeAgo: '19h',
      title: "'The View' Fans Think Whoopi Goldberg Has 'Lost Her Mind' After She Suggests Donald Trump's Iran War Is A Distraction From Nancy Guthrie...",
      body: 'Full news content here...',
      reactions: '1.4K',
      likes: '1.4K',
      comments: '4K',
    ),
    NewsModel(
      id: 102,
      publisherName: 'Weather Channel',
      publisherType: 'Partner publisher',
      publisherMeta: 'Global Weather Network',
      totalFollowers: '3.2M',
      imageUrl: 'https://images.unsplash.com/photo-1561484930-998b6a7b22e8?w=800',
      category: 'FORECAST',
      author: 'Meteorologist Desk',
      timeAgo: '4h',
      title: 'El Niño Pattern Expected to Bring Above-Average Temperatures to Much of the Country Through Summer',
      body: 'Full news content here...',
      reactions: '2.3K',
      likes: '3.9K',
      comments: '1.4K',
    ),
    NewsModel(
      id: 103,
      publisherName: 'AccuWeather',
      publisherType: 'Partner publisher',
      publisherMeta: 'Climate Expert Partner',
      totalFollowers: '1.5M',
      imageUrl: 'https://images.unsplash.com/photo-1530908295418-a12e326966ba?w=800',
      category: 'CLIMATE',
      author: 'Climate Desk',
      timeAgo: '8h',
      title: 'Record-Breaking Heat Wave Sweeps Across Southern States — Tips for Staying Cool and Healthy During Extreme Temperatures',
      body: 'Full news content here...',
      reactions: '4.7K',
      likes: '6.8K',
      comments: '3.2K',
    ),
  ].obs;

  // Weather Forecast Data
  final RxList<Map<String, String>> hourlyForecast = <Map<String, String>>[
    {'time': 'Now', 'icon': 'assets/icons/weather_cloudy.png', 'temp': '30°'},
    {'time': '03AM', 'icon': 'assets/icons/weather_night.png', 'temp': '30°'},
    {'time': '04AM', 'icon': 'assets/icons/weather_night.png', 'temp': '30°'},
    {'time': '05AM', 'icon': 'assets/icons/weather_cloudy.png', 'temp': '30°'},
    {'time': '06AM', 'icon': 'assets/icons/weather_storm.png', 'temp': '30°'},
  ].obs;

  final RxList<Map<String, String>> dailyForecast = <Map<String, String>>[
    {
      'time': 'Today',
      'icon': 'assets/icons/weather_cloudy.png',
      'temp': '30°/40°'
    },
    {
      'time': 'Mon',
      'icon': 'assets/icons/weather_sunny.png',
      'temp': '28°/38°'
    },
    {'time': 'Tue', 'icon': 'assets/icons/sunrise.png', 'temp': '25°/35°'},
    {
      'time': 'Wed',
      'icon': 'assets/icons/weather_storm.png',
      'temp': '22°/32°'
    },
    {
      'time': 'Thu',
      'icon': 'assets/icons/weather_sunny.png',
      'temp': '27°/37°'
    },
  ].obs;

  final RxList<Map<String, dynamic>> suggestedPeople = [
    {
      'name': 'Catherine',
      'subtitle': 'Daily rising star',
      'isFollowing': false,
      'image': 'assets/images/user1.png'
    },
    {
      'name': 'John Doe',
      'subtitle': 'Tech Enthusiast',
      'isFollowing': false,
      'image': 'assets/images/user2.png'
    },
    {
      'name': 'Amalia Rose',
      'subtitle': 'Flutter Developer',
      'isFollowing': false,
      'image': 'assets/images/user3.png'
    },
  ].obs;

}
