import 'package:get/get.dart';
import 'package:superapp/modal/my_wallet_modal.dart';

class MyWalletController extends GetxController {
  final balance = 4250.00.obs;
  final deltaPercent = (-5.0).obs;

  final txns = <MyWalletModal>[].obs;

  @override
  void onInit() {
    super.onInit();
    txns.assignAll(const [
      MyWalletModal(
        title: "Hotel Grand Stay",
        meta: "Today, 10:23 AM",
        amount: -120.00,
        iconType: 0,
      ),
      MyWalletModal(
        title: "Wallet Top Up",
        meta: "Yesterday, 4:00 PM",
        amount: 500.00,
        iconType: 1,
      ),
      MyWalletModal(
        title: "Refund: Property Viewing",
        meta: "Nov 12, 09:30 AM",
        amount: 50.00,
        iconType: 2,
      ),
    ]);
  }

  void back() => Get.back();

  void onTopUp() {}
  void onWithdraw() {}
  void onScan() {}
  void onMore() {}
  void onSeeAll() {}

  String get balanceFormatted => "\$${balance.value.toStringAsFixed(2)}";

  String get deltaText {
    final p = deltaPercent.value.abs().toStringAsFixed(0);
    return "${deltaPercent.value < 0 ? "-" : "+"}$p% vs last month";
  }
}
