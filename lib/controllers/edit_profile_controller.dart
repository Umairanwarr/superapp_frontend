import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController {
  final usernameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();

  final photoUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments as Map? ?? {};

    usernameCtrl.text = (args["username"] ?? "").toString();
    emailCtrl.text = (args["email"] ?? "").toString();
    phoneCtrl.text = (args["phone"] ?? "").toString();
    photoUrl.value = (args["photoUrl"] ?? "").toString();
  }

  void back() => Get.back();

  void changePicture() {}

  void updateProfile() {
    Get.back(
      result: {
        "username": usernameCtrl.text.trim(),
        "email": emailCtrl.text.trim(),
        "phone": phoneCtrl.text.trim(),
        "photoUrl": photoUrl.value,
      },
    );
  }

  @override
  void onClose() {
    usernameCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
    super.onClose();
  }
}
