import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../controllers/main_screen_controller.dart';
import '../widgets/hotel_image_carousel.dart';
import '../widgets/hotel_reviews_section.dart';
import '../widgets/main_bottom_bar.dart';
import 'main_screen.dart';
import 'booking_summary_screen.dart';

class PropertyDetailScreen extends StatelessWidget {
  const PropertyDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<MainScreenController>()
        ? Get.find<MainScreenController>()
        : Get.put(MainScreenController());
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        top: false,
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HotelImageCarousel(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    _PropertyHeaderInfo(theme),
                    const SizedBox(height: 18),
                    _PropertyARExperienceSection(theme),
                    const SizedBox(height: 24),
                    _PropertyFeaturesSection(theme),
                    const SizedBox(height: 22),
                    _PropertyAmenitiesSection(theme),
                    const SizedBox(height: 22),
                    _InvestmentAnalysisSection(theme),
                    const SizedBox(height: 22),
                    _AboutSection(theme),
                    const SizedBox(height: 22),
                    _NeighborhoodInsightsSection(theme),
                    const SizedBox(height: 22),
                    const HotelReviewsSection(),
                    const SizedBox(height: 22),
                    _ListedBySection(theme),
                    const SizedBox(height: 110),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _BottomBar(theme),
          Obx(
            () => MainBottomBar(
              currentIndex: controller.bottomIndex.value,
              isPropertySelected: true,
              onTap: (index) {
                controller.categoryIndex.value = 1;
                controller.bottomIndex.value = index;
                Get.offAll(() => const MainScreen());
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PropertyHeaderInfo extends StatelessWidget {
  final ThemeData theme;
  const _PropertyHeaderInfo(this.theme);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Luxury Villa',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: theme.brightness == Brightness.dark ? Colors.white : const Color(0xFF1D2330),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text(
                    'Superb',
                    style: TextStyle(
                      color: Color(0xFF2FC1BE),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '120 reviews',
                    style: TextStyle(
                      color: theme.brightness == Brightness.dark ? Colors.white70 : const Color(0xFF9AA0AF),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.near_me, size: 16, color: theme.brightness == Brightness.dark ? Colors.white70 : const Color(0xFF9AA0AF)),
                  const SizedBox(width: 4),
                  Text(
                    'Dubai Marina',
                    style: TextStyle(
                      color: theme.brightness == Brightness.dark ? Colors.white70 : const Color(0xFF9AA0AF),
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
            color: theme.brightness == Brightness.dark ? const Color(0xFF2FC1BE).withOpacity(0.2) : const Color(0xFFDDF4F4),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFF2FC1BE).withOpacity(0.3)),
          ),
          child: Row(
            children: [
              const Icon(Icons.star, color: Color(0xFFFFB300), size: 18),
              const SizedBox(width: 4),
              Text(
                '4.8',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  color: theme.brightness == Brightness.dark ? Colors.white : const Color(0xFF1D2330),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PropertyARExperienceSection extends StatelessWidget {
  final ThemeData theme;
  const _PropertyARExperienceSection(this.theme);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark ? const Color(0xFF2FC1BE).withOpacity(0.1) : const Color(0x292FC1BE),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF2FC1BE), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: Color(0xFF2FC1BE),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    'assets/ai.png',
                    width: 22,
                    height: 22,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Experience in AR',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: theme.brightness == Brightness.dark ? Colors.white : const Color(0xFF1D2330),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Take a closer property in augmented reality',
                      style: TextStyle(
                        color: theme.brightness == Brightness.dark ? Colors.white70 : const Color(0xFF1D2330),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2FC1BE),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Start Tour',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PropertyFeaturesSection extends StatelessWidget {
  final ThemeData theme;
  const _PropertyFeaturesSection(this.theme);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Property Features',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: theme.brightness == Brightness.dark ? Colors.white : const Color(0xFF1D2330),
          ),
        ),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _FeatureTile(iconPath: 'assets/bedroom.svg', label: '3 Bedrooms', theme: theme),
            _FeatureTile(iconPath: 'assets/bathroom.svg', label: '2 Bathroom', theme: theme),
            _FeatureTile(iconPath: 'assets/sqft.svg', label: '2500 sqft', theme: theme),
            _FeatureTile(iconPath: 'assets/vila.svg', label: 'Villa', theme: theme),
          ],
        ),
      ],
    );
  }
}

class _FeatureTile extends StatelessWidget {
  final String iconPath;
  final String label;
  final ThemeData theme;

