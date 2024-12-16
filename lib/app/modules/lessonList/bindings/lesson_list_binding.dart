import 'package:get/get.dart';

import '../controllers/lesson_list_controller.dart';

class LessonListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LessonListController>(
      () => LessonListController(),
    );
  }
}
