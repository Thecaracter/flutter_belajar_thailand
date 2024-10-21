// ignore_for_file: unnecessary_overrides

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:veryzona/app/modules/components/loading_overlay.dart';
import 'package:veryzona/app/modules/utils/constanApi.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final otpController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final errorMessage = ''.obs;

  late String email = '';

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
    otpController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  void showLoading() {
    LoadingOverlay.show(
      context: Get.overlayContext!,
      lottieAsset: 'assets/animation/loading.json',
    );
  }

  void hideLoading() {
    LoadingOverlay.hide();
  }

  Future<void> sendOtp() async {
    if (emailController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your email',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    showLoading();

    try {
      final response = await http.post(
        Uri.parse(ConstanApi.SendOTP),
        body: {
          'email': emailController.text,
        },
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          'OTP sent successfully',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.toNamed('/check-otp');
      } else {
        Get.snackbar(
          'Error',
          responseData['message'] ?? 'An error occurred',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to connect to the server',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      hideLoading();
    }
  }

  Future<void> verifyOtp() async {
    if (emailController.text.isEmpty || otpController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter both email and OTP');
      return;
    }

    showLoading();
    errorMessage.value = '';

    try {
      final response = await http.post(
        Uri.parse(ConstanApi.CheckOTP),
        body: {
          'email': emailController.text,
          'otp': otpController.text,
        },
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'OTP verified successfully');
        Get.toNamed('/change-password');
      } else {
        errorMessage.value = responseData['message'] ?? 'An error occurred';
        Get.snackbar('Error', errorMessage.value);
      }
    } catch (e) {
      errorMessage.value = 'Failed to connect to the server';
      Get.snackbar('Error', errorMessage.value);
    } finally {
      hideLoading();
    }
  }

  Future<void> resetPassword() async {
    if (emailController.text.isEmpty ||
        otpController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill in all fields',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar('Error', 'Passwords do not match',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }
    showLoading();

    try {
      final response = await http.post(
        Uri.parse(ConstanApi.ChangePassword),
        body: {
          'email': emailController.text,
          'otp': otpController.text,
          'password': passwordController.text,
          'password_confirmation': confirmPasswordController.text,
        },
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Password reset successfully',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        // Navigate to login page or home page
        Get.offAllNamed('/login');
      } else {
        Get.snackbar('Error', responseData['message'] ?? 'An error occurred',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to connect to the server',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      hideLoading();
    }
  }
}
