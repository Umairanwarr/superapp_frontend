class TimeLineModal {
  final String title;
  final String timeAgo;
  final bool isActive;

  TimeLineModal({
    required this.title,
    required this.timeAgo,
    this.isActive = false,
  });
}
