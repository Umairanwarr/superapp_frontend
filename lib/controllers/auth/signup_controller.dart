import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:superapp/screens/auth/otp_screen.dart';
import 'package:superapp/screens/auth/signin_screen.dart';
import 'package:superapp/services/auth_service.dart';
import 'package:superapp/controllers/auth/signin_controller.dart';

class SignupController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final obscurePassword = true.obs;
  final agreeTerms = false.obs;

  final _authService = AuthService();

  void showPassword() => obscurePassword.value = !obscurePassword.value;
  void termsEvent(bool? v) => agreeTerms.value = v ?? false;

  Future<void> signUp() async {
    if (!agreeTerms.value) {
      Get.snackbar('Error', 'Please agree to terms');
      return;
    }

    try {
      await _authService.register(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        password: passwordController.text,
      );
      Get.to(() => const OtpScreen(), arguments: emailController.text);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void goTosignIn() {
    Get.to(() => const SignInScreen());
  }

  Future<void> signUpWithGoogle() async {
    final signInController = Get.put(SignInController());
    await signInController.signInWithGoogle();
  }

  Future<void> signUpWithApple() async {
    final signInController = Get.put(SignInController());
    await signInController.signInWithApple();
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
