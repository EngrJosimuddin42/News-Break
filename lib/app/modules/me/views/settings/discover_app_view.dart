import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiscoverAppView extends StatelessWidget {
  const DiscoverAppView({super.key});

  static const List<Map<String, String>> _apps = [
    {
      'name': 'CrimeRadar',
      'subtitle': 'Crime map & police audio',
      'imageUrl': 'https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=100',
    },
    {
      'name': 'CrimeRadar',
      'subtitle': 'Crime map & police audio',
      'imageUrl': 'https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=100',
    },
    {
      'name': 'CrimeRadar',
      'subtitle': 'Crime map & police audio',
      'imageUrl': 'https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=100',
    },
    {
      'name': 'CrimeRadar',
      'subtitle': 'Crime map & police audio',
      'imageUrl': 'https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=100',
    },
    {
      'name': 'CrimeRadar',
      'subtitle': 'Crime map & police audio',
      'imageUrl': 'https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=100',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios,
              color: Colors.white, size: 18),
        ),
        title: const Text('Discover App',
            style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemCount: _apps.length,
        separatorBuilder: (_, __) =>
        const Divider(color: Colors.white12, height: 1),
        itemBuilder: (_, i) {
          final app = _apps[i];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 8),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                app['imageUrl']!,
                width: 56,
                height: 56,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 56,
                  height: 56,
                  color: Colors.grey[800],
                  child: const Icon(Icons.apps,
                      color: Colors.white, size: 28),
                ),
              ),
            ),
            title: Text(app['name']!,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600)),
            subtitle: Text(app['subtitle']!,
                style: const TextStyle(
                    color: Colors.grey, fontSize: 12)),
            onTap: () {},
          );
        },
      ),
    );
  }
}