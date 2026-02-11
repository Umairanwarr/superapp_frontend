import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superapp/screens/auth/otp_screen.dart';
import 'package:superapp/services/auth_service.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final isLoading = false.obs;
  final _authService = AuthService();

  void back() => Get.back();

  Future<void> resetPassword() async {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      Get.snackbar('Error', 'Please enter your email');
      return;
    }

    isLoading.value = true;
    try {
      await _authService.forgotPassword(email: email);
      Get.snackbar('Success', 'OTP sent to your email');
      // Navigate to OTP screen with email and flag indicating this is a password reset flow
      Get.to(
        () => const OtpScreen(),
        arguments: {'email': email, 'flow': 'forgot_password'},
      );
    } catch (e) {
      Get.snackbar('Error', e.toString().replaceFirst('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
