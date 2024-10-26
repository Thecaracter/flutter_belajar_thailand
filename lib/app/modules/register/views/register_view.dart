// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:veryzona/app/modules/components/input_field.dart';
import 'package:veryzona/app/modules/utils/constant_color.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final RegisterController controller = Get.put(RegisterController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: Get.height,
          width: Get.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                ConstanColor.primaryColor,
                ConstanColor.secondaryColor,
              ],
            ),
          ), // Dark purple background
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Buat akun',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 32),
                  EnhancedInputField(
                    hint: 'Email',
                    type: InputFieldType.email,
                    controller: controller.emailController,
                  ),
                  SizedBox(height: 16),
                  EnhancedInputField(
                    hint: 'Nama Pengguna',
                    type: InputFieldType.text,
                    controller: controller.nameController,
                  ),
                  SizedBox(height: 16),
                  EnhancedInputField(
                    hint: 'Kata sandi',
                    type: InputFieldType.password,
                    controller: controller.passwordController,
                  ),
                  SizedBox(height: 16),
                  EnhancedInputField(
                    hint: 'Ulangi Kata sandi',
                    type: InputFieldType.password,
                    controller: controller.confirmPasswordController,
                  ),
                  SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Obx(() => Checkbox(
                              value: controller.isChecked,
                              onChanged: (bool? value) {
                                controller.isChecked = value ?? false;
                              },
                              fillColor:
                                  MaterialStateProperty.all(Colors.white),
                              checkColor: Color(0xFF3E1C33),
                            )),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'dengan klik tombol ini maka anda telah bersedia untuk mematuhi segala peraturan pada aplikasi ini',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.register();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'daftar',
                        style: TextStyle(
                          color: Color(0xFF3E1C33),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sudah punya akun?',
                        style: TextStyle(color: Colors.white),
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed('/login');
                        },
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          child: Text(
                            'Masuk',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
