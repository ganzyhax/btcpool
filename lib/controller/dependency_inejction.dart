import 'package:get/get.dart';
import 'package:btcpool_app/controller/update_controller.dart';

class DependencyInjection {
  static void init() {
    Get.put<MyController>(MyController(), permanent: true);
    Get.put<ThemeController>(ThemeController(), permanent: true);
  }
}
