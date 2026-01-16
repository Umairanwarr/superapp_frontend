import 'package:get/get.dart';
import 'package:superapp/screens/auth/new_password_success_screen.dart';

class SetNewPasswordController extends GetxController {
  final obscureNew = true.obs;
  final obscureConfirm = true.obs;

  void back() => Get.back();

  void showNewPassword() => obscureNew.value = !obscureNew.value;
  void showConfirmPassword() => obscureConfirm.value = !obscureConfirm.value;

  void updatePassword() {
    Get.to(() => NewPasswordSuccessScreen());
  }
}
