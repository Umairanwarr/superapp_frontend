import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class JobsQueueScreen extends StatelessWidget {
  const JobsQueueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  const Text(
                    '5 jobs in queue',
                    style: TextStyle(
                      color: Color(0xFF94A3B8),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildJobCard(
                    iconAsset: 'assets/fire.svg',
                    iconColor: const Color(0xFFEF4444),
                    iconBg: const Color(0xFFFEF2F2),
                    title: 'Unit 4B  - Leak\nRepair',
                    location: 'Maple Heights',
                    time: '2h ago',
                    tag: 'Urgent',
                    tagBg: const Color(0xFFFEE2E2),
                    tagColor: const Color(0xFFEF4444),
                  ),
                  const SizedBox(height: 16),
                  _buildJobCard(
                    icon: Icons.air_rounded,
                    iconColor: const Color(0xFF64748B),
                    iconBg: const Color(0xFFF1F5F9),
                    title: 'Unit 12A  - HVAC\nMaintenance',
                    location: 'Oak Plaza',
                    time: '5h ago',
                    tag: 'Normal',
                    tagBg: const Color(0xFFF1F5F9),
                    tagColor: const Color(0xFF64748B),
                  ),
                  const SizedBox(height: 16),
                  _buildJobCard(
                    iconAsset: 'assets/lock.svg',
                    iconColor: const Color(0xFF64748B),
                    iconBg: const Color(0xFFF1F5F9),
                    title: 'Unit 7C  - Lock\nReplacement',
                    location: 'Pine Court',
                    time: '1d ago',
                    tag: 'Normal',
                    tagBg: const Color(0xFFF1F5F9),
                    tagColor: const Color(0xFF64748B),
                  ),
                  const SizedBox(height: 16),
                  _buildJobCard(
                    iconAsset: 'assets/fix.svg',
                    iconColor: const Color(0xFFEF4444),
                    iconBg: const Color(0xFFFEF2F2),
                    title: 'Unit 3A  - Plumbing\nFix',
                    location: 'Cedar Towers',
                    time: '1d ago',
                    tag: 'Urgent',
                    tagBg: const Color(0xFFFEE2E2),
                    tagColor: const Color(0xFFEF4444),
                  ),
                  const SizedBox(height: 16),
                  _buildJobCard(
                    icon: Icons.air_rounded,
                    iconColor: const Color(0xFF64748B),
                    iconBg: const Color(0xFFF1F5F9),
                    title: 'Unit 9B  - AC\nRepair',
                    location: 'Maple Heights',
                    time: '2d ago',
                    tag: 'Normal',
                    tagBg: const Color(0xFFF1F5F9),
                    tagColor: const Color(0xFF64748B),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 15,
        bottom: 70,
        left: 20,
        right: 20,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF38CAC7), Color(0xFF2DD4BF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
          ),
          const Text(
            'Jobs Queue',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SvgPicture.asset(
            'assets/admin-filter.svg',
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            width: 24,
            height: 24,
          ),
        ],
      ),
    );
  }

  Widget _buildJobCard({
    IconData? icon,
    String? iconAsset,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String location,
    required String time,
    required String tag,
    required Color tagBg,
    required Color tagColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: iconAsset != null
                ? SvgPicture.asset(
                    iconAsset,
                    colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                    width: 24,
                    height: 24,
                  )
                : Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Color(0xFF1E293B),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        height: 1.3,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: tagBg,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(
                          color: tagColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      location,
                      style: const TextStyle(
                        color: Color(0xFF94A3B8),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        '•',
                        style: TextStyle(color: Color(0xFF94A3B8)),
                      ),
                    ),
                    Text(
                      time,
                      style: const TextStyle(
                        color: Color(0xFF94A3B8),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
