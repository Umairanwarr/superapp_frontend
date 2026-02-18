import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/listing_service.dart';
import '../services/currency_service.dart';
import '../controllers/profile_controller.dart';

class SelectRoomSection extends StatelessWidget {
  final List<dynamic> rooms;

  const SelectRoomSection({super.key, this.rooms = const []});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Use real rooms data or fallback to defaults
    final List<Map<String, dynamic>> displayRooms;
    if (rooms.isNotEmpty) {
      displayRooms = rooms.asMap().entries.map((entry) {
        final room = entry.value as Map<String, dynamic>;
        final roomId = room['id'] as int?;
        final rawImage = room['image']?.toString() ?? '';
        final hasImage = rawImage.isNotEmpty;
        final isAsset = rawImage.startsWith('assets/');

        return {
          'title': room['title'] ?? 'Room ${entry.key + 1}',
          'price': (room['price'] ?? 0).toString(),
          'image': rawImage,
          'details': '',
          'match': entry.key == 0 ? '99% Match' : null,
          'isNetwork': hasImage && !isAsset && roomId != null,
          'networkImageUrl': (hasImage && !isAsset && roomId != null)
              ? ListingService.roomImageUrl(roomId)
              : null,
        };
      }).toList();
    } else {
      displayRooms = [
        {
          'title': 'Standard Room',
          'image': 'assets/room1.png',
          'details': '25 m² • 1 King Bed',
          'price': '180',
          'match': '99% Match',
        },
        {
          'title': 'Deluxe Suite',
          'image': 'assets/room2.png',
          'details': '40 m² • 1 King Bed + Sofa',
          'price': '350',
          'match': null,
        },
        {
          'title': 'Family Room',
          'image': 'assets/room3.png',
          'details': '35 m² • 2 Queens Bed',
          'price': '300',
          'match': null,
        },
      ];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Room',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: theme.brightness == Brightness.dark
                ? Colors.white
                : const Color(0xFF1D2330),
          ),
        ),
        const SizedBox(height: 20),
        Column(
          children: displayRooms.map((room) => _roomCard(room, theme)).toList(),
        ),
      ],
    );
  }

  Widget _roomCard(Map<String, dynamic> room, ThemeData theme) {
    final isNetwork = room['isNetwork'] == true;
    final networkUrl = room['networkImageUrl'] as String?;
    final imagePath = room['image'] as String?;
    final hasImage = imagePath != null && imagePath.isNotEmpty;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFF2FC1BE).withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          if (isNetwork && networkUrl != null) ...[
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: Image.network(
                networkUrl,
                width: 100,
                height: 90,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return _buildPlaceholder(theme);
                },
                errorBuilder: (_, __, ___) => _buildPlaceholder(theme),
              ),
            ),
            const SizedBox(width: 16),
          ] else if (hasImage) ...[
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: Image.asset(
                imagePath,
                width: 100,
                height: 90,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _buildPlaceholder(theme),
              ),
            ),
            const SizedBox(width: 16),
          ] else ...[
            _buildPlaceholder(theme),
            const SizedBox(width: 16),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        room['title'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: theme.brightness == Brightness.dark
                              ? Colors.white
                              : const Color(0xFF1D2330),
                        ),
                      ),
                    ),
                    if (room['match'] != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2FC1BE),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          room['match'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
                if ((room['details'] as String?)?.isNotEmpty == true) ...[
                  const SizedBox(height: 4),
                  Text(
                    room['details'],
                    style: TextStyle(
                      color: theme.brightness == Brightness.dark
                          ? Colors.white70
                          : const Color(0xFF9AA0AF),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      _formatPrice(room['price']),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF2FC1BE),
                      ),
                    ),
                    Text(
                      '/night',
                      style: TextStyle(
                        color: theme.brightness == Brightness.dark
                            ? Colors.white54
                            : const Color(0xFF9AA0AF),
                        fontSize: 14,
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

  String _formatPrice(dynamic price) {
    final priceValue = double.tryParse(price?.toString() ?? '0') ?? 0;
    if (priceValue == 0) return '\$0';

    // Get user's selected currency
    final profileController = Get.find<ProfileController>();
    final userCurrency = profileController.userCurrency.value;

    // Convert from USD to user's currency
    final convertedPrice = CurrencyService.convertFromUSD(priceValue, userCurrency);

    return CurrencyService.formatAmount(convertedPrice, userCurrency, decimals: 0);
  }

  Widget _buildPlaceholder(ThemeData theme) {
    return Container(
      width: 100,
      height: 90,
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark
            ? const Color(0xFF2FC1BE).withOpacity(0.1)
            : const Color(0xFFDDF4F4),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          bottomLeft: Radius.circular(16),
        ),
      ),
      child: const Icon(Icons.bed_rounded, size: 36, color: Color(0xFF2FC1BE)),
    );
  }
}
