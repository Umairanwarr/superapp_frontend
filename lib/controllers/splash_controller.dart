import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:superapp/screens/auth/wellcome_screen.dart';
import 'package:superapp/screens/main_screen.dart';
import 'package:superapp/screens/on_boarding_screen.dart';

class SplashController extends GetxController {
  static const _onboardingDoneKey = 'onboarding_done';
  static const _userIdKey = 'user_id';

  @override
  void onInit() {
    super.onInit();
    _nextScreen();
  }

  Future<void> _nextScreen() async {
    await Future.delayed(const Duration(seconds: 4));

    final prefs = await SharedPreferences.getInstance();
    final onboardingDone = prefs.getBool(_onboardingDoneKey) ?? false;
    final userId = prefs.getInt(_userIdKey) ?? 0;

    if (!onboardingDone) {
      // First launch — show onboarding, then mark as done
      await prefs.setBool(_onboardingDoneKey, true);
      Get.offAll(() => const OnboardingScreen());
    } else if (userId > 0) {
      // User is signed in
      Get.offAll(() => const MainScreen());
    } else {
      // User is logged out
      Get.offAll(() => const WellcomeScreen());
    }
  }
}
