import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CommunityTopHeader extends StatelessWidget
    implements PreferredSizeWidget {
  const CommunityTopHeader({
    super.key,
    required this.title,
    this.showBack = true,
    this.onBack,
    this.showMenu = false,
    this.onMenuTap,
    this.pendingCount,
  });

  final String title;

  final bool showBack;
  final VoidCallback? onBack;

  final bool showMenu;
  final VoidCallback? onMenuTap;

  final int? pendingCount;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: AppBar(
        backgroundColor: theme.colorScheme.primary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,

        leading: showBack
            ? IconButton(
                onPressed: onBack ?? () => Get.back(),
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 18,
                ),
              )
            : null,

        title: Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),

        actions: [
          if (pendingCount != null) _PendingPill(count: pendingCount!),

          if (showMenu)
            IconButton(
              onPressed: onMenuTap ?? () {},
              icon: const Icon(Icons.more_vert, color: Colors.white),
            ),
        ],
      ),
    );
  }
}

class _PendingPill extends StatelessWidget {
  const _PendingPill({required this.count});
  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10, top: 14, bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFFF7A00),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        "$count pending",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
