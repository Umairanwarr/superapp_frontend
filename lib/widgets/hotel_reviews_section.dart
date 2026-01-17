import 'package:flutter/material.dart';

class HotelReviewsSection extends StatelessWidget {
  const HotelReviewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Reviews',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: Color(0xFF1D2330),
              ),
            ),
            TextButton(
              onPressed: () {},
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
        const _ReviewCard(),
        const SizedBox(height: 20),
        const _ReviewCard(),
      ],
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
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
                    decoration: const BoxDecoration(
                      color: Color(0xFFDDF4F4),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        'AH',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1D2330),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Alex Hales',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1D2330),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '2 days ago',
                        style: TextStyle(
                          color: Color(0xFF9AA0AF),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: const [
                  Icon(Icons.star, color: Color(0xFFFFB300), size: 16),
                  SizedBox(width: 4),
                  Text(
                    '5.0',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Color(0xFF1D2330),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 59), // 45 (avatar) + 14 (spacing)
            child: const Text(
              'Absolutely amazing experience! The staff was incredibly friendly and the rooms were spotless.',
              style: TextStyle(
                color: Color(0xFF9AA0AF),
                fontSize: 14,
                height: 1.6,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
