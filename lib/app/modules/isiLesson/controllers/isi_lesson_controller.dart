// app/controllers/isi_lesson_controller.dart
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veryzona/app/modules/utils/constan_api.dart';
import 'dart:convert';

class IsiLessonController extends GetxController {
  final RxMap<String, dynamic> lesson = <String, dynamic>{}.obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    // Convert to string karena ID yang diterima mungkin string
    final lessonId = Get.arguments['lesson_id'].toString();
    getLessonDetail(lessonId);
  }

  Future<void> getLessonDetail(String lessonId) async {
    try {
      isLoading.value = true;

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('user_token');
      final Uri url =
          Uri.parse('${ConstanApi.LessonDetail}?lesson_id=$lessonId');

      print('Request URL: $url');

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      // Detail print untuk debugging
      print('Response Status Code: ${response.statusCode}');
      print('Response Headers: ${response.headers}');
      print('Response Body Raw: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Decoded Data: $data'); // Debug decoded data

        if (data['status'] == true && data['data'] != null) {
          final lessonData = data['data']['lesson'];
          print('Lesson Data: $lessonData'); // Debug lesson data
          lesson.value = lessonData;
        } else {
          print('Invalid data structure or status false');
        }
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error detail: $e');
      Get.snackbar(
        'Error',
        'Failed to load lesson detail',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
