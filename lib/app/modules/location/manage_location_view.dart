import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../controllers/location/manage_location_controller.dart';
import '../../models/news_model.dart';
import '../../widgets/publisher_avatar.dart';

class ManageLocationView extends StatelessWidget {
  const ManageLocationView({super.key});


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ManageLocationController());
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [

          // Map
          Obx(() => FlutterMap(
            mapController: controller.mapController,
            options: MapOptions(
              initialCenter: controller.center,
              initialZoom: 7,
              onTap: (tapPosition, point) => controller.isLocationSelected.value = true),
            children: [
              TileLayer(
                urlTemplate: controller.currentMapUrl.value,
                subdomains: const ['a', 'b', 'c', 'd'],
                userAgentPackageName: 'com.news_break.app',
              ),
            ],
          )),

          // Top search bar
          Positioned(
            top: MediaQuery.of(context).padding.top + 8, left: 0, right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child:Icon(Icons.arrow_back_ios, color:AppColors.textOnDark, size: 20)),

                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(height: 44,
                      decoration: BoxDecoration(
                        color: const Color(0xFF121212),
                        borderRadius: BorderRadius.circular(8)),
                      child: TextField(
                        controller: controller.searchController,
                        style: AppTextStyles.caption,
                        onSubmitted: (_) => controller.searchLocation(),
                        textInputAction: TextInputAction.search,
                        decoration:InputDecoration(
                          hintText: 'Enter an address or zip code',
                          hintStyle: AppTextStyles.overline.copyWith(fontSize: 14),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search, color:AppColors.textOnDark),
                            onPressed: controller.searchLocation))))),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF343434),
                        borderRadius: BorderRadius.circular(20)),
                      child:Text('Skip', style:AppTextStyles.bodyMedium))),
                ],
              ),
            ),
          ),

          //Right side buttons
          Positioned(right: 12, bottom: 95,
            child: Column(
              children: [

                _mapButton(Icons.bookmark_border, () => controller.saveBookmark()),

                const SizedBox(height: 8),

                _mapButton(Icons.info_outline, () {
                  Get.defaultDialog(
                    title: "Map Info",
                    middleText: "Use the search bar to find food points near you.",
                    backgroundColor: const Color(0xFF2C2C2E),
                    titleStyle: const TextStyle(color: Colors.white),
                    middleTextStyle: const TextStyle(color: Colors.white70));
                }),
                const SizedBox(height: 8),

                _mapButton(Icons.my_location, () => controller.resetToCurrentLocation()),

                const SizedBox(height: 8),

            _mapButton(Icons.layers_outlined, controller.toggleMapStyle)
              ],
            ),
          ),


          // Bottom Ad banner
          Obx(() => controller.isBannerVisible.value
              ? Positioned(bottom: 32, left: 16, right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF444447),
                borderRadius: BorderRadius.circular(12)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PublisherAvatar.fromNews(
                    news: NewsModel(
                      id: 1,
                      author: '',
                      category: '',
                      imageUrl: '',
                      publisherMeta: '',
                      timeAgo: '',
                      publisherName:'',
                      title: controller.adBanner.value.title,
                      body: controller.adBanner.value.body,
                      publisherImageUrl: controller.adBanner.value.imageUrl,
                    ),
                    size: 48),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(controller.adBanner.value.title, style: AppTextStyles.bodyMedium),
                            GestureDetector(
                              onTap: () {
                                controller.isBannerVisible.value = false;
                              },
                              child: const Icon(Icons.close, color: Colors.grey, size: 20),
                            ),
                          ],
                        ),

                        const SizedBox(height: 6),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Text(controller.adBanner.value.body, style:AppTextStyles.overline,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis)),
                            const SizedBox(width: 8),
                            ElevatedButton(
                                onPressed: () {
                                  controller.openExternalLink();
                                },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: const Color(0xFF242424),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                              child: Text('Open', style: AppTextStyles.bodyMedium.copyWith(color: Color(0xFF242424)))),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
              : const SizedBox.shrink())
        ],
      ),
    );
  }

  Widget _mapButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFF2C2C2E),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}