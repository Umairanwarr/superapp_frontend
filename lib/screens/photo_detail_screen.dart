import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superapp/controllers/profile_detail_controller.dart';
import 'package:superapp/main.dart';

class PhotoDetailsScreen extends StatelessWidget {
  const PhotoDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PhotoDetailsController());
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150),
        child: Container(
          color: const Color(0xFF27B9B6),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 14),
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  SizedBox(
                    height: 44,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            onPressed: Get.back,
                            icon: const Icon(Icons.arrow_back),
                            color: Colors.white,
                            splashRadius: 22,
                          ),
                        ),

                        Text(
                          'Photo Details',
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.more_vert),
                            color: Colors.white,
                            splashRadius: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsetsGeometry.symmetric(
                  horizontal: 30,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _CardShell(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => Text(
                              controller.jobTitle.value,
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w800,
                                height: 1.15,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Obx(
                            () => Text(
                              controller.community.value,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurface.withOpacity(
                                  0.55,
                                ),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          Obx(() {
                            final isCompleted =
                                controller.stage.value == JobStage.completed;
                            return Row(
                              children: [
                                Expanded(
                                  child: _Pill(
                                    text: 'Completed',
                                    active: isCompleted,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: _Pill(
                                    text: 'Planning',
                                    active: !isCompleted,
                                  ),
                                ),
                              ],
                            );
                          }),

                          const SizedBox(height: 12),
                          Obx(
                            () => Text(
                              'Assigned Tech: ${controller.assignedTech.value}',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurface.withOpacity(
                                  0.55,
                                ),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    Text(
                      'Photos for Review',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 10),

                    Row(
                      children: [
                        Expanded(
                          child: Obx(
                            () => _PhotoBox(
                              label: 'Before',
                              url: controller.beforePhotoUrl.value,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Obx(
                            () => _PhotoBox(
                              label: 'After',
                              url: controller.afterPhotoUrl.value,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    Text(
                      'Timeline',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 10),

                    _CardShell(
                      padding: EdgeInsets.zero,
                      child: Obx(
                        () => Column(
                          children: List.generate(controller.timeline.length, (
                            i,
                          ) {
                            final item = controller.timeline[i];
                            final isLast = i == controller.timeline.length - 1;
                            return _TimelineRow(
                              title: item.title,
                              timeAgo: item.timeAgo,
                              active: item.isActive,
                              showDivider: !isLast,
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
              child: Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => OutlinedButton.icon(
                        onPressed: controller.isRejecting.value
                            ? null
                            : controller.reject,
                        icon: controller.isRejecting.value
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.close),
                        label: const Text('Reject'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          side: BorderSide(
                            color: isDark
                                ? Colors.white12
                                : const Color(0xFFE1E8E8),
                          ),
                          backgroundColor: theme.cardColor,
                          foregroundColor:
                              theme.textTheme.bodyLarge?.color ?? Colors.black,
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Obx(
                      () => ElevatedButton.icon(
                        onPressed: controller.isApproving.value
                            ? null
                            : controller.approve,
                        icon: controller.isApproving.value
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.check),
                        label: const Text('Approve'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardShell extends StatelessWidget {
  const _CardShell({required this.child, this.padding});

  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
        border: Border.all(
          color: isDark ? Colors.white10 : const Color(0xFFE6ECEC),
        ),
      ),
      child: child,
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.text, required this.active});

  final String text;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bg = active
        ? (isDark ? const Color(0xFF0F3D3C) : const Color(0xFFE8F7F6))
        : (isDark ? const Color(0xFF1C1C1E) : Colors.white);

    final border = active
        ? kPrimaryColor
        : (isDark ? Colors.white12 : const Color(0xFFD6DAE3));

    final fg = active
        ? kPrimaryColor
        : (isDark ? Colors.white70 : const Color(0xFF7A7F8C));

    return Container(
      height: 30,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: border, width: 1),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: theme.textTheme.labelMedium?.copyWith(
          color: fg,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _PhotoBox extends StatelessWidget {
  const _PhotoBox({required this.label, required this.url});

  final String label;
  final String url;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bg = isDark ? const Color(0xFF1C1C1E) : const Color(0xFFF3F5F6);

    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? Colors.white12 : const Color(0xFFE1E8E8),
        ),
      ),
      child: (url.isNotEmpty)
          ? ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.network(
                url,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _PhotoPlaceholder(label: label),
              ),
            )
          : _PhotoPlaceholder(label: label),
    );
  }
}

class _PhotoPlaceholder extends StatelessWidget {
  const _PhotoPlaceholder({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.image_outlined, size: 26, color: Color(0xFF9AA3A7)),
          const SizedBox(height: 6),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: const Color(0xFF9AA3A7),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineRow extends StatelessWidget {
  const _TimelineRow({
    required this.title,
    required this.timeAgo,
    required this.active,
    required this.showDivider,
  });

  final String title;
  final String timeAgo;
  final bool active;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final dotColor = active ? const Color(0xFF2BB673) : const Color(0xFFB6BAC5);
    final titleColor = isDark ? Colors.white : const Color(0xFF2A2F3A);
    final timeColor = isDark ? Colors.white70 : const Color(0xFF7A7F8C);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: titleColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                timeAgo,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: timeColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            thickness: 1,
            color: isDark ? Colors.white10 : const Color(0xFFE6ECEC),
          ),
      ],
    );
  }
}
