import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:superapp/screens/payment_screen.dart';

class BookingSummaryScreen extends StatelessWidget {
  final String bookingType; // 'hotel' or 'property'

  const BookingSummaryScreen({super.key, this.bookingType = 'hotel'});

  @override
  Widget build(BuildContext context) {
    final bool isProperty = bookingType == 'property';

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Color(0xFF2FC1BE),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Summary',
                      style: TextStyle(
                        color: Color(0xFF2FC1BE),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // Property card for property bookings
                    if (isProperty) ...[
                      const _PropertySummaryCard(),
                      const SizedBox(height: 24),
                    ],
                    // Room cards for hotel bookings
                    if (!isProperty) ...[
                      const _SummaryRoomCard(
                        title: 'Standard Room (1)',
                        specs: '1 King Bed • 25 m²',
                        price: '180',
                        imagePath: 'assets/room1.png',
                      ),
                      const SizedBox(height: 16),
                      const _SummaryRoomCard(
                        title: 'Deluxe Suite (1)',
                        specs: '1 King Bed + Sofa • 25 m²',
                        price: '350',
                        imagePath: 'assets/room2.png',
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: _DateCard(
                              label: 'CHECK-IN',
                              date: 'Tue, 13 Dec',
                              icon: Icons.login,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _DateCard(
                              label: 'CHECK-OUT',
                              date: 'Fri, 16 Dec',
                              icon: Icons.logout,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const _GuestDetailsCard(),
                      const SizedBox(height: 24),
                    ],
                    const _PromoCodeSection(),
                    const SizedBox(height: 24),
                    // Different price details for property vs hotel
                    if (isProperty)
                      const _PropertyPriceDetailsSection()
                    else
                      const _PriceDetailsSection(),
                    const SizedBox(height: 24),
                    // Different total section for property
                    if (isProperty)
                      const _PropertyTotalSection()
                    else
                      const _TotalSection(),
                    const SizedBox(height: 24),
                    if (!isProperty)
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE3F9D6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Icon(
                              Icons.verified_user_outlined,
                              color: Color(0xFF43A047),
                              size: 20,
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Free cancellation until 24 hours before check-in.\nAfter that cancellation fees may apply.',
                                style: TextStyle(
                                  color: Color(0xFF2E7D32),
                                  fontSize: 12,
                                  height: 1.4,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        color: const Color(0xFFF7FAFA),
        padding: const EdgeInsets.all(20),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Color(0xFFB0B0B0)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Color(0xFF1D2330),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () =>
                        Get.to(() => PaymentScreen(bookingType: bookingType)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2FC1BE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        isProperty
                            ? 'Proceed to Payment'
                            : 'Proceed to Checkout',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryRoomCard extends StatelessWidget {
  final String title;
  final String specs;
  final String price;
  final String imagePath;

  const _SummaryRoomCard({
    required this.title,
    required this.specs,
    required this.price,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF2FC1BE), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imagePath,
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1D2330),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  specs,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF878787),
                  ),
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '\$$price',
                        style: const TextStyle(
                          color: Color(0xFF2FC1BE),
                          fontSize: 16, // Font size for price per night
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const TextSpan(
                        text: '/night',
                        style: TextStyle(
                          color: Color(0xFF878787),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DateCard extends StatelessWidget {
  final String label;
  final String date;
  final IconData icon;

  const _DateCard({
    required this.label,
    required this.date,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0x292FC1BE),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF2FC1BE), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 24,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF878787),
                ),
              ),
              Icon(icon, color: const Color(0xFF2FC1BE), size: 24),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            date,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1D2330),
            ),
          ),
        ],
      ),
    );
  }
}

class _GuestDetailsCard extends StatelessWidget {
  const _GuestDetailsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0E0E0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildCounterRow('Number of Adults', 'Ages 12+', 2),
          const SizedBox(height: 20),
          _buildCounterRow(
            'Number of Adults',
            'Ages 0-11',
            1,
          ), // Using 'Adults' to match image typo? Or fix? Image says "Number of Adults" twice. I'll match text but it's weird.
          // Wait, actually user says "divide it into widgets like ... adults".
          // I'll stick to image text for "pixel perfect".
        ],
      ),
    );
  }

  Widget _buildCounterRow(String label, String subLabel, int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1D2330),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subLabel,
              style: const TextStyle(fontSize: 12, color: Color(0xFF878787)),
            ),
          ],
        ),
        Row(
          children: [
            _CounterButton(icon: Icons.remove, color: const Color(0xFFBEEBEA)),
            const SizedBox(width: 14),
            Text(
              '$count',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1D2330),
              ),
            ),
            const SizedBox(width: 14),
            _CounterButton(icon: Icons.add, color: const Color(0xFFBEEBEA)),
          ],
        ),
      ],
    );
  }
}

