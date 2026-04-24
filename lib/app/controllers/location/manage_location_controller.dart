import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:news_break/app/widgets/app_snackbar.dart';

class ManageLocationController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final MapController mapController = MapController();

  // Reactive Variables
  var isLocationSelected = false.obs;
  var isBannerVisible = true.obs;
  var isDarkMode = true.obs;
  var currentMapUrl = 'https://cartodb-basemaps-{s}.global.ssl.fastly.net/dark_all/{z}/{x}/{y}.png'.obs;

  final LatLng center = const LatLng(24.0, 90.0);

  // map switch
  void toggleMapStyle() {
    isDarkMode.value = !isDarkMode.value;
    currentMapUrl.value = isDarkMode.value
        ? 'https://cartodb-basemaps-{s}.global.ssl.fastly.net/dark_all/{z}/{x}/{y}.png'
        : 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
  }

  void saveBookmark() {
    if (isLocationSelected.value) {
      AppSnackbar.success(message: "Location added to your bookmarks");
    } else {
      AppSnackbar.error(message: "Please tap on the map or search a location first.");
    }
  }

  void resetToCurrentLocation() {
    mapController.move(center, 7);
    AppSnackbar.success(message: "Back to center location");
  }

  // Search logic
  void searchLocation() async {
    String address = searchController.text.trim();
    if (address.isEmpty) return;

    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        LatLng target = LatLng(locations.first.latitude, locations.first.longitude);
        mapController.move(target, 12);
        isLocationSelected.value = true;
        FocusScope.of(Get.context!).unfocus();
      }
    } catch (e) {
      AppSnackbar.error(message: "Location not found. Try: City, Country");
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}