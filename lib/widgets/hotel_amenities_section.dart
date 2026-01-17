import 'package:flutter/material.dart';

class HotelAmenitiesSection extends StatelessWidget {
  const HotelAmenitiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> amenities = [
      {'label': 'Free Wifi', 'icon': Icons.wifi_rounded},
      {'label': 'Breakfast', 'icon': Icons.local_cafe_rounded},
      {'label': 'Restaurant', 'icon': Icons.restaurant_rounded},
      {'label': 'Parking', 'icon': Icons.local_parking_rounded},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Amenities',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: Color(0xFF1D2330),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: amenities.map((item) {
            return Column(
              children: [
                Container(
                  width: 65,
                  height: 65,
                  decoration: BoxDecoration(
                    // 16% opacity teal background
                    color: const Color(0x292FC1BE),
                    borderRadius: BorderRadius.circular(20),
                    // full-opacity teal border
                    border: Border.all(
                        color: const Color(0xFF2FC1BE),
                        width: 1.5),
                  ),
                  child: Icon(
                    item['icon'],
                    color: const Color(0xFF1B8785),
                    size: 30,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  item['label'],
                  style: const TextStyle(
                    color: Color(0xFF9AA0AF),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
