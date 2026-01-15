import 'package:get/get.dart';
import 'package:superapp/screens/main_screen.dart';

class NewPasswordSuccessController extends GetxController {
  void continueToLogin() {
    Get.to(() => MainScreen());
  }
}
