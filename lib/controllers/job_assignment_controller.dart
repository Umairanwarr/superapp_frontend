// job_assignment_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superapp/modal/job_assignment.modal.dart';

class JobAssignmentController extends GetxController {
  final selectedTab = 0.obs;

  final jobs = <JobItem>[
    JobItem(
      unit: '84',
      title: 'Leak Repair',
      location: 'Maple Heights',
      timeAgo: '2h ago',
      priority: JobPriority.urgent,
      recommendation: AiRecommendation(
        name: 'Mike R.',
        details: 'Plumb expert,\n5km away',
        matchPercent: 95,
      ),
    ),
    JobItem(
      unit: '12A',
      title: 'HVAC\nMaintenance',
      location: 'Oak Plaza',
      timeAgo: '5h ago',
      priority: JobPriority.normal,
      recommendation: AiRecommendation(
        name: 'Sarah L.',
        details: 'HVAC certified,\navailable now',
        matchPercent: 88,
      ),
    ),
    JobItem(
      unit: '7C',
      title: 'Lock\nReplacement',
      location: 'Pine Court',
      timeAgo: '1d ago',
      priority: JobPriority.normal,
      recommendation: AiRecommendation(
        name: 'Tom K.',
        details: 'Same performance,\nnearby',
        matchPercent: 82,
      ),
    ),
  ].obs;

  List<JobItem> get visibleJobs => jobs;

  void onTabTap(int index) => selectedTab.value = index;

  void assignJob(JobItem job) {
    Get.snackbar(
      'Assigned',
      'Unit ${job.unit} assigned successfully',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(12),
    );
  }
}
