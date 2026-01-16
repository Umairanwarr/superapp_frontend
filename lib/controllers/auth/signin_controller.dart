import 'package:get/get.dart';
import 'package:superapp/screens/auth/forgot_password_screen.dart';
import 'package:superapp/screens/auth/signup_screen.dart';
import 'package:superapp/screens/complete_profile_screen.dart';

class SignInController extends GetxController {
  final obscurePassword = true.obs;

  void showPassword() => obscurePassword.value = !obscurePassword.value;

  void signIn() {
    Get.to(() => const CompleteProfileScreen());
  }

  void forgotPassword() {
    Get.to(() => const ForgotPasswordScreen());
  }

  void signInWithGoogle() {}

  void signInWithApple() {}

  void goToSignup() {
    Get.to(() => SignupScreen());
  }
}
