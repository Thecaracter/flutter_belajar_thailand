// ignore_for_file: unnecessary_overrides

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('user_token');
    if (token != null) {
      Get.offAllNamed('/bottom-nav-bar');
    } else {
      Future.delayed(const Duration(seconds: 3), () {
        Get.offAllNamed('/login');
      });
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
