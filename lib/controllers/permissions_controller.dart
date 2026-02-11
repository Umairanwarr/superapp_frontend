import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../modal/permission_step_modal.dart';
import '../screens/main_screen.dart';

class PermissionsController extends GetxController {
  late final PageController pageController;

  final RxInt currentIndex = 0.obs;

  final List<PermissionStepModal> steps = [
    const PermissionStepModal(
      title: 'Enable your location',
      description: 'Choose your location to start find the request around you',
      primaryButtonText: 'Use my location',
      assetPath: 'assets/location.png',
    ),
    const PermissionStepModal(
      title: 'Camera Access Needed',
      description:
          'We need access to your camera to enable AR experiences in the app.',
      primaryButtonText: 'Allow Camera',
      assetPath: 'assets/camera.png',
    ),
    const PermissionStepModal(
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
    _checkPermission(currentIndex.value);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void onPrimaryPressed() async {
    final index = currentIndex.value;
    Permission permission;

    if (index == 0) {
      permission = Permission.location;
    } else if (index == 1) {
      permission = Permission.camera;
    } else {
      permission = Permission.notification;
    }

    final status = await permission.request();
    if (status.isGranted) {
      _goNext();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  void onSkipPressed() {
    _goNext();
  }

  void onPageChanged(int index) {
    currentIndex.value = index;
    _checkPermission(index);
  }

  Future<void> _checkPermission(int index) async {
    Permission permission;
    if (index >= steps.length) return;

    if (index == 0) {
      permission = Permission.location;
    } else if (index == 1) {
      permission = Permission.camera;
    } else {
      permission = Permission.notification;
    }

    if (await permission.isGranted) {
      _goNext();
    }
  }

  void _goNext() {
    final next = currentIndex.value + 1;

    if (next >= steps.length) {
      Get.offAll(() => const MainScreen());
      return;
    }

    currentIndex.value = next;
    // Check next permission immediately to auto-skip if granted
    _checkPermission(next).then((_) {
      // Only animate if we haven't skipped past the end
      if (currentIndex.value < steps.length && pageController.hasClients) {
        pageController.animateToPage(
          currentIndex.value,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      } else if (currentIndex.value >= steps.length) {
        Get.offAll(() => const MainScreen());
      }
    });
  }
}
