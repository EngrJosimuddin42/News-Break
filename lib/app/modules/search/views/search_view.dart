import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _filterController = TextEditingController();
  String _query = '';
  String? _selectedItem;

  static const List<String> _trendingItems = [
    'First selection',
    'Second selection',
    'Third selection',
    'Fourth selection',
    'Fifth selection',
  ];

  List<String> get _filteredItems {
    if (_filterController.text.isEmpty) return _trendingItems;
    return _trendingItems
        .where((item) => item
        .toLowerCase()
        .contains(_filterController.text.toLowerCase()))
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _filterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top search bar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(Icons.arrow_back_ios, color:AppColors.textOnDark, size: 20),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF121212),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        controller: _searchController,
                        autofocus: true,
                        style: AppTextStyles.caption,
                        onChanged: (val) => setState(() => _query = val),
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: const TextStyle(
                              color: Colors.grey, fontSize: 14),
                          prefixIcon: const Icon(Icons.search, color: Colors.grey, size: 20),
                          suffixIcon: _query.isNotEmpty
                              ? GestureDetector(
                            onTap: () {
                              _searchController.clear();
                              setState(() => _query = '');
                            },
                            child: const Icon(Icons.cancel, color: Colors.grey, size: 20),
                          )
                              : null,
                          border: InputBorder.none,
                          contentPadding:
                          const EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Trending label
            Padding(
              padding: EdgeInsets.fromLTRB(16, 4, 16, 12),
              child: Text('Treading',
                style: AppTextStyles.button),
            ),

            // Big card containing all items
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF0B0B0B),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0xFF737373)),
                ),
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    // Find an item field
                    Container(
                      decoration: BoxDecoration(
                         color: const Color(0xFF0B0B0B),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Color(0xFFE6E6E6)),
                      ),
                      child: TextField(
                        controller: _filterController,
                        style: AppTextStyles.caption,
                        onChanged: (_) => setState(() {}),
                        decoration: InputDecoration(
                          hintText: 'Find an item',
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                          contentPadding:
                          EdgeInsets.fromLTRB(16, 14, 16, 14),
                          border: InputBorder.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Each item — separate card
                    ..._filteredItems.map((item) {
                      final isSelected = _selectedItem == item;
                      return GestureDetector(
                        onTap: () =>
                            setState(() => _selectedItem = item),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding:
                          const EdgeInsets.fromLTRB(16, 14, 16, 14),
                          decoration: BoxDecoration(
                            color:const Color(0xFF121212),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.textGreen
                                  : Color(0xFF121212),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(item,
                                  style: AppTextStyles.caption),
                              ),
                              if (isSelected)
                                Icon(Icons.check, color:AppColors.textGreen, size: 20),
                            ],
                          ),
                        ),
                      );
                    }),
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