import 'package:get/get.dart';

import '../controllers/baca_artikel_controller.dart';

class BacaArtikelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BacaArtikelController>(
      () => BacaArtikelController(),
    );
  }
}
