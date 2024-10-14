// ignore_for_file: unnecessary_overrides

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingController extends GetxController {
  final Rx<String?> _userName = Rx<String?>(null);
  final Rx<String?> _userToken = Rx<String?>(null);

  String get userName => _userName.value ?? 'Guest';
  String? get userToken => _userToken.value;

  @override
  void onInit() {
    super.onInit();
    getUserData();
  }

  @override
  void onReady() {
    super.onReady();
    // Tambahkan pengecekan data di sini juga
    if (_userName.value == null || _userToken.value == null) {
      getUserData();
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getUserData() async {
    final prefs = await SharedPreferences.getInstance();

    _userName.value = prefs.getString('user_name');
    _userToken.value = prefs.getString('user_token');
    update();
  }

  bool get isLoggedIn =>
      _userToken.value != null && _userToken.value!.isNotEmpty;
}
