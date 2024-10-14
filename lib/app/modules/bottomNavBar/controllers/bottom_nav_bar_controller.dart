// ignore_for_file: unnecessary_overrides

import 'package:get/get.dart';
import 'package:veryzona/app/modules/home/controllers/home_controller.dart';

class BottomNavBarController extends GetxController {
  var selectedIndex = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changeIndex(int index) {
    if (selectedIndex.value != index) {
      selectedIndex.value = index;
      if (index == 0) {
        // Refresh Home tab
        Get.find<HomeController>().refreshArtikels();
      }
      // Add similar logic for other tabs if needed
    }
  }
}
