import 'package:get/get.dart';
import 'package:superapp/screens/on_boarding_screen.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _nextScreen();
  }

  Future<void> _nextScreen() async {
    await Future.delayed(const Duration(seconds: 4));
    Get.offAll(() => const OnboardingScreen());
  }
}
