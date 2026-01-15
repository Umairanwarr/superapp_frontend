import 'package:get/get.dart';
import 'package:superapp/screens/auth/signin_screen.dart';
import 'package:superapp/screens/auth/signup_screen.dart';

class WelcomeController extends GetxController {
  void goToSignup() => Get.to(() => SignupScreen());

  void goToLogin() => Get.to(() => SignInScreen());
}
