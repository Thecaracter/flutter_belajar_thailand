import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veryzona/app/modules/components/loading_overlay.dart';
import 'package:veryzona/app/modules/utils/constan_api.dart';

class ArtikelBookmarkController extends GetxController {
  final RxList artikelList = [].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getBookmarkedArtikels();
  }

  void showLoading() {
    if (Get.overlayContext != null) {
      LoadingOverlay.show(
        context: Get.overlayContext!,
        lottieAsset: 'assets/animation/loading.json',
      );
    }
  }

  void hideLoading() {
    LoadingOverlay.hide();
  }

  Future<void> getBookmarkedArtikels() async {
    if (isLoading.value) return;

    showLoading();
    isLoading.value = true;

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('user_token');

      if (token == null) {
        Get.snackbar('Error', 'Please login first');
        return;
      }

      print('Fetching bookmarked articles...');
      print('Token: $token');
      print('URL: ${ConstanApi.BookmarkedArticles}');

      final response = await http.get(
        Uri.parse(ConstanApi.BookmarkedArticles),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Decoded Data: $data');
        artikelList.value = data['data'];
        print('Artikel List Length: ${artikelList.length}');
      } else if (response.statusCode == 401) {
        print('Authentication Error: ${response.body}');
        Get.snackbar('Error', 'Session expired. Please login again');
      } else {
        print('Other Error: ${response.body}');
        Get.snackbar('Error', 'Failed to fetch bookmarked articles');
      }
    } catch (e) {
      print('Exception occurred: $e');
      Get.snackbar('Error', 'An error occurred: ${e.toString()}');
    } finally {
      isLoading.value = false;
      hideLoading();
    }
  }

  Future<void> refreshArticles() async {
    await getBookmarkedArtikels();
  }
}
