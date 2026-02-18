import 'package:flutter/material.dart';

class HotelHeaderInfo extends StatelessWidget {
  final String name;
  final double rating;
  final String ratingLabel;
  final int reviewCount;
  final String location;

  const HotelHeaderInfo({
    super.key,
    this.name = 'Grand Plaza Hotel',
    this.rating = 4.8,
    this.ratingLabel = 'Superb',
    this.reviewCount = 120,
    this.location = 'London',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: theme.brightness == Brightness.dark
                      ? Colors.white
                      : const Color(0xFF1D2330),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    ratingLabel,
                    style: const TextStyle(
                      color: Color(0xFF2FC1BE),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '$reviewCount reviews',
                    style: TextStyle(
                      color: theme.brightness == Brightness.dark
                          ? Colors.white70
                          : const Color(0xFF9AA0AF),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.near_me,
                    size: 16,
                    color: theme.brightness == Brightness.dark
                        ? Colors.white70
                        : const Color(0xFF9AA0AF),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      location,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: theme.brightness == Brightness.dark
                            ? Colors.white70
                            : const Color(0xFF9AA0AF),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
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
            color: theme.brightness == Brightness.dark
                ? const Color(0xFF2FC1BE).withOpacity(0.2)
                : const Color(0xFFDDF4F4),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFF2FC1BE).withOpacity(0.3)),
          ),
          child: Row(
            children: [
              const Icon(Icons.star, color: Color(0xFFFFB300), size: 18),
              const SizedBox(width: 4),
              Text(
                rating > 0 ? rating.toStringAsFixed(1) : 'New',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  color: theme.brightness == Brightness.dark
                      ? Colors.white
                      : const Color(0xFF1D2330),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
