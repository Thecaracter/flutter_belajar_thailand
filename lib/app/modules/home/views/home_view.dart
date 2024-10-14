// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veryzona/app/modules/utils/constantColor.dart';
import '../controllers/home_controller.dart';
import 'dart:convert';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 40,
        leadingWidth: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.red[800],
              radius: 14,
              child: Icon(Icons.person, color: Colors.white, size: 17),
            ),
            SizedBox(width: 8),
            Obx(
              () {
                if (controller.isLoading.value && controller.userName.isEmpty) {
                  return Text('Loading...');
                } else {
                  return Text(
                    controller.userName,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  );
                }
              },
            ),
          ],
        ),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              Icon(Icons.notifications_outlined, color: Colors.black, size: 24),
              Positioned(
                top: 4,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 12,
                    minHeight: 12,
                  ),
                  child: Text(
                    '25',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.artikelList.isEmpty) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.error.value.isNotEmpty &&
            controller.artikelList.isEmpty) {
          return Center(child: Text('Error: ${controller.error.value}'));
        } else {
          return RefreshIndicator(
            onRefresh: controller.refreshArtikels,
            child: ListView.builder(
              itemCount: controller.artikelList.length + 1,
              itemBuilder: (context, index) {
                if (index == controller.artikelList.length) {
                  if (controller.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  } else if (!controller.isLastPage.value) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _loadMore(controller);
                    });
                    return SizedBox(height: 60);
                  } else {
                    return SizedBox();
                  }
                }
                final artikel = controller.artikelList[index];
                return InkWell(
                  onTap: () {
                    Get.toNamed('/baca-artikel', arguments: {'id': artikel.id});
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.8),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                              child: artikel.foto != null &&
                                      artikel.foto!.isNotEmpty
                                  ? Image.memory(
                                      base64Decode(
                                          artikel.foto!.split(',').last),
                                      height: 200,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      height: 200,
                                      width: double.infinity,
                                      color: Colors.grey[300],
                                      child: Icon(Icons.image,
                                          size: 50, color: Colors.grey[600]),
                                    ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Colors.black.withOpacity(0.8),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 10,
                              left: 10,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: ConstanColor.primaryColor,
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.remove_red_eye,
                                        color: Colors.white, size: 16),
                                    SizedBox(width: 5),
                                    Text(
                                      controller.formatCount(artikel.viewCount),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 16),
                                    Icon(Icons.favorite,
                                        color: Colors.white, size: 16),
                                    SizedBox(width: 5),
                                    Text(
                                      controller.formatCount(artikel.likeCount),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                artikel.judul ?? '',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 8),
                              Text(
                                artikel.ringkasan ?? '',
                                style: TextStyle(fontSize: 14),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
      }),
    );
  }

  void _loadMore(HomeController controller) {
    if (!controller.isLoading.value && !controller.isLastPage.value) {
      controller.fetchArtikels();
    }
  }
}
