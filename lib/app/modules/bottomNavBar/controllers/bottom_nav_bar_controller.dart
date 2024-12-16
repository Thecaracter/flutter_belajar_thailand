import 'package:get/get.dart';
import 'package:veryzona/app/modules/home/controllers/home_controller.dart';
import 'package:veryzona/app/modules/artikebookmark/controllers/artikebookmark_controller.dart';
import 'package:veryzona/app/modules/book/controllers/book_controller.dart';
import 'package:veryzona/app/modules/profile/controllers/profile_controller.dart';

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

  Future<void> refreshCurrentPage(int index) async {
    switch (index) {
      case 0:
        if (Get.isRegistered<HomeController>()) {
          await Get.find<HomeController>().refreshArtikels();
        }
        break;
      case 1:
        if (Get.isRegistered<BookController>()) {
          // Assuming you have a refresh method in BookController
          await Get.find<BookController>();
        }
        break;
      case 2:
        // Menu Book View refresh logic if needed
        break;
      case 3:
        if (Get.isRegistered<ArtikelBookmarkController>()) {
          await Get.find<ArtikelBookmarkController>().refreshArticles();
        }
        break;
      case 4:
        if (Get.isRegistered<ProfileController>()) {
          // Assuming you have a refresh method in ProfileController
          await Get.find<ProfileController>();
        }
        break;
    }
  }

  void changeIndex(int index) async {
    if (selectedIndex.value != index) {
      selectedIndex.value = index;
      await refreshCurrentPage(index);
    }
  }
}
