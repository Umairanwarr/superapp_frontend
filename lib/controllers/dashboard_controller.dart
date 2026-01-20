import 'package:get/get.dart';

class DashboardController extends GetxController {
  final totalEarnings = 12450.0.obs;
  final growthPercent = 12.obs;

  final activeListings = 5.obs;
  final pendingRequestsBadge = 'Action needed'.obs;

  void onViewReport() => Get.snackbar('Report', 'View Report');
  void onTotalEarnings() => Get.snackbar('Earnings', 'Total Earnings');
  void onActiveListings() => Get.snackbar('Listings', 'Active Listings');
  void onPendingRequests() => Get.snackbar('Requests', 'Pending Requests');

  void onMyListings() => Get.snackbar('My Listings', 'Open My Listings');
  void onEarnings() => Get.snackbar('Earnings', 'Open Earnings');
  void onExpenses() => Get.snackbar('Expenses', 'Open Expenses');
  void onAnalytics() => Get.snackbar('Analytics', 'Open Analytics');

  String get earningsFormatted {
    final v = totalEarnings.value.toStringAsFixed(0);
    return '\$${v.replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}';
  }

  String get growthText => '+${growthPercent.value}%';
}
