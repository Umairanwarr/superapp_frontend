import 'package:flutter/material.dart';

class SelectRoomSection extends StatelessWidget {
  const SelectRoomSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final List<Map<String, dynamic>> rooms = [
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Room',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: theme.brightness == Brightness.dark ? Colors.white : const Color(0xFF1D2330),
          ),
        ),
        const SizedBox(height: 20),
        Column(
          children: rooms.map((room) => _roomCard(room, theme)).toList(),
        ),
      ],
    );
  }

  Widget _roomCard(Map<String, dynamic> room, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
            color: const Color(0xFF2FC1BE).withOpacity(0.3), width: 1.5),
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
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
            child: Image.asset(
              room['image'],
              width: 100,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      room['title'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: theme.brightness == Brightness.dark ? Colors.white : const Color(0xFF1D2330),
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
                const SizedBox(height: 4),
                Text(
                  room['details'],
                  style: TextStyle(
                    color: theme.brightness == Brightness.dark ? Colors.white70 : const Color(0xFF9AA0AF),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      '\$${room['price']}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF2FC1BE),
                      ),
                    ),
                    Text(
                      '/night',
                      style: TextStyle(
                        color: theme.brightness == Brightness.dark ? Colors.white54 : const Color(0xFF9AA0AF),
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
}
