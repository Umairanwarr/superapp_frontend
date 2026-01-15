import 'package:get/get.dart';
import 'package:superapp/screens/auth/set_new_password_screen.dart';

class OtpController extends GetxController {
  final otp = ''.obs;

  void back() => Get.back();

  void setOtp(String v) => otp.value = v;

  void verify() {
    Get.to(() => SetNewPasswordScreen());
  }
}
