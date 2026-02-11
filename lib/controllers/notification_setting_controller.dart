import 'package:get/get.dart';

class NotificationsSettingsController extends GetxController {
  final RxBool messageShow = true.obs;
  final RxBool groupShow = true.obs;

  final RxBool reaction = true.obs;
  final RxBool specialOffers = true.obs;
  final RxBool payments = true.obs;
  final RxBool cashback = false.obs;

  final RxBool showPreview = true.obs;

  final RxString messageSound = 'Note'.obs;
  final RxString groupSound = 'Note'.obs;

  void back() => Get.back();

  void openMessageSoundPicker() {
    Get.snackbar('Sound', 'Message sound picker');
  }

  void openGroupSoundPicker() {
    Get.snackbar('Sound', 'Group sound picker');
  }

  void openInAppNotifications() {
    Get.snackbar('In-App Notifications', 'Open in-app settings');
  }

  void reset() {
    messageShow.value = true;
    groupShow.value = true;

    reaction.value = true;
    specialOffers.value = true;
    payments.value = true;
    cashback.value = false;

    showPreview.value = true;

    messageSound.value = 'Note';
    groupSound.value = 'Note';

    Get.snackbar('Reset', 'Notification settings reset');
  }
}
