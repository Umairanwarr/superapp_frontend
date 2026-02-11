import 'package:get/get.dart';

class SecuritySettingsController extends GetxController {
  final rememberMe = true.obs;
  final faceId = true.obs;
  final fingerprint = false.obs;

  void rememberMeButton(bool v) => rememberMe.value = v;
  void faceIdButton(bool v) => faceId.value = v;
  void fingerprintButton(bool v) => fingerprint.value = v;
}
