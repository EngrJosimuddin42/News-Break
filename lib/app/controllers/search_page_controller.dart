import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPageController extends GetxController {
  final searchController = TextEditingController();
  final filterController = TextEditingController();

  var query = ''.obs;
  var selectedItem = ''.obs;


  final List<String> trendingItems = [
    'First selection',
    'Second selection',
    'Third selection',
    'Fourth selection',
    'Fifth selection',
  ];

  List<String> get filteredItems {
    if (filterController.text.isEmpty) return trendingItems;
    return trendingItems
        .where((item) => item.toLowerCase().contains(filterController.text.toLowerCase()))
        .toList();
  }

  void onSearchChanged(String val) => query.value = val;

  void selectItem(String item) => selectedItem.value = item;

  void clearSearch() {
    searchController.clear();
    query.value = '';
  }

  @override
  void onInit() {
    super.onInit();
    filterController.addListener(() {
      update();
    });
  }

  @override
  void onClose() {
    searchController.dispose();
    filterController.dispose();
    super.onClose();
  }
}