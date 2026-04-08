import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AdVideoCard extends StatefulWidget {
  const AdVideoCard({super.key});

  @override
  State<AdVideoCard> createState() => _AdVideoCardState();
}

class _AdVideoCardState extends State<AdVideoCard> {
  late VideoPlayerController _controller;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
    )..initialize().then((_) {
      setState(() => _initialized = true);
      _controller.setLooping(true);
      _controller.play();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 42,
                    height: 42,
                    color: Colors.deepPurple,
                    child: const Icon(Icons.music_note, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Bingo Fun',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600)),
                      Text('Ad',
                          style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ),
                const Icon(Icons.close, color: Colors.grey, size: 18),
              ],
            ),
          ),

          // Video Player
          Stack(
            children: [
              ClipRRect(
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: _initialized
                      ? VideoPlayer(_controller)
                      : Container(color: Colors.grey.shade900,
                      child: const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      )),
                ),
              ),

              // Duration
              if (_initialized)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: ValueListenableBuilder(
                      valueListenable: _controller,
                      builder: (_, value, __) => Text(
                        _formatDuration(value.duration - value.position),
                        style: const TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ),
                  ),
                ),

              // Play/Pause + Mute
              if (_initialized)
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: ValueListenableBuilder(
                    valueListenable: _controller,
                    builder: (_, value, __) => Row(
                      children: [
                        GestureDetector(
                          onTap: () => setState(() {
                            value.isPlaying
                                ? _controller.pause()
                                : _controller.play();
                          }),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Icon(
                              value.isPlaying ? Icons.pause : Icons.play_arrow,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () => setState(() {
                            _controller.setVolume(value.volume > 0 ? 0 : 1);
                          }),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Icon(
                              value.volume > 0
                                  ? Icons.volume_up
                                  : Icons.volume_off,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}