import 'package:get/get.dart';

import '../controllers/forgot_password_controller.dart';

class CheckOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordController>(
      () => ForgotPasswordController(),
    );
  }
}
