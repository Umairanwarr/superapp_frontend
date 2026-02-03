import 'package:get/get.dart';
import 'package:superapp/modal/expanse_tracking_modal.dart';
import 'package:superapp/screens/add_expanse_screen.dart';

class ExpenseTrackingController extends GetxController {
  final selectedFilter = ExpenseTrackingFilter.all.obs;
  final sortNewestFirst = true.obs;

  final totalThisMonth = 4250.00.obs;
  final deltaPercent = (-5.0).obs;

  final txns = <ExpenseTrackingModal>[].obs;

  @override
  void onInit() {
    super.onInit();
    _seed();
  }

  void _seed() {
    txns.assignAll(const [
      ExpenseTrackingModal(
        title: "HVAC Repair",
        place: "Ocean View Apt",
        dateText: "Oct 24",
        amount: -150.00,
        category: ExpenseTrackingFilter.maintenance,
      ),
      ExpenseTrackingModal(
        title: "Water Bill",
        place: "Sunset Villa",
        dateText: "Oct 22",
        amount: -85.50,
        category: ExpenseTrackingFilter.utilities,
      ),
      ExpenseTrackingModal(
        title: "Repainting Hallway",
        place: "Sunset Villa",
        dateText: "Oct 20",
        amount: -400.00,
        category: ExpenseTrackingFilter.maintenance,
      ),
      ExpenseTrackingModal(
        title: "Property Tax Q3",
        place: "Multiple Properties",
        dateText: "Oct 15",
        amount: -1200.00,
        category: ExpenseTrackingFilter.tax,
      ),
    ]);
  }

  void back() => Get.back();

  void setFilter(ExpenseTrackingFilter f) => selectedFilter.value = f;

  void toggleSort() => sortNewestFirst.value = !sortNewestFirst.value;

  void onAddExpense() => Get.to(() => AddExpenseScreen());

  List<ExpenseTrackingModal> get filteredTxns {
    final f = selectedFilter.value;

    final list = f == ExpenseTrackingFilter.all
        ? txns.toList()
        : txns.where((e) => e.category == f).toList();

    if (sortNewestFirst.value) {
      return list;
    } else {
      return list.reversed.toList();
    }
  }

  String get totalFormatted => "\$${totalThisMonth.value.toStringAsFixed(2)}";

  String get deltaText {
    final p = deltaPercent.value.abs().toStringAsFixed(0);
    return "${deltaPercent.value < 0 ? "-" : "+"}$p% vs last month";
  }
}
