import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/isi_lesson_controller.dart';
import 'dart:convert';

class IsiLessonView extends GetView<IsiLessonController> {
  const IsiLessonView({Key? key}) : super(key: key);

  String _getBase64Image(String? dataUrl) {
    if (dataUrl == null || dataUrl.isEmpty) return '';

    try {
      // Mengambil bagian setelah base64,
      String base64String = dataUrl.split('base64,')[1];

      // Menambahkan padding jika diperlukan
      while (base64String.length % 4 != 0) {
        base64String += '=';
      }

      return base64String;
    } catch (e) {
      print('Error extracting base64 image: $e');
      return '';
    }
  }

  Widget _buildImage(String? imageData) {
    if (imageData == null || imageData.isEmpty) {
      return const Icon(
        Icons.image_not_supported,
        size: 50,
        color: Colors.grey,
      );
    }

    try {
      final base64String = _getBase64Image(imageData);
      if (base64String.isEmpty) {
        return const Icon(
          Icons.image_not_supported,
          size: 50,
          color: Colors.grey,
        );
      }

      return Image.memory(
        base64Decode(base64String),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          print('Error loading image: $error');
          return const Icon(
            Icons.image_not_supported,
            size: 50,
            color: Colors.grey,
          );
        },
      );
    } catch (e) {
      print('Error decoding image: $e');
      return const Icon(
        Icons.image_not_supported,
        size: 50,
        color: Colors.grey,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'LESSON',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF2D3250),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  Text(
                    controller.lesson['judul'] ?? 'No Title',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    controller.lesson['deskripsi'] ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    height: 200,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: _buildImage(controller.lesson['gambar']),
                    ),
                  ),
                  SelectableText(
                    controller.lesson['isi'] ?? 'No content available',
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
