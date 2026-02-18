import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/filter_bottom_sheet.dart';
import '../widgets/property_filter_bottom_sheet.dart';
import '../widgets/property_card.dart';
import '../widgets/main_bottom_bar.dart';
import '../controllers/main_screen_controller.dart';
import '../services/listing_service.dart';
import 'property_detail_screen.dart';
import 'main_screen.dart';

class PropertySearchScreen extends StatefulWidget {
  const PropertySearchScreen({super.key});

  @override
  State<PropertySearchScreen> createState() => _PropertySearchScreenState();
}

class _PropertySearchScreenState extends State<PropertySearchScreen> {
  int _selectedType = 0;

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
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 10, 16, 0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Color(0xFF2FC1BE),
                      size: 28,
                    ),
                  ),
                  const Text(
                    'Featured Properties',
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
                  'Discover exclusive properties',
                  style: TextStyle(
                    fontSize: 16,
                    color: theme.brightness == Brightness.dark
                        ? Colors.white70
                        : const Color(0xFF1D2330),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 54,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(26),
                  border: Border.all(
                    color: theme.brightness == Brightness.dark
                        ? Colors.white24
                        : const Color(0x9CBAB1B1),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search_rounded,
                      color: Color(0xFF9E9E9F),
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        cursorColor: theme.colorScheme.primary,
                        selectionControls: materialTextSelectionControls,
                        decoration: const InputDecoration(
                          hintText: 'Search Properties...',
                          hintStyle: TextStyle(
                            color: Color(0xFF9AA0AF),
                            fontSize: 18,
                          ),
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
                          builder: (context) =>
                              const PropertyFilterBottomSheet(),
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
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: theme.brightness == Brightness.dark
                      ? const Color(0xFF2C2C2E)
                      : const Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedType = 0),
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: _selectedType == 0
                                ? theme.cardColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: _selectedType == 0
                                ? [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ]
                                : null,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Buy',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: _selectedType == 0
                                  ? const Color(0xFF2FC1BE)
                                  : (theme.brightness == Brightness.dark
                                        ? Colors.white54
                                        : const Color(0xFF9E9E9F)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedType = 1),
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: _selectedType == 1
                                ? theme.cardColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: _selectedType == 1
                                ? [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ]
                                : null,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Rent',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: _selectedType == 1
                                  ? const Color(0xFF2FC1BE)
                                  : (theme.brightness == Brightness.dark
                                        ? Colors.white54
                                        : const Color(0xFF9E9E9F)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Obx(() {
              final properties = controller.allPropertiesData;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${properties.length} Properties Found',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: theme.brightness == Brightness.dark
                            ? Colors.white
                            : const Color(0xFF1D2330),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: theme.brightness == Brightness.dark
                            ? theme.cardColor
                            : const Color(0xFFE8F1F1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFF2FC1BE),
                          width: 0.5,
                        ),
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
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 18,
                            color: theme.colorScheme.primary,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 20),

            Expanded(
              child: Obx(() {
                final properties = controller.allPropertiesData;
                if (properties.isEmpty) {
                  return Center(
                    child: Text(
                      'No properties found',
                      style: TextStyle(
                        fontSize: 16,
                        color: theme.brightness == Brightness.dark
                            ? Colors.white70
                            : const Color(0xFF9AA0AF),
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: properties.length,
                  itemBuilder: (context, index) {
                    final property = properties[index];
                    final title = property['title'] ?? 'Property';
                    final address = property['address'] ?? '';
                    final rating = controller.getRating(property);
                    final price = controller.getPropertyPrice(property);
                    final tag = controller.getPropertyTag(property);
                    final propertyId = property['id'] as int;
                    final images = property['images'] as List<dynamic>?;
                    final imageUrl = (images != null && images.isNotEmpty)
                        ? ListingService.propertyImageUrl(propertyId, 0)
                        : null;
                    return PropertyCard(
                      title: title,
                      location: address,
                      imagePath: 'assets/hotel1.png',
                      imageUrl: imageUrl,
                      rating: rating,
                      price: price.isNotEmpty ? price : '\$0',
                      tag: tag.isNotEmpty ? tag : null,
                      onTap: () => Get.to(
                        () => PropertyDetailScreen(propertyData: property),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
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
    );
  }
}
