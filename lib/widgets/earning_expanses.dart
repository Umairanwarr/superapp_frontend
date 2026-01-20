import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superapp/controllers/earning_expanses_controller.dart';
import 'package:superapp/modal/earning_expanses_modal.dart';

class EarningExpansesWidget extends StatelessWidget {
  const EarningExpansesWidget({super.key, required this.tag});

  final String tag;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EarningExpansesController>(tag: tag);
    final theme = Theme.of(context);

    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 110),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: controller.back,
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 20,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 2),
                  Expanded(
                    child: Text(
                      controller.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Obx(
                () => _RangeTabs(
                  selected: controller.range.value,
                  onTap: controller.setRange,
                ),
              ),

              const SizedBox(height: 14),

              Obx(
                () => _TotalCard(
                  label: controller.totalLabel,
                  total: controller.totalFormatted,
                  positive: controller.percent.value >= 0,
                  percentText: controller.percentText,
                ),
              ),

              const SizedBox(height: 14),

              Obx(
                () => _TrendCard(
                  title: controller.trendLabel,
                  positive: controller.percent.value >= 0,
                  bars: controller.bars,
                ),
              ),

              const SizedBox(height: 16),

              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Text(
                      "Recent Transactions",
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: const Color(0xFF1D2330),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: controller.onViewAll,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        "View All",
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              Obx(
                () => Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
                  child: Column(
                    children: controller.txns
                        .map(
                          (t) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: _TxnTile(txn: t, positive: t.amount >= 0),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),

        Align(
          alignment: Alignment.bottomCenter,
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsetsGeometry.symmetric(
                horizontal: 30,
                vertical: 15,
              ),
              child: SizedBox(
                height: 52,
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: controller.onExport,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  icon: const Icon(Icons.download_rounded, size: 18),
                  label: Text(
                    "Export Full Report",
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _RangeTabs extends StatelessWidget {
  const _RangeTabs({required this.selected, required this.onTap});

  final ReportRange selected;
  final ValueChanged<ReportRange> onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget pill(String text, ReportRange v) {
      final isSel = selected == v;
      return Expanded(
        child: InkWell(
          borderRadius: BorderRadius.circular(999),
          onTap: () => onTap(v),
          child: Container(
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSel ? theme.colorScheme.primary : Colors.white,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: isSel
                    ? theme.colorScheme.primary
                    : const Color(0xFFE6E9F0),
                width: 1,
              ),
            ),
            child: Text(
              text,
              style: theme.textTheme.labelMedium?.copyWith(
                color: isSel ? Colors.white : const Color(0xFF1D2330),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      );
    }

    return Row(
      children: [
        pill("This Month", ReportRange.thisMonth),
        const SizedBox(width: 10),
        pill("Last 3 Months", ReportRange.last3Months),
        const SizedBox(width: 10),
        pill("Year to Date", ReportRange.ytd),
      ],
    );
  }
}

class _TotalCard extends StatelessWidget {
  const _TotalCard({
    required this.label,
    required this.total,
    required this.positive,
    required this.percentText,
  });

  final String label;
  final String total;
  final bool positive;
  final String percentText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final chipBg = positive ? const Color(0xFFE9F7EC) : const Color(0xFFFFECEC);
    final chipFg = positive ? const Color(0xFF22C55E) : const Color(0xFFEF4444);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEDEFF5)),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: const Color(0xFF9AA0AF),
              fontWeight: FontWeight.w800,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            total,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: const Color(0xFF1D2330),
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 26,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: chipBg,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  positive
                      ? Icons.arrow_upward_rounded
                      : Icons.arrow_downward_rounded,
                  size: 14,
                  color: chipFg,
                ),
                const SizedBox(width: 6),
                Text(
                  percentText,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: chipFg,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TrendCard extends StatelessWidget {
  const _TrendCard({
    required this.title,
    required this.positive,
    required this.bars,
  });

  final String title;
  final bool positive;
  final List<double> bars;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final barLight = positive
        ? const Color(0xFFDFF7E6)
        : const Color(0xFFFFD6DA);
    final barDark = positive
        ? const Color(0xFF22C55E)
        : const Color(0xFFEF4444);

    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 15),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFEDEFF5)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: const Color(0xFF1D2330),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Spacer(),
                Container(
                  height: 26,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: const Color(0xFFE6E9F0)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.calendar_month_outlined,
                        size: 14,
                        color: Color(0xFF9AA0AF),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "Oct 1 - Oct 31",
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: const Color(0xFF9AA0AF),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            SizedBox(
              height: 100,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final maxBarHeight = constraints.maxHeight - 26;

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List.generate(bars.length, (i) {
                      final h = (bars[i].clamp(0.1, 1.0)) * maxBarHeight;
                      final isActive = i == 1;

                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height: h,
                                decoration: BoxDecoration(
                                  color: isActive ? barDark : barLight,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),

                              const SizedBox(height: 6),

                              Text(
                                "W${i + 1}",
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: isActive
                                      ? const Color(0xFF1D2330)
                                      : const Color(0xFF9AA0AF),
                                  fontWeight: isActive
                                      ? FontWeight.w800
                                      : FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TxnTile extends StatelessWidget {
  const _TxnTile({required this.txn, required this.positive});

  final EarningExpansesModal txn;
  final bool positive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    IconData iconFromType(int t) {
      switch (t) {
        case 0:
          return Icons.home_outlined;
        case 1:
          return Icons.flash_on_outlined;

        case 2:
          return Icons.shopping_bag_outlined;
        case 3:
          return Icons.local_gas_station_outlined;
        default:
          return Icons.receipt_long_outlined;
      }
    }

    final amountColor = positive
        ? const Color(0xFF22C55E)
        : const Color(0xFFEF4444);
    final amountText =
        "${positive ? "+" : "-"}\$${txn.amount.abs().toStringAsFixed(2)}";

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEDEFF5)),
      ),
      child: Row(
        children: [
          Icon(iconFromType(txn.iconType), size: 18, color: Color(0xFF1D2330)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  txn.title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: const Color(0xFF1D2330),
                    fontWeight: FontWeight.w600,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  txn.meta,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: const Color(0xFF9AA0AF),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          Text(
            amountText,
            style: theme.textTheme.titleSmall?.copyWith(
              color: amountColor,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right_rounded, color: Color(0xFF9AA0AF)),
        ],
      ),
    );
  }
}
