import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:superapp/screens/admin/admin_dashboard_screen.dart';
import 'package:superapp/screens/bottomNavScreen/edit_profile_screen.dart';
import 'package:superapp/screens/my_wallet_screen.dart';
import 'package:superapp/screens/notification_setting_screen.dart';
import 'package:superapp/screens/photo_detail_screen.dart';
import 'package:superapp/screens/security_setting_screen.dart';
import 'package:superapp/screens/auth/wellcome_screen.dart';

class ProfileController extends GetxController {
  final bookings = 12.obs;
  final reviews = 8.obs;
  final points = 100.obs;

  final username = ''.obs;
  final email = ''.obs;
  final phone = ''.obs;
  final photoUrl = ''.obs;
  final firstName = ''.obs;

  // Auth data
  int userId = 0;
  String token = '';

  static const _themeKey = 'is_dark_mode';
  static const _usernameKey = 'user_username';
  static const _emailKey = 'user_email';
  static const _phoneKey = 'user_phone';
  static const _photoUrlKey = 'user_photo_url';
  static const _firstNameKey = 'user_first_name';
  static const _userIdKey = 'user_id';
  static const _tokenKey = 'user_token';

  final isDark = true.obs;

  @override
  void onInit() {
    super.onInit();
    _loadTheme();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    username.value = prefs.getString(_usernameKey) ?? '';
    email.value = prefs.getString(_emailKey) ?? '';
    phone.value = prefs.getString(_phoneKey) ?? '';
    photoUrl.value = prefs.getString(_photoUrlKey) ?? '';
    firstName.value = prefs.getString(_firstNameKey) ?? '';
    userId = prefs.getInt(_userIdKey) ?? 0;
    token = prefs.getString(_tokenKey) ?? '';
  }

  Future<void> saveUserData({
    String? name,
    String? userEmail,
    String? userPhone,
    String? userPhotoUrl,
    String? userFirstName,
    int? id,
    String? userToken,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    if (name != null && name.isNotEmpty) {
      username.value = name;
      await prefs.setString(_usernameKey, name);
    }
    if (userEmail != null && userEmail.isNotEmpty) {
      email.value = userEmail;
      await prefs.setString(_emailKey, userEmail);
    }
    if (userPhone != null && userPhone.isNotEmpty) {
      phone.value = userPhone;
      await prefs.setString(_phoneKey, userPhone);
    }
    if (userPhotoUrl != null && userPhotoUrl.isNotEmpty) {
      photoUrl.value = userPhotoUrl;
      await prefs.setString(_photoUrlKey, userPhotoUrl);
    }
    if (userFirstName != null && userFirstName.isNotEmpty) {
      firstName.value = userFirstName;
      await prefs.setString(_firstNameKey, userFirstName);
    }
    if (id != null && id > 0) {
      userId = id;
      await prefs.setInt(_userIdKey, id);
    }
    if (userToken != null && userToken.isNotEmpty) {
      token = userToken;
      await prefs.setString(_tokenKey, userToken);
    }
  }

  /// Returns the display name: firstName if available, else username, else 'User'
  String get displayName {
    if (firstName.value.isNotEmpty) return firstName.value;
    if (username.value.isNotEmpty) return username.value;
    return 'User';
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
    await Get.to(() => const EditProfileScreen());
  }

  void onIdentity() => Get.snackbar('Support', 'Community');
  void onPreferences() => Get.snackbar('Support', 'Photo Review');

  void onMyWallet() => Get.to(() => MyWalletScreen());
  void onPaymentMethods() => Get.to(PhotoDetailsScreen());

  void onNotifications() => Get.to(() => const NotificationsSettingsScreen());
  void onSecurity() => Get.to(() => const SecuritySettingsScreen());

  void onTermPolicy() => Get.snackbar('Support', 'Term & Policy');
  void onHelpCenter() => Get.snackbar('Support', 'Help Center');
  Future<void> onLogout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_usernameKey);
    await prefs.remove(_emailKey);
    await prefs.remove(_phoneKey);
    await prefs.remove(_photoUrlKey);
    await prefs.remove(_firstNameKey);
    await prefs.remove(_userIdKey);
    await prefs.remove(_tokenKey);

    username.value = '';
    email.value = '';
    phone.value = '';
    photoUrl.value = '';
    firstName.value = '';
    userId = 0;
    token = '';

    Get.offAll(() => const WellcomeScreen());
  }

  void onAdminDashboard() => Get.to(() => const AdminDashboardScreen());
}
