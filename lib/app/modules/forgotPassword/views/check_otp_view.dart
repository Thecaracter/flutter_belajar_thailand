// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:veryzona/app/modules/forgotPassword/controllers/forgot_password_controller.dart';
import 'package:veryzona/app/modules/utils/constantColor.dart';

class CheckOtpView extends GetView<ForgotPasswordController> {
  const CheckOtpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ForgotPasswordController>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ConstanColor.primaryColor,
        iconTheme: IconThemeData(
            color: Colors.white), // This changes the back button color
      ),
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
                    'Masukkan Kode OTP Anda',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32),
                  PinCodeTextField(
                    appContext: context,
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.white70,
                      selectedFillColor: Colors.white,
                      activeColor: ConstanColor.primaryColor,
                      inactiveColor: Colors.white70,
                      selectedColor: ConstanColor.primaryColor,
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    enableActiveFill: true,
                    controller: controller.otpController,
                    onCompleted: (v) {
                      controller.verifyOtp();
                    },
                    onChanged: (value) {},
                  ),
                  SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Verifikasi OTP',
                        style: TextStyle(
                          color: ConstanColor.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      controller.sendOtp();
                    },
                    child: Text(
                      'Kirim Ulang OTP',
                      style: TextStyle(color: Colors.white),
                    ),
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
