import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superapp/screens/all_review_screen.dart';

class HotelReviewsSection extends StatelessWidget {
  const HotelReviewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Reviews',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: theme.brightness == Brightness.dark ? Colors.white : const Color(0xFF1D2330),
              ),
            ),
            TextButton(
              onPressed: () => Get.to(() => const AllReviewsScreen()),
              child: const Text(
                'See All',
                style: TextStyle(
                  color: Color(0xFF2FC1BE),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _ReviewCard(theme),
        const SizedBox(height: 20),
        _ReviewCard(theme),
      ],
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final ThemeData theme;
  const _ReviewCard(this.theme);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
            color: const Color(0xFF2FC1BE).withOpacity(0.25), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: theme.brightness == Brightness.dark ? const Color(0xFF2FC1BE).withOpacity(0.1) : const Color(0xFFDDF4F4),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        'AH',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: theme.brightness == Brightness.dark ? const Color(0xFF2FC1BE) : const Color(0xFF1D2330),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Alex Hales',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: theme.brightness == Brightness.dark ? Colors.white : const Color(0xFF1D2330),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Dec 14, 2024',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF9AA0AF),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF2FC1BE),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: const [
                    Icon(
                      Icons.star_rounded,
                      color: Colors.white,
                      size: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      '4.8',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'The hotel was amazing, I loved the service and the food was delicious. I would definitely recommend it to my friends and family.',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.5,
              color: theme.brightness == Brightness.dark ? Colors.white70 : const Color(0xFF9AA0AF),
            ),
          ),
        ],
      ),
    );
  }
}
