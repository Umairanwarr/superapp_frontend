import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superapp/widgets/booking_reference_card.dart';
import 'package:superapp/widgets/qr_code_card.dart';
import 'package:superapp/widgets/booking_details_card.dart';

class BookingConfirmationScreen extends StatelessWidget {
  const BookingConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                // Success Image
                Image.asset('assets/success.png', width: 80, height: 80),
                const SizedBox(height: 20),

                // Title
                Text(
                  'Booking Confirmed!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: theme.textTheme.titleLarge?.color,
                  ),
                ),
                const SizedBox(height: 8),

                // Subtitle
                const Text(
                  'Your reservation has been successfully\ncompleted',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF9CA3AF),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),

                // Booking Reference Card
                const BookingReferenceCard(referenceNumber: 'BK30687'),
                const SizedBox(height: 16),

                // QR Code Card
                QrCodeCard(
                  onDownload: () {
                    // Handle download
                  },
                  onShare: () {
                    // Handle share
                  },
                ),
                const SizedBox(height: 16),

                // Booking Details Card
                const BookingDetailsCard(
                  hotelName: 'Grand Plaza Hotel',
                  location: 'Paris, France',
                  imageUrl:
                      'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800',
                  roomType1: 'Standard Room',
                  roomType2: 'Deluxe Suite',
                  checkIn: '12/03/2025',
                  checkOut: '12/06/2025',
                  guests: 3,
                  totalPaid: '\$1774',
                ),
                const SizedBox(height: 24),

                // Email Confirmation Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF79C7EE).withOpacity(0.10),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFF79C7EE).withOpacity(0.3),
                    ),
                  ),

                  child: Column(
                    children: const [
                      Text(
                        'Confirmation email sent to',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF5A606A),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'alex@gmail.com',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2FC1BE),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // View My Bookings Button
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to bookings
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2FC1BE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 22,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'View My Bookings',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Back To Home Button
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: OutlinedButton(
                    onPressed: () {
                      Get.offAllNamed('/');
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Color(0xFFE0E0E0)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.home_outlined,
                          size: 22,
                          color: theme.textTheme.bodyLarge?.color,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Back To Home',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: theme.textTheme.bodyLarge?.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
