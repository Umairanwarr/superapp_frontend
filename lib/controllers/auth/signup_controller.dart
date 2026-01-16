import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superapp/screens/auth/signin_screen.dart';
import 'package:superapp/screens/complete_profile_screen.dart';

class SignupController extends GetxController {
  final obscurePassword = true.obs;
  final agreeTerms = false.obs;

  void showPassword() => obscurePassword.value = !obscurePassword.value;
  void termsEvent(bool? v) => agreeTerms.value = v ?? false;

  void signUp() {
    Get.to(() => CompleteProfileScreen());
  }

  void goTosignIn() {
    Get.to(() => SignInScreen());
  }

  void signUpWithGoogle() {}

  void signUpWithApple() {}
}
