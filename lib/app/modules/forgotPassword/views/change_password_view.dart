// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veryzona/app/modules/utils/constant_color.dart';
import 'package:veryzona/app/modules/forgotPassword/controllers/forgot_password_controller.dart';
import 'package:veryzona/app/modules/components/input_field.dart';

class ChangePasswordView extends GetView<ForgotPasswordController> {
  const ChangePasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ForgotPasswordController>();
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
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Silahkan Masukan Password Baru Anda',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32),
                  EnhancedInputField(
                    hint: 'Password Baru',
                    type: InputFieldType.password,
                    controller: controller.passwordController,
                  ),
                  SizedBox(height: 16),
                  EnhancedInputField(
                    hint: 'Konfirmasi Password Baru',
                    type: InputFieldType.password,
                    controller: controller.confirmPasswordController,
                  ),
                  SizedBox(height: 32),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.resetPassword();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Reset Password',
                          style: TextStyle(
                              color: ConstanColor.primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
