import 'package:flutter/material.dart';
import 'help_widgets.dart';

class WhoAreWeView extends StatelessWidget {
  const WhoAreWeView({super.key});

  static const List<Map<String, String>> _team = [
    {
      'name': 'Wynston Alberts',
      'role': 'Trust & Safety',
      'imageUrl':
      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200',
    },
    {
      'name': 'Wynston Alberts',
      'role': 'Trust & Safety',
      'imageUrl':
      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HelpWidgets.helpAppBar('Help Center'),
      body: Column(
        children: [
          const HelpTabBar(),
          const Divider(height: 1, color: Color(0xFFEEEEEE)),
          Expanded(
            child: ListView(
              children: [
                // About Us
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HelpWidgets.redChip('About Us'),
                      const SizedBox(height: 8),
                      const Text('We\'er NewsBreak',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w700)),
                      const SizedBox(height: 6),
                      const Text(
                        'Lorem ipsum dolor sit amet consectetur. Lectus bibendum eu mauris praesent eu iaculis. Elit ac in quam purus.',
                        style: TextStyle(color: Colors.black54, fontSize: 13, height: 1.5),
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          'https://images.unsplash.com/photo-1522071820081-009f0129c71c?w=600',
                          height: 160,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            height: 160, color: Colors.grey[200],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Our Story
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HelpWidgets.redChip('Our Story'),
                      const SizedBox(height: 8),
                      const Text('We\'er NewsBreak',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w700)),
                      const SizedBox(height: 6),
                      const Text(
                        'Lorem ipsum dolor sit amet consectetur. Lectus bibendum eu mauris praesent eu iaculis. Elit ac in quam purus.',
                        style: TextStyle(color: Colors.black54, fontSize: 13, height: 1.5),
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          'https://images.unsplash.com/photo-1517245386807-bb43f82c33c4?w=600',
                          height: 160,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            height: 160, color: Colors.grey[200],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Team
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Some people we\'d like\nyou to meet',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w700)),
                ),

                ..._team.map((member) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 36,
                        backgroundImage:
                        NetworkImage(member['imageUrl']!),
                      ),
                      const SizedBox(height: 8),
                      Text(member['name']!,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                      Text(member['role']!,
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 12)),
                      const SizedBox(height: 6),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          'Lorem ipsum dolor sit amet consectetur. Pulvinar vestibulum ipsum nulla id. Volutpat mattis et integer porttitor. Neque non tempor ante bibendum ipsum non.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                              height: 1.5),
                        ),
                      ),
                    ],
                  ),
                )),

                HelpWidgets.helpFooter(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
