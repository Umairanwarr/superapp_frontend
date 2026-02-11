import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superapp/screens/select_dates_screen.dart';

class CheckInOutSection extends StatelessWidget {
  const CheckInOutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: _dateCard(
            title: 'Tue, 13 Dec',
            subtitle: 'Check-in',
            icon: Icons.calendar_today_outlined,
            onTap: () => Get.to(() => const SelectDatesScreen(initialTabIndex: 0)),
            theme: theme,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _dateCard(
            title: 'Fri, 16 Dec',
            subtitle: 'Check-out',
            icon: Icons.calendar_today_outlined,
            onTap: () => Get.to(() => const SelectDatesScreen(initialTabIndex: 1)),
            theme: theme,
          ),
        ),
      ],
    );
  }

  Widget _dateCard(
      {required String title,
      required String subtitle,
      required IconData icon,
      required VoidCallback onTap,
      required ThemeData theme}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // 16% opacity teal background
        color: theme.brightness == Brightness.dark ? const Color(0xFF2FC1BE).withOpacity(0.1) : const Color(0x292FC1BE),
        borderRadius: BorderRadius.circular(24),
        // full-opacity teal border
        border: Border.all(
            color: const Color(0xFF2FC1BE), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 24,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xFF2FC1BE),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: theme.brightness == Brightness.dark ? Colors.white : const Color(0xFF1D2330),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              color: theme.brightness == Brightness.dark ? Colors.white70 : const Color(0xFF1D2330),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      ),
    );
  }
}
