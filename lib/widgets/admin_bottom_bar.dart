import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdminBottomBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AdminBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      (label: 'Home', asset: 'assets/admin-home.svg'),
      (label: 'QC', asset: 'assets/tick.svg'),
      (label: 'Jobs', asset: 'assets/jobs-admin.svg'),
      (label: 'Pay', asset: 'assets/dollar.svg'),
      (label: 'Community', asset: 'assets/community.svg'),
      (label: 'Photos', asset: 'assets/photo.svg'),
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFF3F4F6), width: 1)),
      ),
      child: SafeArea(
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (index) {
              final item = items[index];
              final isSelected = index == currentIndex;

              // Colors based on image: Active is dark (Slate 900), Inactive is grey (Slate 400)
              final color = isSelected
                  ? const Color(0xFF1F2937)
                  : const Color(0xFF9CA3AF);

              return Expanded(
                child: InkWell(
                  onTap: () => onTap(index),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Using SvgPicture for all icons
                      SvgPicture.asset(
                        item.asset,
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item.label,
                        style: TextStyle(
                          color: color,
                          fontSize: 11,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
