import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superapp/controllers/profile_controller.dart';
import 'package:superapp/screens/main_screen.dart';
import 'package:superapp/services/auth_service.dart';

class CompleteProfileController extends GetxController {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();

  final gender = 'Male'.obs;
  final currency = 'USD'.obs;
  final language = 'English'.obs;

  final photoUrl = ''.obs;
  final isLoading = false.obs;

  final _authService = AuthService();

  int _userId = 0;
  String _token = '';

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;
    if (args is Map) {
      final user = (args['user'] as Map?) ?? {};
      _token = (args['access_token'] as String?) ?? '';
      _userId = (user['id'] as int?) ?? 0;

      fullNameController.text = (user['fullName'] as String?) ?? '';
      emailController.text = (user['email'] as String?) ?? '';
      photoUrl.value = (user['avatar'] as String?) ?? '';

      final g = user['gender'];
      if (g is String && g.isNotEmpty) {
        if (g.toLowerCase() == 'female') gender.value = 'Female';
        if (g.toLowerCase() == 'other') gender.value = 'Other';
      }

      final c = user['currency'];
      if (c is String && c.isNotEmpty) currency.value = c;

      final l = user['lang'];
      if (l is String && l.isNotEmpty) {
        if (l.toUpperCase() == 'URDU') language.value = 'Urdu';
        if (l.toUpperCase() == 'ARABIC') language.value = 'Arabic';
      }
    }

    if (_userId == 0) {
      final profile = Get.find<ProfileController>();
      _userId = profile.userId;
      _token = profile.token;
      if (fullNameController.text.isEmpty) {
        fullNameController.text = profile.username.value;
      }
      if (emailController.text.isEmpty) {
        emailController.text = profile.email.value;
      }
      if (photoUrl.value.isEmpty) {
        photoUrl.value = profile.photoUrl.value;
      }
    }
  }

  void setGender(String? v) {
    if (v != null && v.isNotEmpty) gender.value = v;
  }

  void setCurrency(String? v) {
    if (v != null && v.isNotEmpty) currency.value = v;
  }

  void setLanguage(String? v) {
    if (v != null && v.isNotEmpty) language.value = v;
  }

  Future<void> saveProfile() async {
    if (_userId == 0) {
      Get.snackbar('Error', 'Missing user session. Please sign in again.');
      return;
    }

    isLoading.value = true;
    try {
      final nameParts = fullNameController.text.trim().split(' ');
      final fName = nameParts.isNotEmpty ? nameParts.first : '';
      final lName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

      final updatedUser = await _authService.editUserProfile(
        userId: _userId,
        fullName: fullNameController.text.trim(),
        firstName: fName,
        lastName: lName,
        email: emailController.text.trim(),
        avatar: photoUrl.value,
      );

      await _authService.updateProfile(
        userId: _userId,
        token: _token,
        fullName: fullNameController.text.trim(),
        gender: gender.value.toUpperCase(),
        currency: currency.value.toUpperCase(),
        language: language.value.toUpperCase(),
        isProfileComplete: true,
      );

      final profile = Get.find<ProfileController>();
      await profile.saveUserData(
        id: updatedUser['id'] as int?,
        userToken: _token,
        name: (updatedUser['fullName'] as String?) ?? fullNameController.text.trim(),
        userEmail: (updatedUser['email'] as String?) ?? emailController.text.trim(),
        userPhone: (updatedUser['phoneNumber'] as String?) ?? '',
        userPhotoUrl: (updatedUser['avatar'] as String?) ?? photoUrl.value,
        userFirstName: (updatedUser['firstName'] as String?) ?? fName,
      );

      Get.offAll(() => const MainScreen());
    } catch (e) {
      Get.snackbar('Error', e.toString().replaceFirst('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    super.onClose();
  }
}
