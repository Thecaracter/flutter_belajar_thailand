import 'package:get/get.dart';

import '../controllers/artikebookmark_controller.dart';

class ArtikebookmarkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ArtikelBookmarkController>(
      () => ArtikelBookmarkController(),
    );
  }
}
