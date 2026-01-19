import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superapp/controllers/profile_controller.dart';
import 'package:superapp/controllers/main_screen_controller.dart';
import 'package:superapp/widgets/main_bottom_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    final mainController = Get.find<MainScreenController>();
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 250,
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 18),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      stops: [0.02, 0.49, 1.0],
                      colors: [
                        Color(0xFF38CAC7),
                        Color(0xFF27B9B6),
                        Color(0xFF119C99),
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: controller.back,
                            icon: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Profile',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Container(
                              width: 56,
                              height: 56,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/avatar.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.username.toString(),
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800,
                                        ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    controller.email.toString(),
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: Colors.white.withOpacity(0.85),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Positioned(
                  left: 16,
                  right: 16,
                  bottom: -40,
                  child: SizedBox(
                    height: 82,
                    child: Row(
                      children: [
                        Expanded(
                          child: Obx(
                            () => _StatCard(
                              value: controller.bookings.value,
                              label: 'Bookings',
                              primary: theme.colorScheme.primary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Obx(
                            () => _StatCard(
                              value: controller.reviews.value,
                              label: 'Reviews',
                              primary: theme.colorScheme.primary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Obx(
                            () => _StatCard(
                              value: controller.points.value,
                              label: 'Points',
                              primary: theme.colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 42),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
                children: [
                  _SectionTitle(title: 'Account', theme: theme),
                  const SizedBox(height: 8),
                  _CardGroup(
                    children: [
                      const SizedBox(height: 8),
                      _MenuTile(
                        icon: Icons.edit_outlined,
                        title: 'Edit Profile',
                        onTap: controller.onEditProfile,
                      ),
                      _MenuTile(
                        icon: Icons.verified_user_outlined,
                        title: 'Identity Verification',
                        trailing: const _Pending(
                          text: 'Pending',
                          bg: Color(0xFFFFF3D6),
                          fg: Color(0xFFF59E0B),
                        ),
                        onTap: controller.onIdentity,
                      ),
                      _MenuTile(
                        icon: Icons.tune_rounded,
                        title: 'Preferences',
                        onTap: controller.onPreferences,
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),
                  _SectionTitle(title: 'Wallet & Payments', theme: theme),
                  const SizedBox(height: 14),
                  _CardGroup(
                    children: [
                      _MenuTile(
                        icon: Icons.account_balance_wallet_outlined,
                        title: 'My Wallet',
                        onTap: controller.onMyWallet,
                      ),
                      _MenuTile(
                        icon: Icons.credit_card_outlined,
                        title: 'Payment Methods',
                        onTap: controller.onPaymentMethods,
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),
                  _SectionTitle(
                    title: 'Notifications & Settings',
                    theme: theme,
                  ),
                  const SizedBox(height: 14),
                  _CardGroup(
                    children: [
                      _MenuTile(
                        icon: Icons.notifications_none_rounded,
                        title: 'Notifications',
                        onTap: controller.onNotifications,
                      ),
                      _MenuTile(
                        icon: Icons.lock_outline_rounded,
                        title: 'Security Settings',
                        onTap: controller.onSecurity,
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),
                  _SectionTitle(title: 'Support', theme: theme),
                  const SizedBox(height: 14),
                  _CardGroup(
                    children: [
                      _MenuTile(
                        icon: Icons.help_outline_rounded,
                        title: 'Help Center',
                        onTap: controller.onHelpCenter,
                      ),
                      _MenuTile(
                        icon: Icons.policy_outlined,
                        title: 'Term & Policy',
                        onTap: controller.onTermPolicy,
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  _CardGroup(
                    children: [
                      _MenuTile(
                        icon: Icons.logout_rounded,
                        title: 'Logout',
                        titleColor: const Color(0xFFEF4444),
                        iconColor: const Color(0xFFEF4444),
                        onTap: controller.onLogout,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MainBottomBar(
        currentIndex: 4,
        isPropertySelected: mainController.categoryIndex.value == 1,
        onTap: (index) {
          if (index == 4) return;

          if (index == 0) {
            mainController.bottomIndex.value = 0;
            Get.back();
          } else {
            mainController.onBottomNavTap(index);
          }
        },
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.value,
    required this.label,
    required this.primary,
  });

  final int value;
  final String label;
  final Color primary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 78,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$value',
            style: theme.textTheme.titleLarge?.copyWith(
              color: primary,
              fontWeight: FontWeight.w900,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: const Color(0xFF9AA0AF),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.theme});

  final String title;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: theme.textTheme.titleMedium?.copyWith(
        color: const Color(0xFF9AA0AF),
        fontWeight: FontWeight.w700,
        fontSize: 12,
      ),
    );
  }
}

class _CardGroup extends StatelessWidget {
  const _CardGroup({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          for (int i = 0; i < children.length; i++) ...[
            children[i],
            if (i != children.length - 1)
              const Divider(height: 1, thickness: 1, color: Color(0xFFF2F2F2)),
          ],
        ],
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.trailing,
    this.titleColor,
    this.iconColor,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Widget? trailing;
  final Color? titleColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: primary.withOpacity(0.10),
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Icon(icon, size: 18, color: iconColor ?? primary),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: titleColor ?? const Color(0xFF1D2330),
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ),
            if (trailing != null) ...[trailing!, const SizedBox(width: 8)],
            const Icon(Icons.chevron_right_rounded, color: Color(0xFF9AA0AF)),
          ],
        ),
      ),
    );
  }
}

class _Pending extends StatelessWidget {
  const _Pending({required this.text, required this.bg, required this.fg});

  final String text;
  final Color bg;
  final Color fg;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w800,
        ).copyWith(color: fg),
      ),
    );
  }
}
