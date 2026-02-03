import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superapp/controllers/job_assignment_controller.dart';
import 'package:superapp/modal/job_assignment.modal.dart';

class JobAssignmentScreen extends StatelessWidget {
  const JobAssignmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(JobAssignmentController());
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 170,
              color: theme.colorScheme.primary,
              child: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    const SizedBox(height: 25),

                    Padding(
                      padding: const EdgeInsetsGeometry.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => Get.back(),
                            icon: const Icon(Icons.arrow_back),
                            color: Colors.white,
                          ),

                          Expanded(
                            child: Center(
                              child: Text(
                                'Job Assignment',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),

                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.more_vert),
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: Container(
                        height: 44,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.20),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Obx(() {
                          final selected = controller.selectedTab.value;

                          return Row(
                            children: [
                              Expanded(
                                child: _TabChip(
                                  selected: selected == 0,
                                  label: 'AI Assign',
                                  icon: Icons.auto_awesome_rounded,
                                  onTap: () => controller.onTabTap(0),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: _TabChip(
                                  selected: selected == 1,
                                  label: 'Manual',
                                  icon: Icons.person_outline_rounded,
                                  onTap: () => controller.onTabTap(1),
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 18),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Obx(() {
                final isManual = controller.selectedTab.value == 1;
                if (!isManual) return const SizedBox.shrink();

                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${controller.visibleJobs.length} jobs need assignment',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: Obx(() {
                final items = controller.visibleJobs;
                final showRecommendation = controller.selectedTab.value == 0;

                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 18),
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (_, i) => _JobCard(
                    item: items[i],
                    showRecommendation: showRecommendation,
                    onAssignTap: () => controller.assignJob(items[i]),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabChip extends StatelessWidget {
  const _TabChip({
    required this.selected,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final bool selected;
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final bg = selected ? Colors.white : Colors.transparent;
    final fg = selected ? theme.colorScheme.primary : Colors.white;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: 45,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(14),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: fg),
            const SizedBox(width: 8),
            Text(
              label,
              style: theme.textTheme.labelLarge?.copyWith(
                color: fg,
                fontWeight: FontWeight.w800,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _JobCard extends StatelessWidget {
  const _JobCard({
    required this.item,
    required this.showRecommendation,
    required this.onAssignTap,
  });

  final JobItem item;
  final bool showRecommendation;
  final VoidCallback onAssignTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withOpacity(0.9),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _JobHeader(item: item)),
                const SizedBox(width: 10),
                _PriorityChip(priority: item.priority),
              ],
            ),

            if (showRecommendation && item.recommendation != null) ...[
              const SizedBox(height: 10),
              Divider(color: theme.colorScheme.outlineVariant.withOpacity(0.8)),
              const SizedBox(height: 10),

              Row(
                children: [
                  Icon(
                    Icons.auto_awesome_rounded,
                    size: 16,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'AI Recommendation',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              _RecommendationBox(
                recommendation: item.recommendation!,
                onAssignTap: onAssignTap,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _JobHeader extends StatelessWidget {
  const _JobHeader({required this.item});
  final JobItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Unit ${item.unit}  -  ${item.title}',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w900,
            height: 1.15,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          '${item.location}  •  ${item.timeAgo}',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _PriorityChip extends StatelessWidget {
  const _PriorityChip({required this.priority});
  final JobPriority priority;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isUrgent = priority == JobPriority.urgent;

    final bg = isUrgent
        ? const Color(0xFFFFE9E9)
        : theme.colorScheme.primaryContainer.withOpacity(0.25);

    final fg = isUrgent ? const Color(0xFFE53935) : theme.colorScheme.primary;

    return Container(
      height: 26,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withOpacity(0.8),
          width: 1,
        ),
      ),
      child: Center(
        child: Text(
          isUrgent ? 'Urgent' : 'Normal',
          style: theme.textTheme.labelSmall?.copyWith(
            color: fg,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class _RecommendationBox extends StatelessWidget {
  const _RecommendationBox({
    required this.recommendation,
    required this.onAssignTap,
  });

  final AiRecommendation recommendation;
  final VoidCallback onAssignTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withOpacity(0.35),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withOpacity(0.8),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recommendation.name,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  recommendation.details,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(
            '${recommendation.matchPercent} %',
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            height: 34,
            child: ElevatedButton(
              onPressed: onAssignTap,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Assign'),
            ),
          ),
        ],
      ),
    );
  }
}
