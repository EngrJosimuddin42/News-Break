import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import 'package:news_break/app/widgets/publisher_avatar.dart';
import 'package:video_player/video_player.dart';
import '../../../controllers/ad_video_controller.dart';
import '../../../controllers/home_controller.dart';
import '../../../models/news_model.dart';

class AdVideoCard extends StatelessWidget {
  final NewsModel news;
  const AdVideoCard({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    final adController = Get.put(AdVideoController(), tag: news.id.toString());

    if (!adController.isInitialized.value) {
      adController.initializeVideo(news.videoUrl ?? 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4');
    }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color:Color(0xFF252525),
        borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          _buildVideoPlayer(adController),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  // Header Section
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
      child: Row(
        children: [
          PublisherAvatar(news: news),
          const SizedBox(width: 10),
          _buildPublisherInfo(),
          _buildCloseButton(),
        ],
      ),
    );
  }
  
  Widget _buildPublisherInfo() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(news.publisherName, style: AppTextStyles.bodyMedium),
          Text('Ad', style:AppTextStyles.overline),
        ],
      ),
    );
  }

  Widget _buildCloseButton() {
    return GestureDetector(
      onTap: () => Get.find<HomeController>().hideNews(news),
      child: const Icon(Icons.close, color: Color(0xFF6C6C6C), size: 20),
    );
  }

  // Video Section
  Widget _buildVideoPlayer(AdVideoController adController) {
    return Obx(() => Stack(
      children: [
        ClipRRect(
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: adController.isInitialized.value
                ? VideoPlayer(adController.videoController)
                : const Center(child: CircularProgressIndicator(color: Colors.white)))),
        if (adController.isInitialized.value) ...[
          _buildDurationTag(adController),
          _buildControls(adController),
        ]
      ],
    ));
  }

  Widget _buildDurationTag(AdVideoController adController) {
    return Positioned(
      top: 8,
      right: 8,
        child: ValueListenableBuilder(
          valueListenable: adController.videoController,
          builder: (_, value, __) => Text(
            adController.formatDuration(value.duration - value.position),
            style:AppTextStyles.labelMedium)),
    );
  }

  Widget _buildControls(AdVideoController adController) {
    return Positioned(
      bottom: 8,
      left: 8,
      child: Row(
        children: [
          // Play/Pause Button
          GestureDetector(
            onTap: adController.togglePlay,
            child: Icon(
              adController.isPlaying.value ? Icons.pause : Icons.play_arrow, color: Colors.white, size: 20)),
          const SizedBox(width: 12),
          // Mute/Unmute Button
          GestureDetector(
            onTap: adController.toggleMute,
            child: Icon(
              adController.isMuted.value ? Icons.volume_off : Icons.volume_up, color: Colors.white, size: 20)),
        ],
      ),
    );
  }
}