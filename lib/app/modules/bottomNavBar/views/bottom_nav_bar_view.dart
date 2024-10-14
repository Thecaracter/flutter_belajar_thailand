// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veryzona/app/modules/home/controllers/home_controller.dart';
import 'package:veryzona/app/modules/home/views/home_view.dart';
import 'package:veryzona/app/modules/utils/constantColor.dart';
import '../controllers/bottom_nav_bar_controller.dart';

class BottomNavBarView extends GetView<BottomNavBarController> {
  const BottomNavBarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ensure HomeController is available
    Get.put(HomeController());

    return Scaffold(
      body: Obx(() => IndexedStack(
            index: controller.selectedIndex.value,
            children: [
              HomeView(),
              Container(child: Center(child: Text('Book View'))),
              Container(child: Center(child: Text('Menu Book View'))),
              Container(child: Center(child: Text('Bookmark View 1'))),
              Container(child: Center(child: Text('Bookmark View 2'))),
            ],
          )),
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              ConstanColor.primaryColor,
              ConstanColor.secondaryColor,
            ],
          ),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: Offset(0, -1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(0, Icons.home_outlined, 'Home'),
            _buildNavItem(1, Icons.book_outlined, 'Book'),
            _buildNavItem(2, Icons.menu_book_outlined, ''),
            _buildNavItem(3, Icons.bookmark_border_outlined, ''),
            _buildNavItem(4, Icons.bookmark_border_outlined, ''),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    return Obx(() => GestureDetector(
          onTap: () => controller.changeIndex(index),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: controller.selectedIndex.value == index
                  ? Colors.white.withOpacity(0.2)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 32,
                ),
                if (label.isNotEmpty)
                  Text(
                    label,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
          ),
        ));
  }
}
