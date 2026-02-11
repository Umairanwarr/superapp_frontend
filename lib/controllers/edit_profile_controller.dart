import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:superapp/controllers/profile_controller.dart';
import 'package:superapp/services/auth_service.dart';

class EditProfileController extends GetxController {
  final usernameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();

  final photoUrl = ''.obs;
  final localPhotoPath = ''.obs; // For local file picked from gallery/camera
  final isLoading = false.obs;

  final _authService = AuthService();
  final _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();

    // Load from ProfileController (persisted data)
    final profile = Get.find<ProfileController>();
    usernameCtrl.text = profile.username.value;
    emailCtrl.text = profile.email.value;
    phoneCtrl.text = profile.phone.value;
    photoUrl.value = profile.photoUrl.value;
  }

  void back() => Get.back();

  void changePicture() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Get.theme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Change Profile Picture',
              style: Get.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: Icon(
                Icons.camera_alt_rounded,
                color: Get.theme.colorScheme.primary,
              ),
              title: const Text('Take a Photo'),
              onTap: () {
                Get.back();
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.photo_library_rounded,
                color: Get.theme.colorScheme.primary,
              ),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Get.back();
                _pickImage(ImageSource.gallery);
              },
            ),
            if (photoUrl.value.isNotEmpty || localPhotoPath.value.isNotEmpty)
              ListTile(
                leading: const Icon(Icons.delete_rounded, color: Colors.red),
                title: const Text(
                  'Remove Photo',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  Get.back();
                  photoUrl.value = '';
                  localPhotoPath.value = '';
                },
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final picked = await _picker.pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 80,
      );
      if (picked != null) {
        localPhotoPath.value = picked.path;
        // For now store the local path; in production you'd upload to a storage service
        // and get back a URL
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: $e');
    }
  }

  Future<void> updateProfile() async {
    final profile = Get.find<ProfileController>();

    if (profile.userId == 0) {
      Get.snackbar(
        'Error',
        'Please sign out and sign in again to enable profile editing.',
      );
      return;
    }

    isLoading.value = true;
    try {
      // Split name into first/last
      final nameParts = usernameCtrl.text.trim().split(' ');
      final fName = nameParts.first;
      final lName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

      final result = await _authService.editUserProfile(
        userId: profile.userId,
        fullName: usernameCtrl.text.trim(),
        firstName: fName,
        lastName: lName,
        email: emailCtrl.text.trim(),
        phoneNumber: phoneCtrl.text.trim(),
        // avatar: would be a URL after uploading the image
      );

      // Update global ProfileController with response data
      await profile.saveUserData(
        name: result['fullName'] ?? usernameCtrl.text.trim(),
        userEmail: result['email'] ?? emailCtrl.text.trim(),
        userPhone: result['phoneNumber'] ?? phoneCtrl.text.trim(),
        userFirstName: result['firstName'] ?? fName,
        userPhotoUrl: result['avatar'] ?? '',
      );

      Get.back();
      Get.snackbar('Success', 'Profile updated successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString().replaceFirst('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    usernameCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
    super.onClose();
  }
}
