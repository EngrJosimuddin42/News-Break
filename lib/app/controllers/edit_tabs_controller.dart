import 'package:get/get.dart';

class EditTabsController extends GetxController {
  final RxList<String> selectedTopics = <String>[].obs;
  final RxList<String> allTopics = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as List<String>?;
    if (args != null) {
      selectedTopics.assignAll(args);
    }
    allTopics.assignAll(['Weather', 'Beauty', 'Crime', 'Politics']);
  }

  void removeFromSelected(String topic) {
    selectedTopics.remove(topic);
    allTopics.add(topic);
  }

  void addToSelected(String topic) {
    allTopics.remove(topic);
    selectedTopics.add(topic);
  }

  void onSave() {
    Get.back(result: selectedTopics);
  }

  void onCancel() => Get.back();
}