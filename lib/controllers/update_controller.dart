import 'package:get/get.dart';
import 'package:btcpool_app/app/components/modal/custom_update.dart';

class MyController extends GetxController {
  RxBool showDialogFlag = false.obs;

  void changeAndShowDialog() {
    if (showDialogFlag.isFalse) {
      Get.dialog(
          barrierDismissible: false,
          UpdateModal(
            withSkip: false,
          ));
    }
    showDialogFlag.value = true;
  }
}

class ThemeController extends GetxController {
  RxBool isDark = false.obs;
  void toggle() {
    if (isDark.isFalse) {
      isDark.value = true;
    } else {
      isDark.value = false;
    }
  }
}
