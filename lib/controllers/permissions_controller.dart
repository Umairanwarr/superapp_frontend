import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modal/permission_step_modal.dart';
import '../screens/main_screen.dart';

class PermissionsController extends GetxController {
  late final PageController pageController;

  final RxInt currentIndex = 0.obs;

  final List<PermissionStepModal> steps = const [
    PermissionStepModal(
      title: 'Enable your location',
      description: 'Choose your location to start find the request around you',
      primaryButtonText: 'Use my location',
      assetPath: 'assets/location.png',
    ),
    PermissionStepModal(
      title: 'Camera Access Needed',
      description:
          'We need access to your camera to enable AR experiences in the app.',
      primaryButtonText: 'Allow Camera',
      assetPath: 'assets/camera.png',
    ),
    PermissionStepModal(
      title: 'Stay in the Loop',
      description: "We'd love to send you updates and important alerts.",
      primaryButtonText: 'Enable Notifications',
      assetPath: 'assets/notification.png',
    ),
  ];

  @override
  void onInit() {
    pageController = PageController();
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void onPrimaryPressed() {
    _goNext();
  }

  void onSkipPressed() {
    _goNext();
  }

  void onPageChanged(int index) {
    currentIndex.value = index;
  }

  void _goNext() {
    final next = currentIndex.value + 1;

    if (next >= steps.length) {
      Get.offAll(() => const MainScreen());
      return;
    }

    currentIndex.value = next;
    pageController.animateToPage(
      next,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
