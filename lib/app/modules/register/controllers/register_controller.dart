// ignore_for_file: unnecessary_overrides

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veryzona/app/modules/components/loading_overlay.dart';
import 'package:veryzona/app/modules/utils/constanApi.dart';

class RegisterController extends GetxController {
  final _isChecked = false.obs;
  bool get isChecked => _isChecked.value;
  set isChecked(bool value) => _isChecked.value = value;

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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
    super.onClose();
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  void toggle() => _isChecked.toggle();

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

  Future<void> register() async {
    if (!isChecked) {
      Get.snackbar('Error', 'Please accept the terms and conditions');
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar('Error', 'Passwords do not match');
      return;
    }

    showLoading();

    try {
      final response = await http.post(
        Uri.parse(ConstanApi.Register),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': nameController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'password_confirmation': confirmPasswordController.text,
        }),
      );

      final responseData = jsonDecode(response.body);
      if (response.statusCode == 201) {
        Get.snackbar('Success', 'Registration successful',
            snackPosition: SnackPosition.TOP, backgroundColor: Colors.green);
        Get.offAllNamed('/login');
      } else {
        String errorMessage = 'Registration failed';
        if (responseData['errors'] != null) {
          errorMessage = responseData['errors'].values.join('\n');
        } else if (responseData['message'] != null) {
          errorMessage = responseData['message'];
        }
        Get.snackbar('Error', errorMessage,
            snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: ${e.toString()}',
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
    } finally {
      hideLoading();
    }
  }
}
