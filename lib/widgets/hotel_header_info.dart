import 'package:flutter/material.dart';

class HotelHeaderInfo extends StatelessWidget {
  const HotelHeaderInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Grand Plaza Hotel',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1D2330),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: const [
                  Text(
                    'Superb',
                    style: TextStyle(
                      color: Color(0xFF2FC1BE),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    '120 reviews',
                    style: TextStyle(
                      color: Color(0xFF9AA0AF),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.near_me, size: 16, color: Color(0xFF9AA0AF)),
                  SizedBox(width: 4),
                  Text(
                    'London',
                    style: TextStyle(
                      color: Color(0xFF9AA0AF),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFDDF4F4),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFF2FC1BE).withOpacity(0.3)),
          ),
          child: Row(
            children: const [
              Icon(Icons.star, color: Color(0xFFFFB300), size: 18),
              SizedBox(width: 4),
              Text(
                '4.8',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  color: Color(0xFF1D2330),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
