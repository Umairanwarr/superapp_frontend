import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:superapp/screens/admin/job_assignment_screen.dart';
import 'package:superapp/screens/admin/community_screen.dart';
import 'package:superapp/screens/admin/photo_review_screen.dart';
import 'package:superapp/widgets/admin_bottom_bar.dart';

import 'package:superapp/screens/admin/qc_screen.dart';
import 'package:superapp/screens/admin/iot_diagnostic_screen.dart';
import 'package:superapp/screens/admin/jobs_queue_screen.dart';
import 'package:superapp/screens/admin/payment_insights_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? theme.scaffoldBackgroundColor
          : const Color(0xFFF5F7FA),
      body: _currentIndex == 0
          ? _AdminDashboardBody()
          : _currentIndex == 1
          ? const QCScreen()
          : _currentIndex == 2
          ? const JobsQueueScreen()
          : _currentIndex == 3
          ? const PaymentInsightsScreen()
          : _currentIndex == 4
          ? CommunityScreen()
          : _currentIndex == 5
          ? const PhotoReviewScreen()
          : _AdminDashboardBody(), // Placeholder for other tabs
      bottomNavigationBar: AdminBottomBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class _AdminDashboardBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      children: [
        // Teal Header with solid bottom
        _buildHeader(context),
        // Content
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                // Location Dropdown
                _buildLocationDropdown(context, isDark),
                const SizedBox(height: 16),
                // Search Bar
                _buildSearchBar(context, isDark),
                const SizedBox(height: 20),
                // Stats Grid
                _buildStatsGrid(context, isDark),
                const SizedBox(height: 16),
                // Action Cards
                _buildActionCards(context),
                const SizedBox(height: 30),
                // Today's Tasks
                _buildSectionTitle(
                  context,
                  'Today\'s Tasks',
                  isDark,
                  showSeeAll: true,
                ),
                const SizedBox(height: 16),
                _buildTodaysTasks(context, isDark),
                const SizedBox(height: 24),
                // IoT Diagnostic
                _buildIoTDiagnosticCard(context, isDark),
                const SizedBox(height: 16),
                // Job Assignment White Card
                _buildJobAssignmentWhiteCard(context, isDark),
                const SizedBox(height: 30),
                // Today's Overview
                _buildSectionTitle(context, 'Today\'s Overview', isDark),
                const SizedBox(height: 16),
                _buildTodaysOverview(context, isDark),
                const SizedBox(height: 50), // Extra padding for bottom
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(
    BuildContext context,
    String title,
    bool isDark, {
    bool showSeeAll = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: isDark ? Colors.white : const Color(0xFF1F2937),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        if (showSeeAll)
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              'See all',
              style: TextStyle(
                color: Color(0xFF38CAC7),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTodaysTasks(BuildContext context, bool isDark) {
    final theme = Theme.of(context);
    return Column(
      children: [
        _TaskCard(
          title: 'Villa Sunset',
          subtitle: 'Checkout clean • Ana M.',
          time: 'Due 2:00 PM',
          tag: 'Urgent',
          tagColor: const Color(0xFFFEF3C7),
          tagTextColor: const Color(0xFFD97706),
          statusColor: const Color(0xFFEC4899),
          isDark: isDark,
          cardBgColor: isDark ? theme.cardColor : Colors.white,
        ),
        const SizedBox(height: 12),
        _TaskCard(
          title: 'Villa Sunset',
          subtitle: 'Checkout clean • Ana M.',
          time: 'Due 2:00 PM',
          tag: 'Urgent',
          tagColor: const Color(0xFFFEF3C7),
          tagTextColor: const Color(0xFFD97706),
          statusColor: const Color(0xFFEC4899),
          isDark: isDark,
          cardBgColor: isDark ? theme.cardColor : Colors.white,
        ),
        const SizedBox(height: 12),
        _TaskCard(
          title: 'Villa Sunset',
          subtitle: 'Checkout clean • Ana M.',
          time: 'Due 2:00 PM',
          tag: 'Urgent',
          tagColor: const Color(0xFFFEF3C7),
          tagTextColor: const Color(0xFFD97706),
          statusColor: const Color(0xFFEC4899),
          isDark: isDark,
          cardBgColor: isDark ? theme.cardColor : Colors.white,
        ),
      ],
    );
  }

  Widget _buildIoTDiagnosticCard(BuildContext context, bool isDark) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const IoTDiagnosticScreen()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? theme.cardColor : Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Color(0x05000000),
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF3E8FF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.memory_rounded,
                color: Color(0xFFA855F7),
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'IoT Diagnostic',
                    style: TextStyle(
                      color: isDark ? Colors.white : const Color(0xFF1F2937),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Monitor\nconnected devices',
                    style: TextStyle(
                      color: isDark
                          ? Colors.white70
                          : const Color(0xFF6B7280).withOpacity(0.8),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFFEE2E2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEF4444),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    '2 alerts',
                    style: TextStyle(
                      color: Color(0xFFEF4444),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Color(0xFF9CA3AF),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJobAssignmentWhiteCard(BuildContext context, bool isDark) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const JobAssignmentScreen()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? theme.cardColor : Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Color(0x05000000),
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFDBEAFE),
                borderRadius: BorderRadius.circular(16),
              ),
              child: SvgPicture.asset(
                'assets/Ai.svg',
                width: 28,
                height: 28,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF2563EB),
                  BlendMode.srcIn,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Job Assignment',
                    style: TextStyle(
                      color: isDark ? Colors.white : const Color(0xFF1F2937),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Ai & Manual Assign',
                    style: TextStyle(
                      color: isDark
                          ? Colors.white70
                          : const Color(0xFF6B7280).withOpacity(0.8),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Color(0xFF9CA3AF),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTodaysOverview(BuildContext context, bool isDark) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? theme.cardColor : Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _OverviewRow(label: 'Jobs Created', value: '8', isDark: isDark),
          Divider(
            height: 32,
            color: isDark ? Colors.white12 : const Color(0xFFF3F4F6),
          ),
          _OverviewRow(
            label: 'Jobs Closed',
            value: '12',
            valueColor: const Color(0xFF10B981),
            isDark: isDark,
          ),
          Divider(
            height: 32,
            color: isDark ? Colors.white12 : const Color(0xFFF3F4F6),
          ),
          _OverviewRow(
            label: 'Avg. Resolution',
            value: '4.2 hrs',
            valueColor: isDark ? Colors.white : const Color(0xFF1F2937),
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 15,
        left: 20,
        right: 20,
        bottom: 40, // Increased bottom padding to match image
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFF38CAC7), Color(0xFF27B9B6), Color(0xFF119C99)],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center, // Center vertically
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Admin Dashboard',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
              ),
            ],
          ),
          // Notification Bell with Badge
          Stack(
            clipBehavior: Clip.none,
            children: [
              Image.asset(
                'assets/bell.png',
                width: 24,
                height: 24,
                color: Colors.white,
              ),
              Positioned(
                right: -2,
                top: -4,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF4444),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF27B9B6),
                      width: 1.5,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      '5',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLocationDropdown(BuildContext context, bool isDark) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: isDark ? theme.cardColor : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark ? Colors.white12 : const Color(0xFFE5E7EB),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/location.svg',
            width: 16,
            height: 16,
            colorFilter: const ColorFilter.mode(
              Color(0xFF38CAC7),
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'Croatia',
            style: TextStyle(
              color: isDark ? Colors.white : const Color(0xFF1F2937),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 6),
          Icon(
            Icons.keyboard_arrow_down,
            color: isDark ? Colors.white70 : const Color(0xFF6B7280),
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context, bool isDark) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? theme.cardColor : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.white12 : const Color(0xFFF3F4F6),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              // color: const Color(0xFF38CAC7), // Removed to let SVG gradient show
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: SvgPicture.asset(
                'assets/mic.svg',
                width: 44, // Match container width
                height: 44, // Match container height
                fit: BoxFit.cover,
                // No color filter, let original colors show
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ask anything...',
                  style: TextStyle(
                    color: isDark ? Colors.white : const Color(0xFF1F2937),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Search tasks, staff, properties',
                  style: TextStyle(
                    color: isDark ? Colors.white70 : const Color(0xFF9CA3AF),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF38CAC7).withOpacity(0.2)
                  : const Color(0xFFE0F2FE),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'AI',
              style: TextStyle(
                color: Color(0xFF38CAC7),
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(BuildContext context, bool isDark) {
    final theme = Theme.of(context);
    return Column(
      children: [
        // First Row
        Row(
          children: [
            Expanded(
              child: _StatCard(
                value: '12',
                label: 'Jobs Queue',
                icon: Icons.assignment_outlined, // Fallback
                iconAsset: 'assets/jobs-admin.svg',
                iconBgColor: const Color(0xFFDBEAFE),
                iconColor: const Color(0xFF2563EB),
                valueColor: isDark ? Colors.white : const Color(0xFF111827),
                cardBgColor: isDark ? theme.cardColor : Colors.white,
                isDark: isDark,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _StatCard(
                value: '5',
                label: 'Pending',
                icon: Icons.access_time_rounded,
                iconBgColor: const Color(0xFFFEF3C7),
                iconColor: const Color(0xFFD97706),
                valueColor: isDark ? Colors.white : const Color(0xFF111827),
                cardBgColor: isDark ? theme.cardColor : Colors.white,
                isDark: isDark,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Second Row
        Row(
          children: [
            Expanded(
              child: _StatCard(
                value: '48',
                label: 'Completed',
                icon: Icons.check_circle_outline_rounded, // Fallback
                iconAsset: 'assets/tick.svg',
                iconBgColor: const Color(0xFFD1FAE5),
                iconColor: const Color(0xFF059669),
                valueColor: const Color(0xFF059669),
                cardBgColor: isDark ? theme.cardColor : Colors.white,
                isDark: isDark,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _StatCardWithBadge(
                value: '3',
                label: 'Photo Review',
                icon: Icons.camera_alt_outlined, // Fallback
                iconAsset: 'assets/photo.svg',
                iconBgColor: const Color(0xFFFFEDD5),
                iconColor: const Color(0xFFEA580C),
                valueColor: const Color(0xFFEA580C),
                cardBgColor: isDark ? theme.cardColor : const Color(0xFFFFF7ED),
                badgeText: 'Needs Attention',
                badgeColor: const Color(0xFFF97316),
                isDark: isDark,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCards(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const JobAssignmentScreen(),
                ),
              );
            },
            child: _ActionCard(
              title: 'Job\nAssignment',
              subtitle: 'AI & Manual assign',
              badgeText: '3 unassigned',
              gradient: const [Color(0xFF3B82F6), Color(0xFF2563EB)],
              icon: Icons.auto_awesome, // Fallback
              iconAsset: 'assets/Ai.svg',
              badgeBgColor: const Color(0xFF60A5FA),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _ActionCard(
            title: 'Earnings',
            subtitle: 'Track revenue',
            badgeText: '\$8.4k this week',
            gradient: const [Color(0xFF10B981), Color(0xFF059669)],
            icon: Icons.attach_money_rounded, // Fallback
            iconAsset: 'assets/dollar.svg',
            badgeBgColor: const Color(0xFF34D399),
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final Color valueColor;
  final Color cardBgColor;
  final bool isDark;

  final String? iconAsset;

  const _StatCard({
    required this.value,
    required this.label,
    required this.icon,
    this.iconAsset,
    required this.iconBgColor,
    required this.iconColor,
    required this.valueColor,
    required this.cardBgColor,
    this.isDark = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 185,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: iconAsset != null
                ? Center(
                    child: SvgPicture.asset(
                      iconAsset!,
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                    ),
                  )
                : Icon(icon, color: iconColor, size: 24),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontSize: 32,
              fontWeight: FontWeight.w700,
              height: 1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: isDark ? Colors.white70 : const Color(0xFF6B7280),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCardWithBadge extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final Color valueColor;
  final Color cardBgColor;
  final String badgeText;
  final Color badgeColor;
  final bool isDark;

  final String? iconAsset;

  const _StatCardWithBadge({
    required this.value,
    required this.label,
    required this.icon,
    this.iconAsset,
    required this.iconBgColor,
    required this.iconColor,
    required this.valueColor,
    required this.cardBgColor,
    required this.badgeText,
    required this.badgeColor,
    this.isDark = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 185,
      padding: const EdgeInsets.all(16), // Reduced padding slightly
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: iconAsset != null
                ? Center(
                    child: SvgPicture.asset(
                      iconAsset!,
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                    ),
                  )
                : Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(height: 12), // Reduced spacing
          Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontSize: 32,
              fontWeight: FontWeight.w700,
              height: 1,
            ),
          ),
          const SizedBox(height: 6), // Reduced spacing
          Text(
            label,
            style: TextStyle(
              color: isDark ? Colors.white70 : const Color(0xFF6B7280),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: badgeColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              badgeText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String badgeText;
  final List<Color> gradient;
  final IconData icon;
  final Color badgeBgColor;

  final String? iconAsset;

  const _ActionCard({
    required this.title,
    required this.subtitle,
    required this.badgeText,
    required this.gradient,
    required this.icon,
    this.iconAsset,
    required this.badgeBgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: gradient[0].withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: iconAsset != null
                ? Center(
                    child: SvgPicture.asset(
                      iconAsset!,
                      width: 26,
                      height: 26,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  )
                : Icon(icon, color: Colors.white, size: 26),
          ),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: badgeBgColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Text(
              badgeText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final String tag;
  final Color tagColor;
  final Color tagTextColor;
  final Color statusColor;
  final bool isDark;
  final Color cardBgColor;

  const _TaskCard({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.tag,
    required this.tagColor,
    required this.tagTextColor,
    required this.statusColor,
    this.isDark = false,
    this.cardBgColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Fixed height for the task card to ensure consistent spacing
      height: 110,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Main Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: isDark ? Colors.white : const Color(0xFF1F2937),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  color: isDark
                      ? Colors.white70
                      : const Color(0xFF6B7280).withOpacity(0.9),
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Icon(
                    Icons.access_time_rounded,
                    color: isDark ? Colors.white54 : const Color(0xFF9CA3AF),
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    time,
                    style: TextStyle(
                      color: isDark ? Colors.white70 : const Color(0xFF6B7280),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Top Right Tag
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: tagColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                tag,
                style: TextStyle(
                  color: tagTextColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          // Bottom Right Status Circle
          Positioned(
            bottom: 4,
            right: 4,
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: statusColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OverviewRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final bool isDark;

  const _OverviewRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.isDark = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isDark
                ? Colors.white70
                : const Color(0xFF6B7280).withOpacity(0.9),
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color:
                valueColor ?? (isDark ? Colors.white : const Color(0xFF1F2937)),
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
