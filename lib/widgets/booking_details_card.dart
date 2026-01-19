import 'package:flutter/material.dart';

class BookingDetailsCard extends StatelessWidget {
  final String hotelName;
  final String location;
  final String imageUrl;
  final String roomType1;
  final String roomType2;
  final String checkIn;
  final String checkOut;
  final int guests;
  final String totalPaid;
  final String? paymentMethod;

  const BookingDetailsCard({
    super.key,
    required this.hotelName,
    required this.location,
    required this.imageUrl,
    required this.roomType1,
    required this.roomType2,
    required this.checkIn,
    required this.checkOut,
    required this.guests,
    required this.totalPaid,
    this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF2FC1BE).withOpacity(0.35)),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hotel Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Image.network(
              imageUrl,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 160,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.image, size: 40, color: Colors.grey),
                  ),
                );
              },
            ),
          ),

          // Hotel Details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      hotelName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1D2330),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF22C55E),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Text(
                        'Confirmed',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 14,
                      color: Color(0xFF9CA3AF),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      location,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF9CA3AF),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                const Divider(height: 1, color: Color(0xFFE0E0E0)),
                const SizedBox(height: 16),
                // Booking Details
                _DetailRow(
                  label: 'Room Type',
                  value: '1x  $roomType1\n1x  $roomType2',
                ),
                const SizedBox(height: 12),
                _DetailRow(label: 'Check-In', value: checkIn),
                const SizedBox(height: 8),
                _DetailRow(label: 'Check-Out', value: checkOut),
                const SizedBox(height: 8),
                _DetailRow(label: 'Guests', value: guests.toString()),
                const SizedBox(height: 16),
                const Divider(height: 1, color: Color(0xFFE0E0E0)),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Paid',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1D2330),
                      ),
                    ),

                    Text(
                      totalPaid,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2FC1BE),
                      ),
                    ),
                  ],
                ),
                if (paymentMethod != null) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.check_circle_outline,
                        size: 14,
                        color: Color(0xFF9CA3AF),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        paymentMethod!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF9CA3AF),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF5A606A),
          ),
        ),

        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1D2330),
            ),
          ),
        ),
      ],
    );
  }
}
