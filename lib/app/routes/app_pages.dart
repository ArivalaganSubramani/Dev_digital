import 'package:get/get.dart';

import '../modules/CountDownTimer/bindings/count_down_timer_binding.dart';
import '../modules/CountDownTimer/views/count_down_timer_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.COUNT_DOWN_TIMER;

  static final routes = [
    GetPage(
      name: _Paths.COUNT_DOWN_TIMER,
      page: () => const CountDownTimerView(),
      binding: CountDownTimerBinding(),
    ),
  ];
}
