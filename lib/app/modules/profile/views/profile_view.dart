// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veryzona/app/modules/utils/constantColor.dart';
import '../controllers/profile_controller.dart';
import 'dart:convert';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return Scaffold(
      body: Obx(() {
        if (controller.user.value == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      ConstanColor.primaryColor,
                      ConstanColor.secondaryColor
                    ],
                  ),
                ),
              ),
              SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white.withOpacity(0.00),
                          ),
                          Expanded(
                            child: Text(
                              '@${controller.user.value!.name.value}',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.logout, color: Colors.white),
                            onPressed: controller.logout,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      backgroundImage: controller
                                  .user.value!.avatarBase64?.value.isNotEmpty ==
                              true
                          ? MemoryImage(base64Decode(
                              controller.user.value!.avatarBase64!.value))
                          : null,
                      child:
                          controller.user.value!.avatarBase64?.value.isEmpty ??
                                  true
                              ? const Icon(Icons.person,
                                  size: 80, color: Colors.grey)
                              : null,
                    ),
                    const SizedBox(height: 40),
                    Container(
                      height: Get.height - 250,
                      width: Get.width,
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Pengaturan Akun',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          _buildSettingInput('Nama pengguna', Icons.person,
                              controller.user.value!.name),
                          _buildSettingInput('Email', Icons.email,
                              controller.user.value!.email),
                          _buildSettingInput('Kontak', Icons.phone,
                              controller.user.value!.noHp ?? '-'.obs),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () {
                                // Implement save changes logic here
                              },
                              child: Ink(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      ConstanColor.primaryColor,
                                      ConstanColor.secondaryColor
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Container(
                                  constraints: BoxConstraints(minHeight: 50),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'Simpan Perubahan',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                              height: 20), // Add some padding at the bottom
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildSettingInput(String title, IconData icon, RxString value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.grey[600]),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Obx(() => TextField(
                  decoration: InputDecoration(
                    labelText: title,
                    border: InputBorder.none,
                  ),
                  controller: TextEditingController(text: value.value),
                  onChanged: (newValue) =>
                      value.value = newValue.isEmpty ? '-' : newValue,
                )),
          ),
        ],
      ),
    );
  }
}