  const _FeatureTile({required this.iconPath, required this.label, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: theme.brightness == Brightness.dark ? const Color(0xFF2FC1BE).withOpacity(0.1) : const Color(0x292FC1BE),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF2FC1BE), width: 1.5),
          ),
          child: Center(
            child: SvgPicture.asset(
              iconPath,
              width: 26,
              height: 26,
              colorFilter: ColorFilter.mode(
                theme.brightness == Brightness.dark ? const Color(0xFF2FC1BE) : const Color(0xFF1B8785),
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 70,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: theme.brightness == Brightness.dark ? Colors.white70 : const Color(0xFF9AA0AF),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _PropertyAmenitiesSection extends StatelessWidget {
  final ThemeData theme;
  const _PropertyAmenitiesSection(this.theme);

  @override
  Widget build(BuildContext context) {
    const amenities = [
      'Wifi',
      'Parking',
      'Washer',
      'Gym',
      'Balcony',
      'Air Conditioning',
      'Pool',
      'Heating',
      'Dryer',
      'Elevator',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Amenities',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: theme.brightness == Brightness.dark ? Colors.white : const Color(0xFF1D2330),
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: amenities
              .map(
                (a) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2FC1BE),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Text(
                    a,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _InvestmentAnalysisSection extends StatelessWidget {
  final ThemeData theme;
  const _InvestmentAnalysisSection(this.theme);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark ? const Color(0xFF21C96A).withOpacity(0.15) : const Color(0xFFE6FBEA),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFF21C96A).withOpacity(0.25),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF21C96A),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/ai.png',
                    width: 20,
                    height: 20,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AI Investment Analysis',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: theme.brightness == Brightness.dark ? Colors.white : const Color(0xFF1D2330),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Based on market trends and location\ndata',
                      style: TextStyle(
                        color: theme.brightness == Brightness.dark ? Colors.white70 : const Color(0xFF1D2330),
                        fontSize: 13,
                        height: 1.2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Projected ROI',
                      style: TextStyle(
                        color: theme.brightness == Brightness.dark ? Colors.white70 : const Color(0xFF1D2330),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '+8.5%',
                      style: TextStyle(
                        color: Color(0xFF21C96A),
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Price Trend',
                      style: TextStyle(
                        color: theme.brightness == Brightness.dark ? Colors.white70 : const Color(0xFF1D2330),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '↑6% YoY',
                      style: TextStyle(
                        color: Color(0xFF21C96A),
                        fontSize: 22,
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
    );
  }
}

class _AboutSection extends StatelessWidget {
  final ThemeData theme;
  const _AboutSection(this.theme);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: theme.brightness == Brightness.dark ? Colors.white : const Color(0xFF1D2330),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Stunning modern villa in the heart of Dubai Marina.\nThis luxurious property features contemporary design,\nhigh-end finishes, and breathtaking views of the\nmarina. Perfect for investors looking for high-yield\nopportunities in prime locations.',
          style: TextStyle(
            color: theme.brightness == Brightness.dark ? Colors.white70 : const Color(0xFF9AA0AF),
            fontSize: 14,
            height: 1.6,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _NeighborhoodInsightsSection extends StatelessWidget {
  final ThemeData theme;
  const _NeighborhoodInsightsSection(this.theme);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Neighborhood Insights',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: theme.brightness == Brightness.dark ? Colors.white : const Color(0xFF1D2330),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: const Color(0xFF2FC1BE).withOpacity(0.25),
              width: 1.5,
            ),
          ),
          child: Column(
            children: [
              _InsightRow(title: 'Schools', rating: '4.5/5', theme: theme),
              const SizedBox(height: 22),
              _InsightRow(title: 'Transportation', rating: '4.8/5', theme: theme),
              const SizedBox(height: 22),
              _InsightRow(title: 'Shopping', rating: '4.7/5', theme: theme),
            ],
          ),
        ),
      ],
    );
  }
}

class _InsightRow extends StatelessWidget {
  final String title;
  final String rating;
  final ThemeData theme;

  const _InsightRow({required this.title, required this.rating, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: theme.brightness == Brightness.dark ? Colors.white : const Color(0xFF1D2330),
            ),
          ),
        ),
        const Icon(Icons.star, color: Color(0xFFFFB300), size: 16),
        const SizedBox(width: 6),
        Text(
          rating,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: theme.brightness == Brightness.dark ? Colors.white : const Color(0xFF1D2330),
          ),
        ),
      ],
    );
  }
}

class _ListedBySection extends StatelessWidget {
  final ThemeData theme;
  const _ListedBySection(this.theme);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Listed By',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: theme.brightness == Brightness.dark ? Colors.white : const Color(0xFF1D2330),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF2FC1BE), width: 1.5),
          ),
          child: Row(
            children: [
              // Avatar with RE initials
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: theme.brightness == Brightness.dark ? const Color(0xFF2FC1BE).withOpacity(0.2) : const Color(0xFFE8F7F7),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    'RE',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: theme.brightness == Brightness.dark ? const Color(0xFF2FC1BE) : const Color(0xFF1D2330),
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              // Name and rating section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Real Estate',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: theme.brightness == Brightness.dark ? Colors.white : const Color(0xFF1D2330),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Color(0xFFFFB300), size: 16),
                        const SizedBox(width: 4),
                        Text(
                          '4.9',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: theme.brightness == Brightness.dark ? Colors.white : const Color(0xFF1D2330),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(127 reviews)',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: theme.brightness == Brightness.dark ? Colors.white70 : const Color(0xFF9AA0AF),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Verified badge and Contact button column
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Verified badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'assets/verified.svg',
                          width: 12,
                          height: 12,
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'Verified',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Contact button
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: theme.brightness == Brightness.dark ? Colors.white24 : const Color(0xFFE0E0E0),
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 16,
                          color: theme.brightness == Brightness.dark ? Colors.white : const Color(0xFF1D2330),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Contact',
                          style: TextStyle(
                            color: theme.brightness == Brightness.dark ? Colors.white : const Color(0xFF1D2330),
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
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
    );
  }
}

class _BottomBar extends StatelessWidget {
  final ThemeData theme;
  const _BottomBar(this.theme);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 34),
      decoration: BoxDecoration(
        color: theme.cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
        border: const Border(
          top: BorderSide(color: Color(0xFF2FC1BE), width: 1.5),
        ),
      ),
      child: Row(
        children: [
          // Price section
          Expanded(
            flex: 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Price',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: theme.brightness == Brightness.dark ? Colors.white : const Color(0xFF1D2330),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  '\$1.8 M',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF2FC1BE),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Schedule Visit button
          Expanded(
            flex: 3,
            child: SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: () => Get.to(
                  () => const BookingSummaryScreen(bookingType: 'property'),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2FC1BE),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.white,
                      size: 18,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Schedule Visit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
