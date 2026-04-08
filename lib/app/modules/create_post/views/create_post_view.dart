import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../controllers/create_post_controller.dart';

class CreatePostView extends GetView<CreatePostController> {
  const CreatePostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          onPressed: controller.onBack,
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.white, size: 18),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
            child: ElevatedButton(
              onPressed: controller.onPost,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF333333),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: Text('Post', style: AppTextStyles.bodyMedium),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Share your thoughts',
                style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary)),
            const SizedBox(height: 16),

            // Media picker
            GestureDetector(
              onTap: controller.onAddMedia,
              child: Container(
                width: 75,
                height: 67,
                decoration: BoxDecoration(
                  color: const Color(0xFF444444),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.add, color: AppColors.white, size: 28),
              ),
            ),
            SizedBox(height: 32),
            // Tag location
            InkWell(
              onTap: controller.onTagLocation,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.white12),
                    bottom: BorderSide(color: Colors.white12),
                  ),
                ),
                child: Row(
                  children: [
                    Image.asset('assets/icons/tag_location.png',
                        width: 20, height: 20),
                    const SizedBox(width: 10),
                    Text('Tag Location',
                        style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary)),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_ios,
                        color: AppColors.textSecondary, size: 14),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TagLocationSheet extends StatelessWidget {
  const TagLocationSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();

    final locations = [
      {'city': 'New York City', 'zip': 'NY, 100002'},
      {'city': 'Los Angeles', 'zip': 'CA, 90001'},
      {'city': 'Chicago', 'zip': 'IL, 60601'},
      {'city': 'Houston', 'zip': 'TX, 77001'},
      {'city': 'San Francisco', 'zip': 'CA, 94105'},
    ];

    return Container(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      width: Get.width,
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Color(0xFF1A1A1A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(4),
            ),
          ),

          // Search bar
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2A2A),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: searchController,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      decoration: const InputDecoration(
                        hintText: 'Find Location',
                        hintStyle: TextStyle(
                            color: Colors.white54, fontSize: 14),
                        prefixIcon: Icon(Icons.search,
                            color: Colors.white54, size: 18),
                        border: InputBorder.none,
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.blue, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),

          // Location list
          Expanded(
            child: ListView.builder(
              itemCount: locations.length,
              itemBuilder: (_, i) {
                final loc = locations[i];
                return ListTile(
                  onTap: () => Get.back(result: loc),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  title: Text(
                    loc['city']!,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    loc['zip']!,
                    style: const TextStyle(
                        color: Colors.white54, fontSize: 12),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}