class _CounterButton extends StatelessWidget {
  final IconData icon;
  final Color color;

  const _CounterButton({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Icon(icon, size: 16, color: const Color(0xFF2FC1BE)),
    );
  }
}

class _PromoCodeSection extends StatelessWidget {
  const _PromoCodeSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Promo Code',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1D2330),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE0E0E0)),
                ),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Promo code',
                  style: TextStyle(color: Color(0xFF9E9E9E)),
                ),
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2FC1BE),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                ),
                child: const Text(
                  'Apply',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PriceDetailsSection extends StatelessWidget {
  const _PriceDetailsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Price Details',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1D2330),
          ),
        ),
        const SizedBox(height: 12),
        _buildPriceRow('2 Room x 3 Nights', '\$1590'),
        const SizedBox(height: 8),
        _buildPriceRow('Taxes & Fees (10%)', '\$159'),
        const SizedBox(height: 8),
        _buildPriceRow('Service Charge', '\$25'),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final boxWidth = constraints.constrainWidth();
            const dashWidth = 5.0;
            const dashHeight = 1.0;
            final dashCount = (boxWidth / (2 * dashWidth)).floor();
            return Flex(
              children: List.generate(dashCount, (_) {
                return SizedBox(
                  width: dashWidth,
                  height: dashHeight,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.grey[300]),
                  ),
                );
              }),
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              direction: Axis.horizontal,
            );
          },
        ),
      ],
    );
  }

  Widget _buildPriceRow(String label, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF878787),
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          amount,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1D2330),
          ),
        ),
      ],
    );
  }
}

class _TotalSection extends StatelessWidget {
  const _TotalSection();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          'Total',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1D2330),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: const [
            Text(
              '\$1774',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2FC1BE),
              ),
            ),
            SizedBox(height: 2),
            Text(
              'Includes all taxes',
              style: TextStyle(fontSize: 10, color: Color(0xFF878787)),
            ),
          ],
        ),
      ],
    );
  }
}

// Property-specific widgets
class _PropertySummaryCard extends StatelessWidget {
  const _PropertySummaryCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF2FC1BE), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/room1.png',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Luxury Villa',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1D2330),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: const [
                    Icon(Icons.location_on, size: 14, color: Color(0xFF878787)),
                    SizedBox(width: 4),
                    Text(
                      'Dubai Marina',
                      style: TextStyle(fontSize: 13, color: Color(0xFF878787)),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                const Text(
                  '\$1.8M',
                  style: TextStyle(
                    color: Color(0xFF2FC1BE),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: const [
                    Icon(Icons.star, color: Color(0xFFFFB300), size: 18),
                    SizedBox(width: 4),
                    Text(
                      '4.8',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1D2330),
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

class _PropertyPriceDetailsSection extends StatelessWidget {
  const _PropertyPriceDetailsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Payment Details',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1D2330),
          ),
        ),
        const SizedBox(height: 14),
        _buildPriceRow('Purchase Price', '\$1,250,000.00'),
        const SizedBox(height: 10),
        _buildPriceRow('Closing Costs Estimate', '\$18,500.00'),
        const SizedBox(height: 10),
        _buildPriceRow('Agent Fees', '\$37,500.00'),
        const SizedBox(height: 18),
        LayoutBuilder(
          builder: (context, constraints) {
            final boxWidth = constraints.constrainWidth();
            const dashWidth = 5.0;
            const dashHeight = 1.0;
            final dashCount = (boxWidth / (2 * dashWidth)).floor();
            return Flex(
              children: List.generate(dashCount, (_) {
                return SizedBox(
                  width: dashWidth,
                  height: dashHeight,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.grey[300]),
                  ),
                );
              }),
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              direction: Axis.horizontal,
            );
          },
        ),
      ],
    );
  }

  Widget _buildPriceRow(String label, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF878787),
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          amount,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1D2330),
          ),
        ),
      ],
    );
  }
}

class _PropertyTotalSection extends StatelessWidget {
  const _PropertyTotalSection();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Down Payment Required',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2FC1BE),
              ),
            ),
            SizedBox(height: 4),
            Text(
              '(20%)',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2FC1BE),
              ),
            ),
            SizedBox(height: 6),
            Text(
              'Due today to secure property',
              style: TextStyle(fontSize: 12, color: Color(0xFF878787)),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: const [
            Text(
              '\$1,306,000',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2FC1BE),
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Includes all taxes',
              style: TextStyle(fontSize: 11, color: Color(0xFF878787)),
            ),
          ],
        ),
      ],
    );
  }
}
