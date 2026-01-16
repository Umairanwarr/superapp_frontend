import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:superapp/screens/auth/wellcome_screen.dart';
import 'package:superapp/screens/on_boarding_screen.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _nextScreen();
  }

  Future<void> _nextScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    final prefs = await SharedPreferences.getInstance();
    final isOnboardingSeen = prefs.getBool("onboarding_done") ?? false;

    if (isOnboardingSeen) {
      Get.offAll(() => WellcomeScreen());
    } else {
      Get.offAll(() => const OnboardingScreen());
    }
  }
}
