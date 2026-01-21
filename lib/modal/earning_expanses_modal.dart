enum ReportRange { thisMonth, last3Months, ytd }

enum ReportMode { earnings, expenses }

class EarningExpansesModal {
  final String title;
  final String meta;
  final double amount;
  final int iconType;
  EarningExpansesModal({
    required this.title,
    required this.meta,
    required this.amount,
    required this.iconType,
  });
}
