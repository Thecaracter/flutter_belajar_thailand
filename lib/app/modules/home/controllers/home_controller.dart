// ignore_for_file: annotate_overrides

import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veryzona/app/data/model/artikel_model.dart';
import 'package:http/http.dart' as http;
import 'package:veryzona/app/modules/components/loading_overlay.dart';
import 'package:veryzona/app/modules/utils/constanApi.dart';

class HomeController extends GetxController {
  final Rx<String?> _userName = Rx<String?>(null);
  var artikelList = <ArtikelItem>[].obs;
  var isLoading = false.obs;
  var error = ''.obs;
  var currentPage = 1.obs;
  var isLastPage = false.obs;
  String get userName => _userName.value ?? 'Guest';

  @override
  void onInit() {
    super.onInit();
    fetchArtikels();
    getUserData();
  }

  void onReady() {
    super.onReady();
    if (_userName.value == null) {
      getUserData();
    }
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

  Future<void> fetchArtikels({bool refresh = false}) async {
    showLoading();
    if (refresh) {
      currentPage.value = 1;
      isLastPage.value = false;
      artikelList.clear();
    }

    if (isLastPage.value) return;

    isLoading.value = true;
    error.value = '';

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('user_token') ?? '';

      final response = await http.get(
        Uri.parse('${ConstanApi.Artikel}?page=${currentPage.value}'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final artikelResponse = Artikel.fromJson(json.decode(response.body));
        final newData = artikelResponse.data?.data ?? [];

        if (newData.isNotEmpty) {
          artikelList.addAll(newData);
          currentPage.value++;
        } else {
          isLastPage.value = true;
        }
      } else {
        error.value = 'Failed to load articles: ${response.statusCode}';
      }
    } catch (e) {
      error.value = 'An error occurred: $e';
    } finally {
      isLoading.value = false;
      hideLoading();
    }
  }

  Future<void> refreshArtikels() async {
    await fetchArtikels(refresh: true);
  }

  String formatCount(int? count) {
    if (count == null) return '0';
    if (count >= 1000) {
      double result = count / 1000.0;
      return result >= 10
          ? '${result.round()}K'
          : '${result.toStringAsFixed(1)}K';
    }
    return count.toString();
  }

  Future<void> getUserData() async {
    final prefs = await SharedPreferences.getInstance();

    _userName.value = prefs.getString('user_name');
    update();
  }
}
