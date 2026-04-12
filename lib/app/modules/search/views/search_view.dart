import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                    child: const Icon(Icons.arrow_back_ios,
                        color: Colors.white, size: 18),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1C1C1E),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: _searchController,
                        autofocus: true,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 14),
                        onChanged: (val) =>
                            setState(() => _query = val),
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: const TextStyle(
                              color: Colors.grey, fontSize: 14),
                          prefixIcon: const Icon(Icons.search,
                              color: Colors.grey, size: 18),
                          suffixIcon: _query.isNotEmpty
                              ? GestureDetector(
                            onTap: () {
                              _searchController.clear();
                              setState(() => _query = '');
                            },
                            child: const Icon(Icons.cancel,
                                color: Colors.grey, size: 18),
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
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 4, 16, 12),
              child: Text(
                'Treading',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // Filter + list
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1C1C1E),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    // Find an item field
                    TextField(
                      controller: _filterController,
                      style: const TextStyle(
                          color: Colors.white, fontSize: 14),
                      onChanged: (_) => setState(() {}),
                      decoration: const InputDecoration(
                        hintText: 'Find an item',
                        hintStyle:
                        TextStyle(color: Colors.grey, fontSize: 14),
                        contentPadding: EdgeInsets.fromLTRB(16, 14, 16, 14),
                        border: InputBorder.none,
                      ),
                    ),
                    const Divider(color: Colors.white12, height: 1),

                    // List items
                    ..._filteredItems.map((item) {
                      final isSelected = _selectedItem == item;
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () =>
                                setState(() => _selectedItem = item),
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(
                                  16, 14, 16, 14),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFF1A2A3A)
                                    : Colors.transparent,
                                border: isSelected
                                    ? Border.all(
                                    color: Colors.blue.shade700,
                                    width: 1)
                                    : null,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.blue
                                            : Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  if (isSelected)
                                    Icon(Icons.check,
                                        color: Colors.blue.shade400,
                                        size: 18),
                                ],
                              ),
                            ),
                          ),
                          if (item != _filteredItems.last)
                            const Divider(
                                color: Colors.white12, height: 1),
                        ],
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