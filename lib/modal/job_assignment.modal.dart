// job_assignment_modal.dart
enum JobPriority { urgent, normal }

class AiRecommendation {
  final String name;
  final String details;
  final int matchPercent;

  const AiRecommendation({
    required this.name,
    required this.details,
    required this.matchPercent,
  });
}

class JobItem {
  final String unit;
  final String title;
  final String location;
  final String timeAgo;
  final JobPriority priority;
  final AiRecommendation? recommendation;

  const JobItem({
    required this.unit,
    required this.title,
    required this.location,
    required this.timeAgo,
    required this.priority,
    this.recommendation,
  });
}
