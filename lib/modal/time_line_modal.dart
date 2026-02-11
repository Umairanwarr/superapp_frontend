class TimeLineModal {
  final String title;
  final String timeAgo;
  bool isActive;

  TimeLineModal({
    required this.title,
    required this.timeAgo,
    this.isActive = false,
  });
}
