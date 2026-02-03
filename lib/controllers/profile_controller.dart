import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:superapp/screens/bottomNavScreen/edit_profile_screen.dart';
import 'package:superapp/screens/community_screen.dart';
import 'package:superapp/screens/job_assignment_screen.dart';
import 'package:superapp/screens/my_wallet_screen.dart';
import 'package:superapp/screens/notification_setting_screen.dart';
import 'package:superapp/screens/photo_detail_screen.dart';
import 'package:superapp/screens/photo_review_screen.dart';
import 'package:superapp/screens/security_setting_screen.dart';

class ProfileController extends GetxController {
  final bookings = 12.obs;
  final reviews = 8.obs;
  final points = 100.obs;

  final username = 'Alex Hales'.obs;
  final email = 'alex@gmail.com'.obs;
  final phone = '+14987889999'.obs;
  final photoUrl = ''.obs;

  static const _themeKey = 'is_dark_mode';
  final isDark = true.obs;

  @override
  void onInit() {
    super.onInit();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getBool(_themeKey);

    isDark.value = saved ?? true;
    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);

    if (saved == null) {
      await prefs.setBool(_themeKey, isDark.value);
    }
  }

  Future<void> toggleTheme(bool value) async {
    isDark.value = value;
    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, isDark.value);
  }

  void back() => Get.back();

  Future<void> onEditProfile() async {
    final result = await Get.to(
      () => const EditProfileScreen(),
      arguments: {
        "username": username.value,
        "email": email.value,
        "phone": phone.value,
        "photoUrl": photoUrl.value,
      },
    );

    if (result is Map) {
      username.value = (result["username"] ?? username.value).toString();
      email.value = (result["email"] ?? email.value).toString();
      phone.value = (result["phone"] ?? phone.value).toString();
      photoUrl.value = (result["photoUrl"] ?? photoUrl.value).toString();
    }
  }

  void onIdentity() => Get.to(CommunityScreen());
  void onPreferences() => Get.to(PhotoReviewScreen());

  void onMyWallet() => Get.to(() => MyWalletScreen());
  void onPaymentMethods() => Get.to(PhotoDetailsScreen());

  void onNotifications() => Get.to(() => const NotificationsSettingsScreen());
  void onSecurity() => Get.to(() => const SecuritySettingsScreen());

  void onTermPolicy() => Get.snackbar('Support', 'Term & Policy');
  void onHelpCenter() => Get.to(JobAssignmentScreen());
  void onLogout() => Get.snackbar('Auth', 'Logout');
}
