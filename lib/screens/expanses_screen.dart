import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superapp/controllers/earning_expanses_controller.dart';
import 'package:superapp/modal/earning_expanses_modal.dart';
import 'package:superapp/widgets/earning_expanses.dart';

class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(
      EarningExpansesController(mode: ReportMode.expenses),
      tag: 'expenses',
    );

    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(child: EarningExpansesWidget(tag: 'expenses')),
    );
  }
}
