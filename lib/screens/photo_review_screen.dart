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
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 6, 8, 10),
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.arrow_back),
                        color: Colors.white,
                      ),
                    ),

                    Text(
                      'Photo Review',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: Obx(() {
                        final pending = controller.pendingCount;
                        if (pending <= 0) return const SizedBox(width: 44);
                        return _PendingBadge(text: '$pending pending');
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),

      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
          child: Column(
            children: [
              SizedBox(height: 20),
              Obx(() {
                final list = controller.items;

                return Column(
                  children: List.generate(list.length, (i) {
                    final item = list[i];
                    final isLast = i == list.length - 1;

                    return Padding(
                      padding: EdgeInsets.only(bottom: isLast ? 0 : 12),
                      child: _ReviewTile(
                        item: item,
                        onTap: () => controller.openItem(item),
                      ),
                    );
                  }),
                );
              }),
              SizedBox(height: 10),

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
          fontSize: 10.5,
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
    final isLight = theme.brightness == Brightness.light;

    final header = item.status.trim().isEmpty
        ? item.title
        : '${item.title}\n${item.status}';

    final tileBg = isLight
        ? const Color(0xFFF3F5F6)
        : cs.onSurface.withOpacity(0.08);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: tileBg,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: cs.onSurface.withOpacity(isLight ? 0.05 : 0.10),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: cs.onSurface.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.photo_camera_outlined,
                  size: 18,
                  color: cs.onSurface.withOpacity(0.45),
                ),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      header,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        height: 1.15,
                        color: cs.onSurface,
                      ),
                    ),
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

                    const SizedBox(height: 6),

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

              const SizedBox(width: 10),
              Icon(
                Icons.chevron_right_rounded,
                size: 22,
                color: cs.onSurface.withOpacity(0.35),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
