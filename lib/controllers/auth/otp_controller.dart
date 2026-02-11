import 'package:get/get.dart';
import 'package:superapp/screens/auth/set_new_password_screen.dart';
import 'package:superapp/screens/complete_profile_screen.dart';
import 'package:superapp/services/auth_service.dart';

class OtpController extends GetxController {
  final otp = ''.obs;
  final isLoading = false.obs;
  String email = '';
  String flow = 'register'; // 'register' or 'forgot_password'
  final _authService = AuthService();

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is String) {
      // Legacy: just an email string (registration flow)
      email = args;
      flow = 'register';
    } else if (args is Map) {
      email = args['email'] ?? '';
      flow = args['flow'] ?? 'register';
    }
  }

  void back() => Get.back();

  void setOtp(String v) => otp.value = v;

  Future<void> verify() async {
    if (otp.value.length != 6) {
      Get.snackbar('Error', 'Please enter a valid 6-digit OTP');
      return;
    }

    isLoading.value = true;
    try {
      if (flow == 'forgot_password') {
        // Verify OTP via API first
        await _authService.verifyResetOtp(email: email, otp: otp.value);
        // OTP is valid — navigate to set new password screen
        Get.to(
          () => const SetNewPasswordScreen(),
          arguments: {'email': email, 'otp': otp.value},
        );
      } else {
        // Registration flow: verify OTP via API
        final result = await _authService.verifyOtp(
          email: email,
          otp: otp.value,
        );
        Get.offAll(() => const CompleteProfileScreen(), arguments: result);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString().replaceFirst('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }
}
