import 'package:get/get.dart';
import 'package:superapp/screens/complete_profile_screen.dart';

class NewPasswordSuccessController extends GetxController {
  void continueToLogin() {
    Get.to(() => const CompleteProfileScreen());
  }
}
