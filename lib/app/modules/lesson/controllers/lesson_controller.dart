import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veryzona/app/modules/utils/constan_api.dart';
import 'dart:convert';

class LessonController extends GetxController {
  final categories = [].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_token');
  }

  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;

      final token = await getToken();
      print('Token: $token');

      if (token == null) {
        Get.snackbar(
          'Error',
          'Please login first',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      print('Fetching from URL: ${ConstanApi.Categories}');

      final response = await http.get(
        Uri.parse(ConstanApi.Categories),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response headers: ${response.headers}');
      print('Response body raw: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Decoded data: $data');
        print('Categories from response: ${data['data']['categories']}');
        categories.value = data['data']['categories'];
        print('Categories in controller: ${categories.value}');
      } else if (response.statusCode == 401) {
        print('Auth error - token might be invalid');
        Get.snackbar(
          'Error',
          'Session expired. Please login again',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        print('Other error - status code: ${response.statusCode}');
        Get.snackbar(
          'Error',
          'Failed to load categories',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e, stackTrace) {
      print('Error fetching categories: $e');
      print('Stack trace: $stackTrace');
      Get.snackbar(
        'Error',
        'An error occurred while loading categories',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshCategories() async {
    await fetchCategories();
  }
}
