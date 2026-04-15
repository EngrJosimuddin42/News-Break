import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:news_break/app/theme/app_colors.dart';

import '../../../home/controllers/home_controller.dart';
import '../../../location/views/manage_location_view.dart';

class LocationView extends StatefulWidget {
  const LocationView({super.key});

  @override
  State<LocationView> createState() => _LocationState();
}

class _LocationState extends State<LocationView> {
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
    return Scaffold(
      backgroundColor: const Color(0xFF1B1B1E),
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon:Icon(Icons.arrow_back_ios,color:AppColors.textOnDark,size: 20),
        ),
      ),
      body: Container(
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        children: [
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
                  child: const Text('Done',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15,
                          fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C2C2E),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(
                          color: Colors.white, fontSize: 14),
                      onChanged: (val) =>
                          setState(() => _query = val),
                      onTap: () =>
                          setState(() => _isSearching = true),
                      decoration: const InputDecoration(
                        hintText: 'Enter an address or zip code',
                        hintStyle: TextStyle(
                            color: Colors.grey, fontSize: 14),
                        prefixIcon: Icon(Icons.search,
                            color: Colors.grey, size: 18),
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
                    child: const Text('Cancel',
                        style: TextStyle(color: Colors.blue, fontSize: 14)),
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(height: 16),

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
              const Icon(Icons.navigation,
                  color: Colors.blue, size: 18),
              const SizedBox(width: 8),
              const Text('Your GPS location',
                  style:
                  TextStyle(color: Colors.blue, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text("Couldn't load your location",
                  style:
                  TextStyle(color: Colors.grey, fontSize: 13)),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: const Text('Try Again',
                    style: TextStyle(
                        color: Colors.blue, fontSize: 13)),
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
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: results.length,
      separatorBuilder: (_, __) =>
      const Divider(color: Colors.white12, height: 1),
      itemBuilder: (_, i) {
        final loc = _filteredLocations[i];
        return ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(loc['city']!,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
          subtitle: Text(loc['zip']!,
              style: const TextStyle(
                  color: Colors.grey, fontSize: 12)),
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
          const Text('Primary Location',
              style: TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 10),

          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.home,
                    color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_selectedLocation!['city']!,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600)),
                    Text(_selectedLocation!['zip']!,
                        style: const TextStyle(
                            color: Colors.grey, fontSize: 12)),
                    GestureDetector(
                      onTap: () =>
                          setState(() => _selectedLocation = null),
                      child: const Text('Change',
                          style: TextStyle(
                              color: Colors.blue, fontSize: 12)),
                    ),
                  ],
                ),
              ),
              const Text('View',
                  style: TextStyle(
                      color: Colors.blue, fontSize: 13)),
            ],
          ),

          const SizedBox(height: 24),

          // Location You Follow
          const Text('Location You Follow',
              style: TextStyle(
                  color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 10),
          const Text(
            "You don't follow any other locations. Add more locations to see news in For you from where your friends or family live, or other places you are interested in.",
            style: TextStyle(
                color: Colors.grey, fontSize: 13, height: 1.5),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () => Get.to(() => const ManageLocationView()),
            child: const Text('Add more locations',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 13,
                    fontWeight: FontWeight.w500)),
          ),
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