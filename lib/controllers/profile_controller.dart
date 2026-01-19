import 'package:get/get.dart';
import 'package:superapp/screens/bottomNavScreens/edit_profile_screen.dart';
import 'package:superapp/screens/notification_setting_screen.dart';
import 'package:superapp/screens/security_setting_screen.dart';

class ProfileController extends GetxController {
  final bookings = 12.obs;
  final reviews = 8.obs;
  final points = 100.obs;

  final username = 'Alex Hales'.obs;
  final email = 'alex@gmail.com'.obs;
  final phone = '+14987889999'.obs;
  final photoUrl = ''.obs;

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

  void onIdentity() => Get.snackbar('Account', 'Identity Verification');
  void onPreferences() => Get.snackbar('Account', 'Preferences');

  void onMyWallet() => Get.snackbar('Wallet', 'My Wallet');
  void onPaymentMethods() => Get.snackbar('Wallet', 'Payment Methods');

  void onNotifications() => Get.to(() => const NotificationsSettingsScreen());
  void onSecurity() => Get.to(() => const SecuritySettingsScreen());

  void onTermPolicy() => Get.snackbar('Settings', 'Term & Policy');
  void onHelpCenter() => Get.snackbar('Support', 'Help Center');
  void onLogout() => Get.snackbar('Auth', 'Logout');
}
