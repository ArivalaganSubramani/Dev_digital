import 'package:get/get.dart';

import '../controllers/count_down_timer_controller.dart';

class CountDownTimerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CountDownTimerController>(
      () => CountDownTimerController(),
    );
  }
}
