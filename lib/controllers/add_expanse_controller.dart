import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddExpenseController extends GetxController {
  final amountCtrl = TextEditingController(text: "0.00");
  final descCtrl = TextEditingController();

  final property = ''.obs;
  final category = ''.obs;
  final date = ''.obs;
  final receiptName = ''.obs;

  final properties = <String>[
    "Sunset Villa",
    "Ocean View Apt",
    "Downtown Apartment",
  ];

  final categories = <String>["Maintenance", "Utilities", "Tax"];

  void back() => Get.back();

  void pickProperty(String v) => property.value = v;
  void pickCategory(String v) => category.value = v;

  void pickDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
      initialDate: now,
    );
    if (picked == null) return;
    date.value =
        "${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}/${picked.year}";
  }

  void pickReceipt() {
    receiptName.value = "receipt_oct_24.pdf";
  }

  void saveExpense() {
    Get.snackbar("Saved", "Expense saved successfully");
    Get.back();
  }

  @override
  void onClose() {
    amountCtrl.dispose();
    descCtrl.dispose();
    super.onClose();
  }
}
