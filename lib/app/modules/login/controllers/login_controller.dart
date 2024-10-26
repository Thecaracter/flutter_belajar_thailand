// ignore_for_file: unnecessary_overrides

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veryzona/app/modules/components/loading_overlay.dart';
import 'package:veryzona/app/modules/utils/constan_api.dart';
import 'package:veryzona/app/modules/utils/constant_color.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final RxBool isLoading = false.obs;

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
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void showLoading() {
    isLoading.value = true;
    LoadingOverlay.show(
      context: Get.overlayContext!,
      lottieAsset: 'assets/animation/loading.json',
    );
  }

  void hideLoading() {
    isLoading.value = false;
    LoadingOverlay.hide();
  }

  Future<void> login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter both email and password');
      return;
    }

    showLoading();

    try {
      final response = await http.post(
        Uri.parse(ConstanApi.Login),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': emailController.text,
          'password': passwordController.text,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Login successful
        final user = responseData['data']['user'];
        final token = responseData['data']['access_token'];

        // Save user name and token using SharedPreferences
        await saveUserData(user['name'], token);

        Get.snackbar('Success', 'Login successful',
            snackPosition: SnackPosition.TOP,
            backgroundColor: ConstanColor.Success);

        Get.offAllNamed('/bottom-nav-bar');
      } else if (response.statusCode == 422) {
        final errors = responseData['errors'];
        String errorMessage = errors.values.join('\n');
        Get.snackbar('Error', errorMessage,
            backgroundColor: ConstanColor.Danger,
            snackPosition: SnackPosition.TOP);
      } else if (response.statusCode == 401) {
        // Invalid credentials
        Get.snackbar('Error', 'Invalid login credentials',
            backgroundColor: ConstanColor.Danger,
            snackPosition: SnackPosition.TOP);
      } else {
        // Other errors
        Get.snackbar('Error', 'Login failed: ${responseData['message']}',
            backgroundColor: ConstanColor.Danger,
            snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: ${e.toString()}',
          backgroundColor: ConstanColor.Danger,
          snackPosition: SnackPosition.TOP);
    } finally {
      hideLoading();
    }
  }

  Future<void> saveUserData(String name, String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', name);
    await prefs.setString('user_token', token);
  }
}
