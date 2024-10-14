// ignore_for_file: unnecessary_overrides

import 'package:get/get.dart';

class SplashController extends GetxController {
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed('/login');
    });
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
