import 'package:get/get.dart';

enum AnalyticsRange { thisMonth, last3Months, ytd }

class PropertyAnalyticsController extends GetxController {
  final range = AnalyticsRange.thisMonth.obs;

  final occupancy = 82.0.obs;
  final occupancyDelta = 4.7.obs;

  final yieldValue = 5.4.obs;
  final yieldDelta = 0.2.obs;

  final viewings = 12.obs;

  final avgStay = 4.2.obs;
  final avgStayDelta = 0.4.obs;

  final occupancyTrend = <double>[0.38, 0.56, 0.72, 0.70].obs;

  final netIncome = 4250.0.obs;
  final netIncomeDelta = 12.0.obs;

  final grossValue = 3200.0.obs;
  final netValue = 4200.0.obs;

  void back() => Get.back();

  void setRange(AnalyticsRange v) {
    range.value = v;
    _seedByRange(v);
  }

  void _seedByRange(AnalyticsRange r) {
    if (r == AnalyticsRange.thisMonth) {
      occupancy.value = 82;
      occupancyDelta.value = 4.7;

      yieldValue.value = 5.4;
      yieldDelta.value = 0.2;

      viewings.value = 12;

      avgStay.value = 4.2;
      avgStayDelta.value = 0.4;

      occupancyTrend.assignAll([0.38, 0.56, 0.72, 0.70]);

      netIncome.value = 4250;
      netIncomeDelta.value = 12;

      grossValue.value = 3200;
      netValue.value = 4200;
    } else if (r == AnalyticsRange.last3Months) {
      occupancy.value = 78;
      occupancyDelta.value = 2.1;

      yieldValue.value = 5.2;
      yieldDelta.value = 0.1;

      viewings.value = 34;

      avgStay.value = 4.0;
      avgStayDelta.value = 0.2;

      occupancyTrend.assignAll([0.30, 0.48, 0.63, 0.59]);

      netIncome.value = 11850;
      netIncomeDelta.value = 8;

      grossValue.value = 9500;
      netValue.value = 11200;
    } else {
      occupancy.value = 74;
      occupancyDelta.value = 1.4;

      yieldValue.value = 5.1;
      yieldDelta.value = 0.0;

      viewings.value = 120;

      avgStay.value = 3.9;
      avgStayDelta.value = 0.1;

      occupancyTrend.assignAll([0.22, 0.40, 0.55, 0.52]);

      netIncome.value = 38200;
      netIncomeDelta.value = 10;

      grossValue.value = 31000;
      netValue.value = 36200;
    }
  }

  void onExport() {}
}
