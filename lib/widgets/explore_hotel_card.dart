import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screens/hotel_detail_screen.dart';
import '../services/currency_service.dart';
import '../controllers/profile_controller.dart';

class ExploreHotelCard extends StatelessWidget {
  final String title;
  final String location;
  final String imagePath;
  final String? imageUrl;
  final double rating;
  final String price;
  final bool showPerNight;
  final VoidCallback? onTap;

  const ExploreHotelCard({
    super.key,
    required this.title,
    required this.location,
    required this.imagePath,
    this.imageUrl,
    required this.rating,
    required this.price,
    this.showPerNight = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap ?? () => Get.to(() => const HotelDetailScreen()),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFF2FC1BE), width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(22),
                  ),
                  child: imageUrl != null
                      ? Image.network(
                          imageUrl!,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              height: 200,
                              color: Colors.grey[200],
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xFF2FC1BE),
                                ),
                              ),
                            );
                          },
                          errorBuilder: (_, __, ___) => Container(
                            height: 200,
                            color: Colors.grey[300],
                            child: const Icon(
                              Icons.home,
                              size: 60,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : Image.asset(
                          imagePath,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                height: 200,
                                color: Colors.grey[300],
                                child: const Icon(Icons.hotel),
                              ),
                        ),
                ),
              ],
            ),
            // Info Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: theme.brightness == Brightness.dark
                          ? Colors.white
                          : const Color(0xFF1D2330),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: Color(0xFF9AA0AF),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          location,
                          style: TextStyle(
                            fontSize: 14,
                            color: theme.brightness == Brightness.dark
                                ? Colors.grey[400]
                                : const Color(0xFF747477),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Divider(height: 1, color: Color(0xFFE8E8E8)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            color: Color(0xFFFFC107),
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            rating.toStringAsFixed(1),
                            style: TextStyle(
                              color: theme.brightness == Brightness.dark
                                  ? Colors.white
                                  : const Color(0xFF1D2330),
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: _formatPrice(price),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF2FC1BE),
                              ),
                            ),
                            if (showPerNight)
                              const TextSpan(
                                text: '/night',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF9AA0AF),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatPrice(String price) {
    // Price is already formatted (e.g., "$121", "$1K")
    // Just return it directly, don't try to parse
    if (price.isEmpty || price == '\$0') return '\$0';
    return price;
  }
}
