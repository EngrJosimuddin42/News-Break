import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';

import '../../home/controllers/home_controller.dart';
import 'manage_location_view.dart';

class ChooseLocationSheet extends StatefulWidget {
  const ChooseLocationSheet({super.key});

  @override
  State<ChooseLocationSheet> createState() => _ChooseLocationSheetState();
}

class _ChooseLocationSheetState extends State<ChooseLocationSheet> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  String _query = '';
  Map<String, String>? _selectedLocation;
  Map<String, String>? _tempLocation;

  static const List<Map<String, String>> _allLocations = [
    {'city': 'New York City', 'zip': 'NY, 100002'},
    {'city': 'New York City', 'zip': 'NY, 100009'},
    {'city': 'New York City', 'zip': 'NY, 100009'},
    {'city': 'Los Angeles', 'zip': 'CA, 90001'},
    {'city': 'Chicago', 'zip': 'IL, 60601'},
    {'city': 'Houston', 'zip': 'TX, 77001'},
    {'city': 'San Francisco', 'zip': 'CA, 94105'},
  ];

  List<Map<String, String>> get _filteredLocations {
    if (_query.isEmpty) return [];
    return _allLocations
        .where((loc) =>
    loc['city']!.toLowerCase().contains(_query.toLowerCase()) ||
        loc['zip']!.toLowerCase().contains(_query.toLowerCase()))
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.80,
      decoration: const BoxDecoration(
        color: Color(0xFF252525),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          const SizedBox(height: 12),
          Container(
            width: 36, height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[600],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 12),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 40),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    if (_tempLocation != null) {
                      Get.find<HomeController>().setLocation(_tempLocation!);
                    }
                    Navigator.pop(context);
                  },
                  child:Text('Done',
                      style:AppTextStyles.bodySmall.copyWith(color: AppColors.textGreen)),
                ),
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
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFF444444),
                      border: Border.all(color: Color(0xFF6B6B6B)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _searchController,
                      style: AppTextStyles.caption,
                      onChanged: (val) =>
                          setState(() => _query = val),
                      onTap: () =>
                          setState(() => _isSearching = true),
                      decoration: const InputDecoration(
                        hintText: 'Search city or zip code',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                        prefixIcon: Icon(Icons.search, color: Colors.grey, size: 20),
                        border: InputBorder.none,
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 10),
                        suffixIcon: _ClearButton(),
                      ),
                    ),
                  ),
                ),
                if (_isSearching) ...[
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      _searchController.clear();
                      setState(() {
                        _isSearching = false;
                        _query = '';
                      });
                      FocusScope.of(context).unfocus();
                    },
                    child:Text('Cancel',
                      style:AppTextStyles.bodySmall.copyWith(color: AppColors.textGreen),
                  ),
                  )
                ],
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Content
          Expanded(
            child: _selectedLocation != null
                ? _buildSelectedState()
                : _query.isNotEmpty
                ? _buildSearchResults()
                : _buildDefaultState(),
          ),
        ],
      ),
    );
  }

  // ── Default state ────────────────────────────
  Widget _buildDefaultState() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // GPS location
          Row(
            children: [
              Image.asset('assets/icons/send1.png',
                width: 32,
                height: 32,
              ),
              const SizedBox(width: 8),
              Text('Your GPS location',
                  style:AppTextStyles.labelSmall.copyWith(color: AppColors.textGreen)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text("Couldn't load your location",
                  style:AppTextStyles.caption.copyWith(color: AppColors.textOnDark)),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child:Text('Try Again',
                    style:AppTextStyles.bodySmall.copyWith(color:AppColors.textGreen)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Search results ───────────────────────────
  Widget _buildSearchResults() {
    final results = _filteredLocations;
    if (results.isEmpty) {
      return const Center(
        child: Text('No results found',
            style: TextStyle(color: Colors.grey, fontSize: 14)),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: results.length,
      itemBuilder: (_, i) {
        final loc = _filteredLocations[i];
        return ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(loc['city']!,
              style:AppTextStyles.caption),
          subtitle: Text(loc['zip']!,
              style: AppTextStyles.overline),
          onTap: () {
            setState(() {
              _tempLocation = loc;
              _selectedLocation = loc;
              _isSearching = false;
              _query = '';
              _searchController.clear();
            });
            FocusScope.of(context).unfocus();
          },
        );
      },
    );
  }

  // ── Selected state ───────────────────────────
  Widget _buildSelectedState() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search bar (empty)
          const SizedBox(height: 8),

          // Primary Location
          Text('Primary Location',
              style:AppTextStyles.overline),
          const SizedBox(height: 10),

          Row(
            children: [
             Image.asset('assets/icons/circle_home.png'),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_selectedLocation!['city']!,
                        style: AppTextStyles.labelMedium.copyWith(fontWeight: FontWeight.w700)),
                    Text(_selectedLocation!['zip']!,
                        style:AppTextStyles.overline),
                    GestureDetector(
                      onTap: () =>
                          setState(() => _selectedLocation = null),
                      child:Text('Change',
                          style: AppTextStyles.overline.copyWith(decoration: TextDecoration.underline,decorationColor: AppTextStyles.overline.color)),
                    ),
                  ],
                ),
              ),
              Text('View',
                  style:AppTextStyles.buttonOutline.copyWith(color:AppColors.textGreen)),
            ],
          ),

          const SizedBox(height: 24),

          // Location You Follow
           Text('Location You Follow',
              style:AppTextStyles.overline),
          const SizedBox(height: 10),
          Text("You don't follow any other locations. Add more locations to see news in For you from where your friends or family live, or other places you are interested in.",
            style: AppTextStyles.overline.copyWith(color: Color(0xFFCBCBCB)),
          ),
          const SizedBox(height: 18),
          GestureDetector(
            onTap: () => Get.to(() => const ManageLocationView()),
            child: Text('Add more locations',
                style:AppTextStyles.bodySmall.copyWith(color: AppColors.textGreen))),
        ],
      ),
    );
  }
}

// Clear button widget
class _ClearButton extends StatelessWidget {
  const _ClearButton();

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}