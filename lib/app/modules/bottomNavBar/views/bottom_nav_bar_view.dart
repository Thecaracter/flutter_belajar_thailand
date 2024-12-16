import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veryzona/app/modules/artikebookmark/controllers/artikebookmark_controller.dart';
import 'package:veryzona/app/modules/book/controllers/book_controller.dart';
import 'package:veryzona/app/modules/home/controllers/home_controller.dart';
import 'package:veryzona/app/modules/lesson/views/lesson_view.dart';
import 'package:veryzona/app/modules/profile/controllers/profile_controller.dart';
import 'package:veryzona/app/modules/artikebookmark/views/artikebookmark_view.dart';
import 'package:veryzona/app/modules/book/views/book_view.dart';
import 'package:veryzona/app/modules/home/views/home_view.dart';
import 'package:veryzona/app/modules/profile/views/profile_view.dart';
import 'package:veryzona/app/modules/utils/constant_color.dart';
import '../controllers/bottom_nav_bar_controller.dart';

class BottomNavBarView extends GetView<BottomNavBarController> {
  const BottomNavBarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    Get.put(BookController());
    Get.put(ArtikelBookmarkController());
    Get.put(ProfileController());

    return Scaffold(
      body: Obx(() => IndexedStack(
            index: controller.selectedIndex.value,
            children: [
              const HomeView(),
              const BookView(),
              Container(
                color: ConstanColor.primaryColor,
                child: const LessonView(),
              ),
              const ArtikelBookmarkView(),
              const ProfileView(),
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
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(0, Icons.home_outlined, 'Home'),
            _buildNavItem(1, Icons.book_outlined, 'Book'),
            _buildNavItem(2, Icons.menu_book_outlined, 'Lesson'),
            _buildNavItem(3, Icons.bookmark_border_outlined, 'Book Mark'),
            _buildNavItem(4, Icons.person, 'profile'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    return Obx(() => GestureDetector(
          onTap: () => controller.changeIndex(index),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                    style: const TextStyle(
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
