import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';

class DiscoverAppView extends StatelessWidget {
  const DiscoverAppView({super.key});

  static const List<Map<String, String>> _apps = [
    {
      'name': 'WeatherNow',
      'subtitle': 'Live radar & storm alerts',
      'imageUrl': 'https://images.unsplash.com/photo-1592210454359-9043f067919b?w=200', // Weather/Storm
    },
    {
      'name': 'TrafficWatch',
      'subtitle': 'Real-time road conditions',
      'imageUrl': 'https://images.unsplash.com/photo-1545147986-a9d6f210df77?w=200', // Traffic/City Road
    },
    {
      'name': 'EcoAlert',
      'subtitle': 'Air quality & pollution index',
      'imageUrl': 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=200', // Nature/Air
    },
    {
      'name': 'EmergencyPlus',
      'subtitle': 'Quick access to emergency help',
      'imageUrl': 'https://images.unsplash.com/photo-1587393820429-aa214cf0ede3?w=200', // Ambulance/Health
    },
    {
      'name': 'CityEvents',
      'subtitle': 'Local events & festivals',
      'imageUrl': 'https://images.unsplash.com/photo-1492684223066-81342ee5ff30?w=200', // Events/Festival
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
          child:Icon(Icons.arrow_back_ios, color: AppColors.surface, size: 20),
        ),
        title:Text('Discover App',
            style: AppTextStyles.displaySmall),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemCount: _apps.length,
        separatorBuilder: (_, __) =>
        const Divider(color: Color(0xFF323232), height: 1),
        itemBuilder: (_, i) {
          final app = _apps[i];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 8),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                app['imageUrl']!,
                width: 56,
                height: 56,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 56,
                  height: 56,
                  color: Colors.grey[800],
                  child: const Icon(Icons.apps, color: Colors.white, size: 28),
                ),
              ),
            ),
            title: Text(app['name']!,
                style:AppTextStyles.headlineMedium),
            subtitle: Text(app['subtitle']!,
                style:AppTextStyles.caption),
            onTap: () {},
          );
        },
      ),
    );
  }
}