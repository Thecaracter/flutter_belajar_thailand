import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veryzona/app/data/model/baca_artikel_model.dart';
import 'package:veryzona/app/modules/components/loading_overlay.dart';
import 'package:veryzona/app/modules/utils/constanApi.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class BacaArtikelController extends GetxController {
  final count = 0.obs;
  final Rx<int?> artikelId = Rx<int?>(null);
  final Rx<BacaArtikel?> artikel = Rx<BacaArtikel?>(null);
  final RxBool isLoading = true.obs;
  final RxBool isLiked = false.obs;
  final RxInt likesCount = 0.obs;
  final RxBool isBookmarked = false.obs;

  @override
  void onInit() {
    super.onInit();
    var rawId = Get.arguments['id'];
    if (rawId is int) {
      artikelId.value = rawId;
    } else if (rawId is String) {
      artikelId.value = int.tryParse(rawId);
    }

    initializeDateFormatting('id_ID', null).then((_) {
      if (artikelId.value != null) {
        initArtikel(artikelId.value!);
      } else {
        isLoading.value = false;
      }
    }).catchError((error) {
      isLoading.value = false;
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_token');
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

  void initArtikel(int id) async {
    showLoading();

    try {
      final token = await getToken();
      if (token == null) {
        isLoading.value = false;
        return;
      }

      final response = await http.post(
        Uri.parse(ConstanApi.ArtikelDetail),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({'id': id}),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        artikel.value = BacaArtikel.fromJson(jsonData);
        isLiked.value = artikel.value?.data?.isLiked ?? false;
        likesCount.value = artikel.value?.data?.likesCount ?? 0;
        isBookmarked.value = artikel.value?.data?.isBookmarked ?? false;
      }
    } catch (e) {
      print('Error loading artikel: $e');
    } finally {
      hideLoading();
    }
  }

  void loadArtikel(int id) async {
    isLoading.value = true;

    try {
      final token = await getToken();
      if (token == null) {
        isLoading.value = false;
        return;
      }

      final response = await http.post(
        Uri.parse(ConstanApi.ArtikelDetail),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({'id': id}),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        artikel.value = BacaArtikel.fromJson(jsonData);
        isLiked.value = artikel.value?.data?.isLiked ?? false;
        likesCount.value = artikel.value?.data?.likesCount ?? 0;
        isBookmarked.value = artikel.value?.data?.isBookmarked ?? false;
      }
    } catch (e) {
      print('Error loading artikel: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> toggleLike() async {
    if (artikelId.value == null) return;

    try {
      final token = await getToken();
      if (token == null) return;

      final response = await http.post(
        Uri.parse(ConstanApi.AddLike),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({'id': artikelId.value}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        isLiked.value = !isLiked.value;
        likesCount.value = data['data']['likes_count'];

        // Reload artikel untuk mendapatkan data terbaru
        loadArtikel(artikelId.value!);
      } else {
        print('Failed to toggle like: ${response.body}');
      }
    } catch (e) {
      print('Error toggling like: $e');
    }
  }

  Future<void> toggleBookmark() async {
    if (artikelId.value == null) return;

    try {
      final token = await getToken();
      if (token == null) return;

      final response = await http.post(
        Uri.parse(ConstanApi.AddBookmark),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({'id': artikelId.value}),
      );

      if (response.statusCode == 200) {
        isBookmarked.value = !isBookmarked.value;

        // Reload artikel untuk mendapatkan data terbaru
        loadArtikel(artikelId.value!);
      } else {
        print('Failed to toggle bookmark: ${response.body}');
      }
    } catch (e) {
      print('Error toggling bookmark: $e');
    }
  }

  String cleanBase64(String base64String) {
    return base64String.replaceAll(RegExp(r'^data:image/[^;]+;base64,'), '');
  }

  String formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return '';
    }
    try {
      final date = DateTime.parse(dateString);
      final formatter = DateFormat('d MMMM yyyy HH:mm', 'id_ID');
      return formatter.format(date);
    } catch (e) {
      return dateString;
    }
  }
}
