import 'package:get/get.dart';
import 'package:superapp/screens/on_boarding_screen.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _nextScreen();
  }

  void _nextScreen() async {
    await Future.delayed(Duration(seconds: 3));
    Get.off(() => OnboardingScreen());
  }
}
