import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';

class ManageLocationView extends StatefulWidget {
  const ManageLocationView({super.key});

  @override
  State<ManageLocationView> createState() => _ManageLocationViewState();
}

class _ManageLocationViewState extends State<ManageLocationView> {
  final TextEditingController _searchController = TextEditingController();
  final MapController _mapController = MapController();

  // Default: Dhaka, Bangladesh
  final LatLng _center = const LatLng(24.0, 90.0);

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // ── Map ──────────────────────────────
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _center,
              initialZoom: 7,
            ),
            children: [
              TileLayer(
                urlTemplate:
                'https://cartodb-basemaps-{s}.global.ssl.fastly.net/dark_all/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c', 'd'],
                userAgentPackageName: 'com.example.newsbreak',
              ),
            ],
          ),

          // ── Top search bar ───────────────────
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child:Icon(Icons.arrow_back_ios, color:AppColors.textOnDark, size: 20),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: const Color(0xFF121212),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        controller: _searchController,
                        style: AppTextStyles.caption,
                        decoration:InputDecoration(
                          hintText: 'Enter an address or zip code',
                          hintStyle: AppTextStyles.overline.copyWith(fontSize: 14),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                          suffixIcon: Icon(Icons.search,color: AppColors.textOnDark, size: 20),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF343434),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child:Text('Skip',
                          style:AppTextStyles.bodyMedium),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Right side buttons ───────────────
          Positioned(
            right: 12,
            bottom: 160,
            child: Column(
              children: [
                _mapButton(Icons.bookmark_border, () {}),
                const SizedBox(height: 8),
                _mapButton(Icons.info_outline, () {}),
                const SizedBox(height: 8),
                _mapButton(Icons.my_location, () {
                  _mapController.move(_center, 7);
                }),
              ],
            ),
          ),

          // ── Bottom Ad banner ─────────────────
          Positioned(
            bottom: 32,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF444447),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/images/publisher.png',
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('FoodRadar',
                           style: AppTextStyles.bodyMedium),
                            GestureDetector(
                              onTap: () {},
                              child: const Icon(Icons.close, color: Colors.grey, size: 20),
                            ),
                          ],
                        ),

                        const SizedBox(height: 6),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Text('Find Free Food Near You Instantly. 100% Free, No Ads.',
                          style:AppTextStyles.overline,
                          maxLines: 2,
                                  overflow: TextOverflow.ellipsis
                              ),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: const Color(0xFF242424),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                              child: Text('Open',
                                  style: AppTextStyles.bodyMedium.copyWith(color: Color(0xFF242424))),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
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