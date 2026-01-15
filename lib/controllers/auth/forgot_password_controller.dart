import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superapp/screens/auth/otp_screen.dart';

class ForgotPasswordController extends GetxController {
  final email = TextEditingController();

  void back() => Get.back();

  void resetPassword() {
    // final value = email.text.trim();
    // if (value.isEmpty) {
    //   Get.snackbar('Error', 'Please enter your email');
    //   return;
    // }
    Get.to(() => OtpScreen());
  }

  @override
  void onClose() {
    email.dispose();
    super.onClose();
  }
}
