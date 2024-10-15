import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veryzona/app/modules/utils/constanApi.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:veryzona/app/data/model/user_model.dart';

class ProfileController extends GetxController {
  final Rx<UserModel?> user = Rx<UserModel?>(null);

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
        Get.snackbar('Success', 'Successfully logged out');
        Get.offAllNamed('/login');
      } else {
        throw Exception('Logout failed');
      }
    } catch (e) {
      Get.snackbar('Error', 'Logout failed: ${e.toString()}');
    }
  }
}
