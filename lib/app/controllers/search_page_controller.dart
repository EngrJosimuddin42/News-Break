import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPageController extends GetxController {
  final searchController = TextEditingController();
  final filterController = TextEditingController();

  var query = ''.obs;
  var selectedItem = ''.obs;
  var filteredResult = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    filteredResult.assignAll(trendingItems);
    filterController.addListener(() {
      _performFilter(filterController.text);
    });
    searchController.addListener(() {
      query.value = searchController.text;
      _performFilter(searchController.text);
    });
  }

  @override
  void onClose() {
    searchController.dispose();
    filterController.dispose();
    super.onClose();
  }

  void _performFilter(String text) {
    if (text.isEmpty) {
      filteredResult.assignAll(trendingItems);
    } else {
      var results = trendingItems
          .where((item) => item.toLowerCase().contains(text.toLowerCase()))
          .toList();
      filteredResult.assignAll(results);
    }
  }

  void selectItem(String item) {
    selectedItem.value = item;
  }

  void clearSearch() {
    searchController.clear();
    filterController.clear();
    query.value = '';
    filteredResult.assignAll(trendingItems);
  }

  final RxList<String> trendingItems = [
    'First selection',
    'Second selection',
    'Third selection',
    'Fourth selection',
    'Fifth selection',
  ].obs;

}