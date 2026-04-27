import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';

import '../../../controllers/me/settings/discover_app_controller.dart';
import '../../../widgets/publisher_avatar.dart';

class DiscoverAppView extends StatelessWidget {
  const DiscoverAppView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DiscoverAppController());

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child:Icon(Icons.arrow_back_ios, color: AppColors.surface, size: 20)),
        title:Text('Discover App', style: AppTextStyles.displaySmall),
        centerTitle: true),

        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator(color: AppColors.linkColor));
          }

          return ListView.separated(
            padding: const EdgeInsets.only(top: 8),
            itemCount: controller.appsList.length,
            separatorBuilder: (context, index) => const Divider(color: Color(0xFF323232), height: 1),
            itemBuilder: (_, i) {
              final app = controller.appsList[i];

              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),

                leading: PublisherAvatar.fromUrl(
                  imageUrl: app['imageUrl'] ?? '',
                  name: app['name'] ?? 'App',
                  size: 56.0,
                  shape: BoxShape.rectangle),
               title: Text(app['name']!, style:AppTextStyles.headlineMedium),
            subtitle: Text(app['subtitle']!, style:AppTextStyles.caption),
            onTap: () {},
          );
        },
        );
    }),
  );
}
}