import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  int adults = 2;
  int children = 1;
  double priceRange = 500;
  List<String> selectedAmenities = ['Free wifi'];

  final List<String> amenities = [
    'Free wifi',
    'Gym',
    'Pool',
    'Pet Friendly',
    'Breakfast',
    'Parking'
  ];

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
                    adults = 2;
                    children = 1;
                    priceRange = 500;
                    selectedAmenities = ['Free wifi'];
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
                  // Number of Guests
                  const Text(
                    'Number of Guests',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1D2330),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2FC1BE).withOpacity(0.16),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _circularButton(Icons.remove, () {
                          if (adults > 1) setState(() => adults--);
                        }),
                        Text(
                          '$adults Adults, $children Child',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1D2330),
                          ),
                        ),
                        _circularButton(Icons.add, () => setState(() => adults++)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _counterRow('Adults', adults, (val) => setState(() => adults = val)),
                  _counterRow('Childrens', children, (val) => setState(() => children = val)),
                  
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
                      Text('\$1000+',
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
                      thumbShape:
                          const RoundSliderThumbShape(enabledThumbRadius: 12),
                      trackShape: _FullWidthTrackShape(),
                    ),
                    child: Slider(
                      value: priceRange,
                      min: 50,
                      max: 1000,
                      onChanged: (val) => setState(() => priceRange = val),
                    ),
                  ),

                  const SizedBox(height: 24),
                  // Calendar
                  const Text(
                    'Check-in/Check-out Dates',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1D2330),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFADAEBC), width: 1.5),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'December',
                          style: TextStyle(
                            color: Color(0xFF9AA0AF),
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildCalendarGrid(),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Check-in', style: TextStyle(color: Color(0xFF9AA0AF), fontSize: 14, fontWeight: FontWeight.w500)),
                                SizedBox(height: 4),
                                Text('Dec 13', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Text('Check-out', style: TextStyle(color: Color(0xFF9AA0AF), fontSize: 14, fontWeight: FontWeight.w500)),
                                SizedBox(height: 4),
                                Text('Dec 16', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                  // Amenities
                  const Text(
                    'Amenities',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1D2330),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: amenities.map((amenity) {
                      bool isSelected = selectedAmenities.contains(amenity);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              selectedAmenities.remove(amenity);
                            } else {
                              selectedAmenities.add(amenity);
                            }
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFFE8F1F1) : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFF2FC1BE),
                              width: 1.5,
                            ),
                          ),
                          child: Text(
                            amenity,
                            style: const TextStyle(
                              color: Color(0xFF2FC1BE),
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 32),
                  // Apply Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2FC1BE),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Apply',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final List<String> weekdays = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];
    
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: weekdays.map((day) => Expanded(
            child: Center(
              child: Text(
                day,
                style: TextStyle(
                  color: (day == 'Sa' || day == 'Su') ? const Color(0xFF2FC1BE) : const Color(0xFF9AA0AF),
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
          )).toList(),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: 35,
          itemBuilder: (context, index) {
            int day = index - 2;
            if (day < 1 || day > 31) return const SizedBox();
            
            bool isSelectedStart = day == 13;
            bool isSelectedEnd = day == 16;
            bool inRange = day > 13 && day < 16;
            bool isWeekend = (index % 7 == 5 || index % 7 == 6);

            return Center(
              child: Text(
                '$day',
                style: TextStyle(
                  color: (isSelectedStart || isSelectedEnd || inRange) 
                      ? const Color(0xFF1D2330) // Dark for selection
                      : (isWeekend ? const Color(0xFF2FC1BE) : const Color(0xFF9AA0AF)),
                  fontWeight: (isSelectedStart || isSelectedEnd) ? FontWeight.w800 : FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _circularButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, color: const Color(0xFF2FC1BE), size: 24),
      ),
    );
  }

  Widget _counterRow(String label, int value, Function(int) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1D2330),
            ),
          ),
          Row(
            children: [
              _smallCounterButton(Icons.remove, () {
                if (value > 0) onChanged(value - 1);
              }),
              const SizedBox(width: 16),
              Text(
                '$value',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1D2330),
                ),
              ),
              const SizedBox(width: 16),
              _smallCounterButton(Icons.add, () => onChanged(value + 1)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _smallCounterButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: const Color(0xFFDDF4F4),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: const Color(0xFF2FC1BE), size: 18),
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
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
