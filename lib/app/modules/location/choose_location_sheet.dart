import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import 'package:news_break/app/widgets/bottom_sheet_handle.dart';
import '../../controllers/home_controller.dart';
import 'manage_location_view.dart';

class ChooseLocationSheet extends GetView<HomeController> {
  const ChooseLocationSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.80,
        decoration: const BoxDecoration(
          color: Color(0xFF252525),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        child: Column(
          children: [
            // Handle bar
            const BottomSheetHandle(),

            const SizedBox(height: 24),

            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(() => !controller.isSearching.value
                      ? GestureDetector(
                    onTap: () {
                      controller.confirmLocationSelection();
                      Get.back();
                    },
                    child: Text('Done', style: AppTextStyles.bodySmall.copyWith(color: AppColors.textGreen)))
                      : const SizedBox.shrink()),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Container( height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF444444),
                        border: Border.all(color: Color(0xFF6B6B6B)),
                        borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        controller: controller.searchController,
                        style: AppTextStyles.caption,
                        onChanged: (val) => controller.searchQuery.value = val,
                        onTap: () => controller.isSearching.value = true,
                        decoration: InputDecoration(
                          hintText: 'Search city or zip code',
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                          prefixIcon: Icon(Icons.search, color: Colors.grey, size: 20),
                          border: InputBorder.none,
                          suffixIconConstraints: const BoxConstraints(minHeight: 20, minWidth: 20),
                          suffixIcon: _ClearButton(
                            controller: controller.searchController,
                            onClear: () => controller.searchQuery.value = ''),
                          contentPadding: EdgeInsets.symmetric(vertical: 10))))),
                  Obx(() => controller.isSearching.value
                      ? Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: GestureDetector(
                      onTap: () { controller.clearSearch();
                        FocusScope.of(context).unfocus();
                      },
                      child: Text('Cancel', style: AppTextStyles.bodySmall.copyWith(color: AppColors.textGreen))))
                      : const SizedBox.shrink()),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Content
            Expanded(
              child: Obx(() => controller.selectedLocation.value != null && !controller.isSearching.value
                  ? _buildSelectedState()
                  : controller.searchQuery.value.isNotEmpty
                  ? _buildSearchResults()
                  : _buildDefaultState()),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildDefaultState() {
    final controller = Get.find<HomeController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => GestureDetector(
            onTap: controller.isLocationLoading.value
                ? null
                : () => controller.detectGPSLocation(),
            child: Row(
              children: [
                controller.isLocationLoading.value
                    ? const SizedBox(width: 32, height: 32,
                  child: Padding(
                    padding: EdgeInsets.all(6.0),
                    child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.textGreen)))
                    : Image.asset('assets/icons/send1.png', width: 32, height: 32),
                const SizedBox(width: 8),
                Text(controller.isLocationLoading.value
                      ? 'Detecting Location...'
                      : 'Your GPS location',
                  style: AppTextStyles.labelSmall.copyWith(color: AppColors.textGreen)),
              ],
            ),
          )),

          const SizedBox(height: 16),
          Row(
            children: [
              Text("Couldn't load your location", style: AppTextStyles.caption.copyWith(color: AppColors.textOnDark)),
              const Spacer(),
              GestureDetector(
                onTap: () => controller.detectGPSLocation(),
                child: Text('Try Again', style: AppTextStyles.bodySmall.copyWith(color: AppColors.textGreen))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    final results = controller.filteredLocations;
    if (results.isEmpty) {
      return const Center(
        child: Text('No results found', style: TextStyle(color: Colors.grey, fontSize: 14)));
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: results.length,
      itemBuilder: (_, i) {
        final loc = results[i];
        return ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(loc['city']!, style: AppTextStyles.caption),
          subtitle: Text(loc['zip']!, style: AppTextStyles.overline),
          onTap: () {
            controller.selectLocationFromSearch(loc);
            FocusScope.of(Get.context!).unfocus();
          },
        );
      },
    );
  }

  Widget _buildSelectedState() {
    final loc = controller.selectedLocation.value;
    if (loc == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search bar (empty)
          const SizedBox(height: 8),

          // Primary Location
          Text('Primary Location', style:AppTextStyles.overline),
          const SizedBox(height: 10),

          Row(
            children: [
              Image.asset('assets/icons/circle_home.png'),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(loc['city']!, style: AppTextStyles.labelMedium.copyWith(fontWeight: FontWeight.w700)),
                Text(loc['zip']!, style: AppTextStyles.overline),
                    GestureDetector(
                      onTap: () {
                        controller.selectedLocation.value = null;
                        controller.tempLocation.value = null;
                      },
                      child:Text('Change', style: AppTextStyles.overline.copyWith(decoration: TextDecoration.underline,decorationColor: AppTextStyles.overline.color))),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => const ManageLocationView(), arguments: loc);
                },
                child: Text('View', style: AppTextStyles.buttonOutline.copyWith(color: AppColors.textGreen))),
            ],
          ),

          const SizedBox(height: 24),

          // Location You Follow
          Text('Location You Follow', style:AppTextStyles.overline),
          const SizedBox(height: 10),
          Text("You don't follow any other locations. Add more locations to see news in For you from where your friends or family live, or other places you are interested in.",
            style: AppTextStyles.overline.copyWith(color: Color(0xFFCBCBCB))),
          const SizedBox(height: 18),
          GestureDetector(
              onTap: () => Get.to(() => const ManageLocationView()),
              child: Text('Add more locations', style:AppTextStyles.bodySmall.copyWith(color: AppColors.textGreen))),
        ],
      ),
    );
  }
}

// Clear button widget
class _ClearButton extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onClear;
  const _ClearButton({required this.controller, required this.onClear});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, value, child) {
        return value.text.isNotEmpty
            ? GestureDetector(
          onTap: () {
            controller.clear();
            onClear();
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                color: const Color(0xFF444444),
                border: Border.all(color: AppColors.textTertiary),
                shape: BoxShape.circle),
            child: const Icon(Icons.close_rounded, color: AppColors.textTertiary, size: 12),
          ),
        )
            : const SizedBox.shrink();
      },
    );
  }
}