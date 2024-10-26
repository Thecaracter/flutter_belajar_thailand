// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veryzona/app/modules/utils/constant_color.dart';
import '../controllers/baca_artikel_controller.dart';

class BacaArtikelView extends GetView<BacaArtikelController> {
  const BacaArtikelView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                colors: [
                  ConstanColor.primaryColor,
                  ConstanColor.secondaryColor
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds);
            },
            child: Text(
              '˂',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SafeArea(
          child: Obx(() {
            final artikel = controller.artikel.value?.data;
            if (artikel == null) {
              return Center(child: Text('Artikel tidak ditemukan'));
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    artikel.judul ?? '',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        controller.formatDate(artikel.createdAt),
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () => controller.toggleLike(),
                        child: Obx(() => Icon(
                              controller.isLiked.value
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              size: 24.0,
                              color:
                                  controller.isLiked.value ? Colors.red : null,
                            )),
                      ),
                      SizedBox(width: 5),
                      Obx(() => Text(
                            '${controller.likesCount.value}',
                            style: TextStyle(color: Colors.grey),
                          )),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () => controller.toggleBookmark(),
                        child: Obx(() => Icon(
                              controller.isBookmarked.value
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              size: 24.0,
                              color: controller.isBookmarked.value
                                  ? Colors.blue
                                  : null,
                            )),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  SizedBox(height: 10),
                  if (artikel.foto != null && artikel.foto!.isNotEmpty)
                    Image.memory(
                      base64Decode(controller.cleanBase64(artikel.foto!)),
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200,
                          color: Colors.grey,
                          child: Center(child: Text('Image not available')),
                        );
                      },
                    )
                  else
                    Container(
                      height: 200,
                      color: Colors.grey,
                      child: Center(child: Text('No image')),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16),
                        Text(artikel.ringkasan ?? '',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Text(artikel.konten ?? '',
                            style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ConstanColor.secondaryColor, ConstanColor.primaryColor],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: Text(
          'cc: veryzona 2024',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
