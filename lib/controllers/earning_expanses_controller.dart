import 'package:get/get.dart';
import 'package:superapp/modal/earning_expanses_modal.dart';

class EarningExpansesController extends GetxController {
  EarningExpansesController({required this.mode});

  final ReportMode mode;

  final range = ReportRange.thisMonth.obs;

  final total = 2540.00.obs;
  final percent = 0.08.obs;

  final bars = <double>[0.55, 0.90, 0.62, 0.62, 0.58].obs;

  final txns = <EarningExpansesModal>[].obs;

  bool get isExpense => mode == ReportMode.expenses;

  @override
  void onInit() {
    super.onInit();
    _seedData();
  }

  void _seedData() {
    if (isExpense) {
      percent.value = -0.08;
      txns.assignAll([
        EarningExpansesModal(
          title: "Grocery\nShopping",
          meta: "Oct 24  •  REF-4521",
          amount: -150.80,
          iconType: 2,
        ),
        EarningExpansesModal(
          title: "Electric Bill",
          meta: "Oct 22  •  REF-4516",
          amount: -89.50,
          iconType: 1,
        ),
        EarningExpansesModal(
          title: "Gas Station",
          meta: "Oct 20  •  REF-4515",
          amount: -65.00,
          iconType: 3,
        ),
      ]);
    } else {
      percent.value = 0.08;
      txns.assignAll([
        EarningExpansesModal(
          title: "Sea Side\nVilla",
          meta: "Oct 24  •  REF-4521",
          amount: 556.80,
          iconType: 0,
        ),
        EarningExpansesModal(
          title: "Downtown Apartment",
          meta: "Oct 22  •  REF-4516",
          amount: 89.50,
          iconType: 1,
        ),
        EarningExpansesModal(
          title: "Sea Side Villa",
          meta: "Oct 20  •  REF-4515",
          amount: 65.00,
          iconType: 0,
        ),
      ]);
    }
  }

  String get title => isExpense ? "Expenses" : "Earnings";
  String get totalLabel => isExpense ? "TOTAL EXPENSES" : "TOTAL EARNINGS";
  String get trendLabel => isExpense ? "Expense Trend" : "Earning Trend";

  String get rangeText {
    switch (range.value) {
      case ReportRange.thisMonth:
        return "This Month";
      case ReportRange.last3Months:
        return "Last 3 Months";
      case ReportRange.ytd:
        return "Year to Date";
    }
  }

  String get totalFormatted => "\$${total.value.toStringAsFixed(2)}";
  String get percentText {
    final p = (percent.value * 100).abs().toStringAsFixed(0);
    return "${percent.value >= 0 ? "+" : "-"}$p% vs last month";
  }

  void setRange(ReportRange v) => range.value = v;

  void back() => Get.back();

  void onViewAll() {}
  void onExport() {}
}
