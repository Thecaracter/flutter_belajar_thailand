import 'package:get/get.dart';

import '../controllers/isi_lesson_controller.dart';

class IsiLessonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IsiLessonController>(
      () => IsiLessonController(),
    );
  }
}
