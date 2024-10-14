// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veryzona/app/modules/components/input_field.dart';
import 'package:veryzona/app/modules/utils/constantColor.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());
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
                    'Masuk',
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
                    hint: 'Kata sandi',
                    type: InputFieldType.password,
                    controller: controller.passwordController,
                  ),
                  SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.login();
                      },
                      child: Text(
                        'Masuk',
                        style: TextStyle(
                          color: Color(0xFF3E1C33),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
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
                          Get.toNamed('/register');
                        },
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          child: Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Lupa kata sandi?',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed('/forgot-password');
                        },
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          child: Text(
                            'Klik disini',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
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
