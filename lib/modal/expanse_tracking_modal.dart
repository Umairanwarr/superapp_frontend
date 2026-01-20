enum ExpenseTrackingFilter { all, maintenance, utilities, tax }

class ExpenseTrackingModal {
  final String title;
  final String place;
  final String dateText;
  final double amount;
  final ExpenseTrackingFilter category;

  const ExpenseTrackingModal({
    required this.title,
    required this.place,
    required this.dateText,
    required this.amount,
    required this.category,
  });
}
