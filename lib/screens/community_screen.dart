import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superapp/modal/community_post_modal.dart';
import '../controllers/community_controller.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CommunityController());
    final theme = Theme.of(context);

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
                              'Community',
                              style: theme.textTheme.titleLarge?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
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
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsetsGeometry.only(left: 20),
              child: Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Text(
                  'Community',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: EdgeInsetsGeometry.only(left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Connect with owners & staff',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Obx(
                () => _TabsCard(
                  value: controller.tabIndex.value,
                  items: controller.tabs,
                  onChanged: controller.setTab,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: Obx(() {
                final list = controller.visiblePosts;
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 18),
                  itemCount: list.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final post = list[index];
                    return _CommunityPostCard(
                      post: post,
                      isLiked: controller.isLiked(post.id),
                      onLike: () => controller.toggleLike(post.id),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabsCard extends StatelessWidget {
  const _TabsCard({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final int value;
  final List<String> items;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      height: 50,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: isDark
            ? null
            : const [
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 18,
                  offset: Offset(0, 8),
                ),
              ],
        border: Border.all(
          color: isDark ? Colors.white10 : const Color(0xFFF2F2F2),
        ),
      ),
      child: Row(
        children: List.generate(items.length, (i) {
          final selected = i == value;
          return Expanded(
            child: InkWell(
              onTap: () => onChanged(i),
              borderRadius: BorderRadius.circular(14),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOut,
                height: 50,
                decoration: BoxDecoration(
                  color: selected ? cs.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                child: Text(
                  items[i],
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: selected ? Colors.white : cs.onSurface,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _CommunityPostCard extends StatelessWidget {
  const _CommunityPostCard({
    required this.post,
    required this.isLiked,
    required this.onLike,
  });

  final CommunityPost post;
  final bool isLiked;
  final VoidCallback onLike;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final roleStyle = _roleChipStyle(post.role, cs);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: isDark
            ? null
            : const [
                BoxShadow(
                  color: Color(0x0F000000),
                  blurRadius: 16,
                  offset: Offset(0, 8),
                ),
              ],
        border: Border.all(
          color: isDark ? Colors.white10 : const Color(0xFFF2F2F2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: post.avatarColor,
                child: Text(
                  post.initial,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            post.name,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: roleStyle.bg,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            post.role,
                            style: theme.textTheme.labelSmall?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: roleStyle.fg,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      post.timeAgo,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: cs.onSurface.withOpacity(0.45),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Text(
            post.message,
            style: theme.textTheme.bodyMedium?.copyWith(
              height: 1.35,
              color: cs.onSurface.withOpacity(0.78),
              fontWeight: FontWeight.w500,
            ),
          ),

          if (post.linkText != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: cs.primary.withOpacity(isDark ? 0.20 : 0.10),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: cs.primary.withOpacity(0.25)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.link_rounded, size: 18, color: cs.primary),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      post.linkText!,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: cs.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 12),

          Row(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: onLike,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 4,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isLiked
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        size: 18,
                        color: isLiked
                            ? cs.primary
                            : cs.onSurface.withOpacity(0.55),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${post.likes}',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: cs.onSurface.withOpacity(0.55),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 14),
              _IconCount(
                icon: Icons.mode_comment_outlined,
                count: post.replies,
                label: 'replies',
              ),
              const Spacer(),
              Icon(
                Icons.ios_share_rounded,
                size: 20,
                color: cs.onSurface.withOpacity(0.55),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _RoleStyle _roleChipStyle(String role, ColorScheme cs) {
    if (role.toLowerCase() == 'staff') {
      return const _RoleStyle(bg: Color(0xFFE8FBF4), fg: Color(0xFF13B07D));
    }
    return _RoleStyle(bg: cs.primary.withOpacity(0.14), fg: cs.primary);
  }
}

class _IconCount extends StatelessWidget {
  const _IconCount({required this.icon, required this.count, this.label});

  final IconData icon;
  final int count;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: cs.onSurface.withOpacity(0.55)),
        const SizedBox(width: 6),
        Text(
          label == null ? '$count' : '$count $label',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: cs.onSurface.withOpacity(0.55),
          ),
        ),
      ],
    );
  }
}

class _RoleStyle {
  final Color bg;
  final Color fg;
  const _RoleStyle({required this.bg, required this.fg});
}
