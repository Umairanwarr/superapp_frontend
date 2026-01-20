import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../widgets/explore_hotel_card.dart';
import '../../controllers/main_screen_controller.dart';
import '../property_detail_screen.dart';
import 'booking_screen.dart';
import 'directions_screen.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MainScreenController>();
    final RxBool isMapView = false.obs;
    final RxInt propertyTypeIndex = 0.obs; // 0 for Buy, 1 for Rent

    return Container(
      color: const Color(0xFFF4F8F8),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
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
                  const SizedBox(width: 16),
                  const Text(
                    'Explore',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2FC1BE),
                      decoration: TextDecoration.none,
                      fontFamily: 'Inter', // Assuming default font
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Header Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Obx(() => _CategoryToggle(
                selectedIndex: controller.categoryIndex.value,
                onChanged: controller.onCategoryTap,
              )),
            ),
            const SizedBox(height: 16),
            // View Toggles
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Obx(() => Row(
                children: [
                  GestureDetector(
                    onTap: () => isMapView.value = false,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: !isMapView.value ? const Color(0xFF2FC1BE) : const Color(0xFFF1F2F3),
                        borderRadius: BorderRadius.circular(12),
                        border: isMapView.value
                            ? Border.all(color: const Color(0xFFE8E8E8), width: 1)
                            : null,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/card.svg',
                          width: 20,
                          height: 20,
                          colorFilter: ColorFilter.mode(
                            !isMapView.value ? Colors.white : const Color(0xFF1D2330),
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => isMapView.value = true,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: isMapView.value ? const Color(0xFF2FC1BE) : const Color(0xFFF1F2F3),
                        borderRadius: BorderRadius.circular(12),
                        border: !isMapView.value
                            ? Border.all(color: const Color(0xFFE8E8E8), width: 1)
                            : null,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/map.svg',
                          width: 20,
                          height: 20,
                          colorFilter: ColorFilter.mode(
                            isMapView.value ? Colors.white : const Color(0xFF1D2330),
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
            ),
            const SizedBox(height: 16),
            // Search Bar
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: _SearchBar(),
            ),
            const SizedBox(height: 16),
            // Buy/Rent Toggle (Only visible when Properties tab is selected)
            Obx(() {
              if (controller.categoryIndex.value == 1) {
                return Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
                  child: _PropertyTypeToggle(
                    selectedIndex: propertyTypeIndex.value,
                    onChanged: (index) => propertyTypeIndex.value = index,
                  ),
                );
              }
              return const SizedBox(height: 4); // Small spacer when hidden
            }),
            // Content
            Expanded(
              child: Obx(() {
                if (isMapView.value) {
                  return Stack(
                    children: [
                      Image.asset(
                        'assets/map.png',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      Center(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  'assets/hotel1.png',
                                  width: 120,
                                  height: 140,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'Heden golf',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(Icons.star, color: Color(0xFFFFA500), size: 16),
                                        const SizedBox(width: 4),
                                        const Text(
                                          '3.9',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF878787),
                                            decoration: TextDecoration.none,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        const Text(
                                          'Reviews (200)',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFF878787),
                                            decoration: TextDecoration.none,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    const Text(
                                      'Set in landscaped gardens overlooking the ...',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Color(0xFF878787),
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              const Text(
                                                '25% OFF',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFFFFA500),
                                                  decoration: TextDecoration.none,
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              const Text(
                                                '\$127',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  decoration: TextDecoration.none,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () => Get.to(() => const DirectionsScreen()),
                                              child: Container(
                                                width: 36,
                                                height: 36,
                                                padding: const EdgeInsets.all(8),
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFF2FC1BE),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: SvgPicture.asset(
                                                  'assets/direction.svg',
                                                  colorFilter: const ColorFilter.mode(
                                                    Colors.white,
                                                    BlendMode.srcIn,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            GestureDetector(
                                              onTap: () => Get.to(() => const DirectionsScreen()),
                                              child: const Text(
                                                'Directions',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xFF2FC1BE),
                                                  fontWeight: FontWeight.w500,
                                                  decoration: TextDecoration.none,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return Obx(() {
                  final isProperty = controller.categoryIndex.value == 1;
                  return ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: isProperty
                        ? [
                            ExploreHotelCard(
                              title: 'Luxury Villa',
                              location: 'Dubai Marina · Waterfront',
                              imagePath: 'assets/hotel1.png',
                              rating: 4.9,
                              price: 850,
                              onTap: () => Get.to(() => const PropertyDetailScreen()),
                            ),
                            const SizedBox(height: 16),
                            ExploreHotelCard(
                              title: 'City Loft',
                              location: 'New York · Manhattan',
                              imagePath: 'assets/hotel2.png',
                              rating: 4.7,
                              price: 450,
                              onTap: () => Get.to(() => const PropertyDetailScreen()),
                            ),
                          ]
                        : const [
                            ExploreHotelCard(
                              title: 'Grand Plaza Hotel',
                              location: 'Paris, France · 2.5 km away from centre',
                              imagePath: 'assets/hotel1.png',
                              rating: 4.8,
                              price: 180,
                            ),
                            SizedBox(height: 16),
                            ExploreHotelCard(
                              title: 'Ocean View Resort',
                              location: 'Maldives · Beach-front',
                              imagePath: 'assets/hotel2.png',
                              rating: 4.9,
                              price: 220,
                            ),
                            SizedBox(height: 16),
                            ExploreHotelCard(
                              title: 'Alpine Lodge',
                              location: 'Switzerland · Mountain View',
                              imagePath: 'assets/hotel1.png',
                              rating: 4.7,
                              price: 250,
                            ),
                            SizedBox(height: 16),
                            ExploreHotelCard(
                              title: 'Urban Boutique',
                              location: 'New York · City Center',
                              imagePath: 'assets/hotel2.png',
                              rating: 4.6,
                              price: 300,
                            ),
                            SizedBox(height: 20),
                          ],
                  );
                });
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryToggle extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const _CategoryToggle({required this.selectedIndex, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: const Color(0xFF2FC1BE).withOpacity(0.15),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          Expanded(
            child: _CategoryChip(
              selected: selectedIndex == 0,
              iconAssetPath: 'assets/hotel-header.png',
              label: 'Hotels',
              onTap: () => onChanged(0),
            ),
          ),
          Expanded(
            child: _CategoryChip(
              selected: selectedIndex == 1,
              iconAssetPath: 'assets/property-header.png',
              label: 'Properties',
              onTap: () => onChanged(1),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final bool selected;
  final String iconAssetPath;
  final String label;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.selected,
    required this.iconAssetPath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconAssetPath.endsWith('.svg'))
              SvgPicture.asset(
                iconAssetPath,
                width: 22,
                height: 22,
                colorFilter: ColorFilter.mode(
                  selected ? theme.colorScheme.primary : const Color(0xFF2FC1BE),
                  BlendMode.srcIn,
                ),
              )
            else
              Image.asset(
                iconAssetPath,
                width: 22,
                height: 22,
                color: selected ? theme.colorScheme.primary : const Color(0xFF2FC1BE),
              ),
            const SizedBox(width: 8),
            Text(
              label,
              style: theme.textTheme.titleMedium?.copyWith(
                color: selected
                    ? theme.colorScheme.primary
                    : const Color(0xFF2FC1BE),
                fontWeight: FontWeight.w600,
                fontSize: 18,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 54,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: const Color(0x9CBAB1B1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.search_rounded, color: Color(0xFF9E9E9F), size: 24),
          const SizedBox(width: 8),
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: Obx(() => TextField(
                cursorColor: theme.colorScheme.primary,
                selectionControls: materialTextSelectionControls,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: Get.find<MainScreenController>().categoryIndex.value == 1 
                      ? 'Search properties...' 
                      : 'Search hotels...',
                  hintStyle: const TextStyle(color: Color(0xFF9AA0AF), fontSize: 18),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                ),
              )),
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Image.asset(
                'assets/search-location.png',
                width: 18,
                height: 18,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PropertyTypeToggle extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const _PropertyTypeToggle({
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(23),
        border: Border.all(
          color: const Color(0xFFE8E8E8),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => onChanged(0),
              child: Container(
                decoration: BoxDecoration(
                  color: selectedIndex == 0 ? const Color(0xFF2FC1BE) : Colors.transparent,
                  borderRadius: BorderRadius.circular(23),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Buy',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: selectedIndex == 0 ? Colors.white : const Color(0xFF878787),
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => onChanged(1),
              child: Container(
                decoration: BoxDecoration(
                  color: selectedIndex == 1 ? const Color(0xFF2FC1BE) : Colors.transparent,
                  borderRadius: BorderRadius.circular(23),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Rent',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: selectedIndex == 1 ? Colors.white : const Color(0xFF878787),
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
