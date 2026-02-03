import 'package:get/get.dart';
import 'package:superapp/screens/earning_screen.dart';
import 'package:superapp/screens/expanse_tracking_screen.dart';
import 'package:superapp/screens/expanses_screen.dart';
import 'package:superapp/screens/property_analytics_screen.dart';

class DashboardController extends GetxController {
  final totalEarnings = 12450.0.obs;
  final growthPercent = 12.obs;

  final activeListings = 5.obs;
  final pendingRequestsBadge = 'Action needed'.obs;

  void onViewReport() => Get.snackbar('Report', 'View Report');
  void onTotalEarnings() => Get.snackbar('Earnings', 'Total Earnings');
  void onActiveListings() => Get.snackbar('Listings', 'Active Listings');
  void onPendingRequests() => Get.snackbar('Requests', 'Pending Requests');

  void onMyListings() => Get.to(() => ExpenseTrackingScreen());
  void onEarnings() => Get.to(() => EarningsScreen());
  void onExpenses() => Get.to(() => ExpensesScreen());
  void onAnalytics() => Get.to(() => PropertyAnalyticsScreen());

  String get earningsFormatted {
    final v = totalEarnings.value.toStringAsFixed(0);
    return '\$${v.replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}';
  }

  String get growthText => '+${growthPercent.value}%';
}
