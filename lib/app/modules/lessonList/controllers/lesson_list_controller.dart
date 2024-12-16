// lesson_list_controller.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veryzona/app/modules/utils/constan_api.dart';
import 'package:veryzona/app/modules/utils/constant_color.dart';
import 'package:veryzona/app/routes/app_pages.dart';

class LessonListController extends GetxController {
  final lessons = [].obs;
  final isLoading = false.obs;
  final kategoriNama = ''.obs;
  late final String kategoriId;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null &&
        Get.arguments['kategori_id'] != null &&
        Get.arguments['nama'] != null) {
      kategoriId = Get.arguments['kategori_id'].toString();
      kategoriNama.value = Get.arguments['nama'];
      getLessons();
    } else {
      Get.snackbar('Error', 'Invalid category',
          backgroundColor: ConstanColor.Danger,
          snackPosition: SnackPosition.TOP);
    }
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_token');
  }

  Future<void> getLessons() async {
    try {
      isLoading(true);
      final token = await _getToken();

      if (token == null) {
        Get.snackbar('Error', 'Please login first',
            backgroundColor: ConstanColor.Danger,
            snackPosition: SnackPosition.TOP);
        return;
      }

      final response = await http.post(
        Uri.parse(ConstanApi.LessonsByCategory),
        body: {'kategori_id': kategoriId},
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == true) {
          lessons.value = data['data']['lessons'];
        } else {
          Get.snackbar('Error', data['message'] ?? 'Failed to load lessons',
              backgroundColor: ConstanColor.Danger,
              snackPosition: SnackPosition.TOP);
        }
      } else if (response.statusCode == 401) {
        Get.snackbar('Error', 'Session expired. Please login again',
            backgroundColor: ConstanColor.Danger,
            snackPosition: SnackPosition.TOP);
        Get.offAllNamed(Routes.LOGIN);
      } else {
        Get.snackbar('Error', 'Failed to load lessons',
            backgroundColor: ConstanColor.Danger,
            snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred',
          backgroundColor: ConstanColor.Danger,
          snackPosition: SnackPosition.TOP);
    } finally {
      isLoading(false);
    }
  }

  Future<void> refreshLessons() async {
    await getLessons();
  }
}
