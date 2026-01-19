import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../widgets/booking_details_card.dart';
import '../../widgets/qr_code_card.dart';

class BookingDetailsScreen extends StatelessWidget {
  const BookingDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F8F8),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Color(0xFF2FC1BE),
                        size: 24,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Booking Details',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2FC1BE),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Booking #BK3068',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF5A606A),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // QR Code Card
              QrCodeCard(
                onDownload: () {},
                onShare: () {},
              ),
              const SizedBox(height: 20),

              // Booking Details Card
              const BookingDetailsCard(
                hotelName: 'Grand Plaza Hotel',
                location: 'Paris, France',
                imageUrl: 'https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80', // Placeholder or asset
                roomType1: 'Standard Room',
                roomType2: 'Deluxe Suite',
                checkIn: '12/03/2025',
                checkOut: '12/06/2025',
                guests: 3,
                totalPaid: '\$1774',
                paymentMethod: 'Paid via Credit Card •••• 4242',
              ),
              
              const SizedBox(height: 24),

              // Buttons
              _ActionButton(
                icon: Icons.download,
                iconWidget: SvgPicture.asset(
                  'assets/material-symbols_download-rounded.svg',
                  width: 20,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF1D2330),
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Download Invoice',
                onTap: () {},
                isPrimary: false,
              ),
              const SizedBox(height: 12),
              _ActionButton(
                icon: Icons.cancel_outlined,
                label: 'Cancel Booking',
                onTap: () {},
                isPrimary: false,
                textColor: Colors.red,
                iconColor: Colors.red,
              ),

              const SizedBox(height: 24),

              // Info Banner
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFD0FBAF).withOpacity(0.57),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.check_circle_outline,
                      color: Color(0xFF2E7D32),
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Free cancellation until 24 hours before check-in. After that cancellation fees may apply.',
                        style: TextStyle(
                          fontSize: 12,
                          color: const Color(0xFF1B5E20),
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final Widget? iconWidget;
  final String label;
  final VoidCallback onTap;
  final bool isPrimary;
  final Color? textColor;
  final Color? iconColor;

  const _ActionButton({
    required this.icon,
    this.iconWidget,
    required this.label,
    required this.onTap,
    this.isPrimary = true,
    this.textColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isPrimary ? const Color(0xFF2FC1BE) : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: isPrimary ? null : Border.all(color: const Color(0xFFE0E0E0)),
          boxShadow: isPrimary
              ? [
                  BoxShadow(
                    color: const Color(0xFF2FC1BE).withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconWidget != null)
              IconTheme(
                data: IconThemeData(
                  color: iconColor ?? (isPrimary ? Colors.white : const Color(0xFF1D2330)),
                  size: 20,
                ),
                child: iconWidget!,
              )
            else
              Icon(
                icon,
                color: iconColor ?? (isPrimary ? Colors.white : const Color(0xFF1D2330)),
                size: 20,
              ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: textColor ?? (isPrimary ? Colors.white : const Color(0xFF1D2330)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
