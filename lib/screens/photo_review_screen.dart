import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superapp/modal/photo_review_modal.dart';
import '../controllers/photo_review_controller.dart';

class PhotoReviewScreen extends StatelessWidget {
  const PhotoReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = Get.put(PhotoReviewController());

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150),
        child: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: theme.colorScheme.primary,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsGeometry.only(top: 40),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Get.back(),
                          icon: Icon(Icons.arrow_back),
                          color: Colors.white,
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              'Photo Review',
                              style: theme.textTheme.titleLarge?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Obx(() {
                          final pending = controller.pendingCount;
                          if (pending <= 0) return const SizedBox(width: 44);
                          return _PendingBadge(text: '$pending pending');
                        }),
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
        child: Padding(
          padding: const EdgeInsetsGeometry.symmetric(
            horizontal: 30,
            vertical: 10,
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),

              Flexible(
                fit: FlexFit.loose,
                child: Obx(() {
                  final list = controller.items;

                  if (list.isEmpty) {
                    return Center(
                      child: Text(
                        'No pending photo reviews',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurface.withOpacity(0.45),
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 6),
                    itemCount: list.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, i) {
                      final item = list[i];
                      return _ReviewTile(
                        item: item,
                        onTap: () => controller.openItem(item),
                      );
                    },
                  );
                }),
              ),
              SizedBox(height: 20),

              Text(
                'Tap to review & approve photos',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface.withOpacity(0.40),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PendingBadge extends StatelessWidget {
  const _PendingBadge({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFF59E0B),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _ReviewTile extends StatelessWidget {
  const _ReviewTile({required this.item, required this.onTap});

  final PhotoReviewItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final borderColor = isDark ? Colors.white12 : const Color(0xFFE9EEF0);
    final cardColor = isDark ? theme.cardColor : Colors.white;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          height: 110,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: borderColor, width: 1),
            boxShadow: isDark
                ? null
                : const [
                    BoxShadow(
                      color: Color(0x12000000),
                      blurRadius: 18,
                      offset: Offset(0, 10),
                    ),
                  ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: isDark ? Colors.white10 : const Color(0xFFF1F4F6),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isDark ? Colors.white12 : const Color(0xFFE4EAEE),
                  ),
                ),
                child: Icon(
                  Icons.photo_camera_outlined,
                  size: 18,
                  color: cs.onSurface.withOpacity(0.55),
                ),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          height: 1.1,
                          color: cs.onSurface,
                        ),
                      ),
                      SizedBox(height: 5),

                      if (item.status.trim().isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          item.status,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w900,
                            height: 1.1,
                          ),
                        ),
                      ],

                      const SizedBox(height: 6),

                      Row(
                        children: [
                          if (item.albumLine.isNotEmpty)
                            Flexible(
                              child: Text(
                                item.albumLine,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  fontSize: 10.5,
                                  color: cs.onSurface.withOpacity(0.55),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          if (item.albumLine.isNotEmpty)
                            Text(
                              '  •  ',
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontSize: 10.5,
                                color: cs.onSurface.withOpacity(0.35),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          Text(
                            '${item.photos} photos',
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontSize: 10.5,
                              color: cs.onSurface.withOpacity(0.55),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 4),

                      Text(
                        item.metaLine,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontSize: 10.5,
                          color: cs.onSurface.withOpacity(0.45),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 8),
              Icon(
                Icons.chevron_right_rounded,
                size: 22,
                color: cs.onSurface.withOpacity(0.30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
