import 'package:get/get.dart';
import 'package:btcpool_app/controllers/update_controller.dart';

class DependencyInjection {
  static void init() {
    Get.put<ThemeController>(ThemeController(), permanent: true);
    Get.put<MyController>(MyController(), permanent: true);
  }
}
