import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PropertyFilterBottomSheet extends StatefulWidget {
  const PropertyFilterBottomSheet({super.key});

  @override
  State<PropertyFilterBottomSheet> createState() => _PropertyFilterBottomSheetState();
}

class _PropertyFilterBottomSheetState extends State<PropertyFilterBottomSheet> {
  int selectedPropertyTypeIndex = 0;
  double priceRange = 2500000; // Default middle value roughly
  int selectedBedroomsIndex = 2; // Default to 2
  int selectedBathroomsIndex = 0; // Default to Any
  final TextEditingController minAreaController = TextEditingController();
  final TextEditingController maxAreaController = TextEditingController();

  final List<Map<String, dynamic>> propertyTypes = [
    {'iconPath': 'assets/filter-home.svg', 'label': 'House'},
    {'iconPath': 'assets/appartment.svg', 'label': 'Appartment'},
    {'iconPath': 'assets/condo.svg', 'label': 'Condo'},
    {'iconPath': 'assets/land.svg', 'label': 'Land'},
    {'iconPath': 'assets/vila.svg', 'label': 'Villa'},
    {'iconPath': 'assets/twinhouse.svg', 'label': 'Townhouse'},
  ];

  final List<String> bedroomOptions = ['Any', '1', '2', '3', '4+'];
  final List<String> bathroomOptions = ['Any', '1', '2', '3', '4+'];

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 60,
              height: 5,
              decoration: BoxDecoration(
                color: const Color(0xFFCFD6DC),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.close, color: Color(0xFF1D2330), size: 24),
              ),
              const Text(
                'Filter options',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1D2330),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    selectedPropertyTypeIndex = 0;
                    priceRange = 50;
                    selectedBedroomsIndex = 0;
                    selectedBathroomsIndex = 0;
                    minAreaController.clear();
                    maxAreaController.clear();
                  });
                },
                child: const Text(
                  'Reset',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2FC1BE),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Property Type
                  const Text(
                    'Property Type',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1D2330),
                    ),
                  ),
                  const SizedBox(height: 16),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.1,
                    ),
                    itemCount: propertyTypes.length,
                    itemBuilder: (context, index) {
                      final isSelected = selectedPropertyTypeIndex == index;
                      return GestureDetector(
                        onTap: () => setState(() => selectedPropertyTypeIndex = index),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFFE0F7F6) : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected ? const Color(0xFF2FC1BE) : const Color(0xFFE8E8E8),
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                propertyTypes[index]['iconPath'],
                                height: 34,
                                width: 34,
                                colorFilter: ColorFilter.mode(
                                  isSelected ? const Color(0xFF2FC1BE) : const Color(0xFF747477),
                                  BlendMode.srcIn,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                propertyTypes[index]['label'],
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected ? const Color(0xFF2FC1BE) : const Color(0xFF747477),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 32),
                  // Price Range
                  const Text(
                    'Price Range',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1D2330),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('\$50',
                          style: TextStyle(
                              color: Color(0xFF9AA0AF),
                              fontWeight: FontWeight.w600,
                              fontSize: 16)),
                      Text('\$8M+',
                          style: TextStyle(
                              color: Color(0xFF9AA0AF),
                              fontWeight: FontWeight.w600,
                              fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SliderTheme(
                    data: SliderThemeData(
                      activeTrackColor: const Color(0xFF2FC1BE).withOpacity(0.3),
                      inactiveTrackColor: const Color(0xFFE8F1F1),
                      thumbColor: const Color(0xFF2FC1BE),
                      overlayColor: const Color(0xFF2FC1BE).withOpacity(0.2),
                      trackHeight: 6,
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
                      trackShape: _FullWidthTrackShape(),
                    ),
                    child: Slider(
                      value: priceRange,
                      min: 50,
                      max: 8000000,
                      onChanged: (val) => setState(() => priceRange = val),
                    ),
                  ),

                  const SizedBox(height: 24),
                  // Bedrooms
                  const Text(
                    'Bedrooms',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1D2330),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(bedroomOptions.length, (index) {
                      final isSelected = selectedBedroomsIndex == index;
                      return GestureDetector(
                        onTap: () => setState(() => selectedBedroomsIndex = index),
                        child: Container(
                          width: 50,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFF2FC1BE) : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected ? const Color(0xFF2FC1BE) : const Color(0xFFE8E8E8),
                            ),
                          ),
                          child: Text(
                            bedroomOptions[index],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.white : const Color(0xFF9AA0AF),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 24),
                  // Bathrooms
                  const Text(
                    'Bathrooms',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1D2330),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(bathroomOptions.length, (index) {
                      final isSelected = selectedBathroomsIndex == index;
                      return GestureDetector(
                        onTap: () => setState(() => selectedBathroomsIndex = index),
                        child: Container(
                          width: 50,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFF2FC1BE) : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected ? const Color(0xFF2FC1BE) : const Color(0xFFE8E8E8),
                            ),
                          ),
                          child: Text(
                            bathroomOptions[index],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.white : const Color(0xFF9AA0AF),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 24),
                  // Living Area
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Living Area',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1D2330),
                        ),
                      ),
                      Text(
                        'sqft',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF9AA0AF),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFE8E8E8)),
                          ),
                          alignment: Alignment.centerLeft,
                          child: TextField(
                            controller: minAreaController,
                            decoration: const InputDecoration(
                              hintText: 'Min',
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Color(0xFF9AA0AF)),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          '-',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF9AA0AF),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFE8E8E8)),
                          ),
                          alignment: Alignment.centerLeft,
                          child: TextField(
                            controller: maxAreaController,
                            decoration: const InputDecoration(
                              hintText: 'Max',
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Color(0xFF9AA0AF)),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          // Footer Button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2FC1BE),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Apply',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FullWidthTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackLeft = offset.dx;
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
