import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superapp/screens/auth/signin_screen.dart';
import 'package:superapp/screens/main_screen.dart';

class SignupController extends GetxController {
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  final obscurePassword = true.obs;
  final agreeTerms = false.obs;

  void showPassword() => obscurePassword.value = !obscurePassword.value;
  void termsEvent(bool? v) => agreeTerms.value = v ?? false;

  void signUp() {
    Get.to(() => MainScreen());
  }

  void goTosignIn() {
    Get.to(() => SignInScreen());
  }

  void signUpWithGoogle() {}

  void signUpWithApple() {}

  @override
  void onClose() {
    firstName.dispose();
    lastName.dispose();
    email.dispose();
    password.dispose();
    super.onClose();
  }
}
