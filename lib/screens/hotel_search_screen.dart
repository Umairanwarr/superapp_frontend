import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/filter_bottom_sheet.dart';
import '../widgets/hotel_card.dart';
import '../widgets/main_bottom_bar.dart';
import '../controllers/main_screen_controller.dart';
import 'main_screen.dart';

class HotelSearchScreen extends StatelessWidget {
  const HotelSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = Get.isRegistered<MainScreenController>()
        ? Get.find<MainScreenController>()
        : Get.put(MainScreenController());

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 10, 16, 0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded,
                        color: Color(0xFF2FC1BE), size: 28),
                  ),
                  const Text(
                    'Hotels',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2FC1BE),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 56, right: 24),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Explore hotels curated for your stay',
                  style: TextStyle(
                    fontSize: 16,
                    color: theme.brightness == Brightness.dark ? Colors.white70 : const Color(0xFF1D2330),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Search Bar & Filter
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 54,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(26),
                  border: Border.all(
                    color: theme.brightness == Brightness.dark ? Colors.white24 : const Color(0x9CBAB1B1),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search_rounded,
                        color: Color(0xFF9E9E9F), size: 24),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        cursorColor: theme.colorScheme.primary,
                        selectionControls: materialTextSelectionControls,
                        decoration: const InputDecoration(
                          hintText: 'Search hotels...',
                          hintStyle:
                              TextStyle(color: Color(0xFF9AA0AF), fontSize: 18),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => const FilterBottomSheet(),
                        );
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Color(0xFF2FC1BE),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/filter.svg',
                            width: 18,
                            height: 18,
                            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Results Info & Sort
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '142 Hotels Found',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: theme.brightness == Brightness.dark ? Colors.white : const Color(0xFF1D2330),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: theme.brightness == Brightness.dark ? theme.cardColor : const Color(0xFFE8F1F1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFF2FC1BE), width: 0.5),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'sort by : Recommended',
                          style: TextStyle(
                            fontSize: 12,
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(Icons.keyboard_arrow_down_rounded,
                            size: 18, color: theme.colorScheme.primary),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Hotel List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: const [
                  HotelCard(
                    title: 'Grand Plaza Hotel',
                    location: 'Paris, France · 2.5 km away from centre',
                    imagePath: 'assets/hotel1.png',
                    rating: 4.8,
                    price: 180,
                    amenities: ['Free wifi', 'Pools', 'Breakfast'],
                  ),
                  HotelCard(
                    title: 'Ocean View Resort',
                    location: 'Maldives · Beach-front',
                    imagePath: 'assets/hotel2.png',
                    rating: 4.9,
                    price: 220,
                    amenities: ['Spa', 'Gym', 'Breakfast'],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => MainBottomBar(
          currentIndex: controller.bottomIndex.value,
          isPropertySelected: controller.categoryIndex.value == 1,
          onTap: (index) {
            controller.categoryIndex.value = 0;
            controller.bottomIndex.value = index;
            Get.offAll(() => const MainScreen());
          },
        ),
      ),
    );
  }
}
