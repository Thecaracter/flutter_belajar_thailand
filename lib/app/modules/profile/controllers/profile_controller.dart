// ignore_for_file: avoid_print

import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veryzona/app/modules/components/loading_overlay.dart';
import 'package:veryzona/app/modules/utils/constanApi.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:veryzona/app/data/model/user_model.dart';
import 'package:veryzona/app/modules/utils/constantColor.dart';
import 'package:file_picker/file_picker.dart';

class ProfileController extends GetxController {
  final Rx<UserModel?> user = Rx<UserModel?>(null);
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  Future<void> loadUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('user_token');

      if (token == null) {
        throw Exception('No token found');
      }

      final response = await http.get(
        Uri.parse(ConstanApi.GetProfile),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print(response.body);
        if (jsonResponse['status'] == 'success') {
          user.value = UserModel.fromJson(jsonResponse['data']);
        } else {
          throw Exception(jsonResponse['message']);
        }
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load user data: ${e.toString()}');
    }
  }

  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('user_token');

      if (token == null) {
        throw Exception('No token found');
      }

      final response = await http.post(
        Uri.parse(ConstanApi.Logout),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        await prefs.remove('user_name');
        await prefs.remove('user_token');
        user.value = null;
        Get.snackbar('Success', 'Successfully logged out',
            snackPosition: SnackPosition.TOP,
            backgroundColor: ConstanColor.Success);
        Get.offAllNamed('/login');
      } else {
        throw Exception('Logout failed');
      }
    } catch (e) {
      Get.snackbar('Error', 'Logout failed: ${e.toString()}');
    }
  }

  Uint8List decodeBase64Image(String base64String) {
    final regex = RegExp(r'data:[^;]+;base64,');

    if (regex.hasMatch(base64String)) {
      final cleanBase64 = base64String.replaceFirst(regex, '');
      return base64Decode(cleanBase64);
    } else {
      return base64Decode(base64String);
    }
  }

  Future<void> updateAvatar() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result == null || result.files.isEmpty) {
        Get.snackbar('Error', 'Tidak ada gambar yang dipilih');
        return;
      }

      PlatformFile file = result.files.first;

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('user_token');

      if (token == null) {
        throw Exception('Token tidak ditemukan');
      }

      var url = Uri.parse(ConstanApi.UpdateAvatar);
      var request = http.MultipartRequest('POST', url);

      request.files
          .add(await http.MultipartFile.fromPath('avatar', file.path!));

      request.headers['Authorization'] = 'Bearer $token';

      var response = await request.send();

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Avatar berhasil diperbarui',
            snackPosition: SnackPosition.TOP,
            backgroundColor: ConstanColor.Success);

        await loadUserData();
      } else {
        throw Exception(
            'Gagal memperbarui avatar. Status code: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal memperbarui avatar: ${e.toString()}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: ConstanColor.Danger);
    }
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

  Future<void> updateProfile() async {
    try {
      showLoading();
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('user_token');

      if (token == null) {
        throw Exception('No token found');
      }

      final response = await http.put(
        Uri.parse(ConstanApi.UpdateProfile),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, dynamic>{
          'name': nameController.text,
          'email': emailController.text,
          'no_hp': phoneController.text,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          user.value = UserModel.fromJson(responseData['data']);
          Get.snackbar('Success', 'Profile updated successfully',
              snackPosition: SnackPosition.TOP,
              backgroundColor: ConstanColor.Success);
        } else {
          throw Exception(responseData['message']);
        }
      } else if (response.statusCode == 422) {
        final errorData = json.decode(response.body);
        throw Exception(errorData['errors'].toString());
      } else {
        throw Exception('Failed to update profile');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile: ${e.toString()}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: ConstanColor.Danger);
    } finally {
      loadUserData();
      hideLoading();
    }
  }
}
