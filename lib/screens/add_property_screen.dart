import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPropertyScreen extends StatefulWidget {
  const AddPropertyScreen({super.key});

  @override
  State<AddPropertyScreen> createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  // State variables for selections
  String _selectedPropertyType = 'Villa';
  String _listingType = 'For Sale';
  final List<String> _selectedAmenities = ['Wifi', 'Parking', 'Pool'];

  final List<String> _propertyTypes = ['Villa', 'Apartment', 'House', 'Condo'];
  final List<String> _amenities = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F8F8),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF2FC1BE),
          ),
        ),
        title: Text(
          'Add Property',
          style: GoogleFonts.outfit(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF2FC1BE),
          ),
        ),
        centerTitle: false, // Aligned to left
        titleSpacing: 0,
        backgroundColor: const Color(0xFFF4F8F8),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Property Images
            _SectionLabel('Property Images'),
            const SizedBox(height: 12),
            Container(
              width: 140, // Approximate size from image
              height: 120,
              decoration: DottedDecoration(
                color: const Color(0xFFD1D5DB),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.camera_alt_outlined,
                    color: Color(0xFF9CA3AF),
                    size: 28,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Add Photo',
                    style: GoogleFonts.outfit(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Property Name
            _SectionLabel('Property Name'),
            const SizedBox(height: 12),
            _buildTextField(hint: 'Enter property name'),
            const SizedBox(height: 24),

            // Property Type
            _SectionLabel('Property Type'),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _propertyTypes.map((type) {
                  final isSelected = _selectedPropertyType == type;
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedPropertyType = type),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF2FC1BE)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: isSelected
                              ? null
                              : Border.all(color: const Color(0xFFE5E7EB)),
                        ),
                        child: Text(
                          type,
                          style: GoogleFonts.outfit(
                            color: isSelected
                                ? Colors.white
                                : const Color(0xFF4B5563),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),

            // Listing Type
            _SectionLabel('Listing Type'),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _listingType = 'For Sale'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: _listingType == 'For Sale'
                            ? const Color(0xFF2FC1BE)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: _listingType == 'For Sale'
                            ? null
                            : Border.all(color: const Color(0xFFE5E7EB)),
                      ),
                      child: Text(
                        'For Sale',
                        style: GoogleFonts.outfit(
                          color: _listingType == 'For Sale'
                              ? Colors.white
                              : const Color(0xFF4B5563),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _listingType = 'For Rent'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: _listingType == 'For Rent'
                            ? const Color(0xFF2FC1BE)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: _listingType == 'For Rent'
                            ? null
                            : Border.all(color: const Color(0xFFE5E7EB)),
                      ),
                      child: Text(
                        'For Rent',
                        style: GoogleFonts.outfit(
                          color: _listingType == 'For Rent'
                              ? Colors.white
                              : const Color(0xFF4B5563),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Price
            _SectionLabel('Price'),
            const SizedBox(height: 12),
            _buildTextField(hint: '0.00'),
            const SizedBox(height: 24),

            // Location
            _SectionLabel('Location'),
            const SizedBox(height: 12),
            _buildTextField(hint: 'Enter address'),
            const SizedBox(height: 24),

            // Property Details
            _SectionLabel('Property Details'),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildDetailInput(label: 'Bedrooms', hint: '0'),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildDetailInput(label: 'Bathrooms', hint: '0'),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildDetailInput(label: 'Sqft', hint: '0'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Amenities
            _SectionLabel('Amenities'),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _amenities.map((amenity) {
                final isSelected = _selectedAmenities.contains(amenity);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        _selectedAmenities.remove(amenity);
                      } else {
                        _selectedAmenities.add(amenity);
                      }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF2FC1BE)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: isSelected
                          ? null
                          : Border.all(color: const Color(0xFFE5E7EB)),
                    ),
                    child: Text(
                      amenity,
                      style: GoogleFonts.outfit(
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFF4B5563),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Description
            _SectionLabel('Description'),
            const SizedBox(height: 12),
            _buildTextField(hint: 'Describe your property...', maxLines: 5),
            const SizedBox(height: 32),

            // Add Property Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  // Handle form submission
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2FC1BE),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                  textStyle: GoogleFonts.outfit(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                child: const Text('Add Property'),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({required String hint, int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.outfit(
          color: const Color(0xFF9CA3AF),
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF9CA3AF), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF2FC1BE), width: 1.5),
        ),
      ),
      style: GoogleFonts.outfit(color: const Color(0xFF1F2937), fontSize: 16),
    );
  }

  Widget _buildDetailInput({required String label, required String hint}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(
            color: const Color(0xFF6B7280),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        _buildTextField(hint: hint),
      ],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.outfit(
        color: const Color(0xFF374151),
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

// Custom painter for dotted border decoration
class DottedDecoration extends Decoration {
  final Color color;
  final BorderRadius borderRadius;

  const DottedDecoration({required this.color, required this.borderRadius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _DottedBoxPainter(color, borderRadius);
  }
}

class _DottedBoxPainter extends BoxPainter {
  final Color color;
  final BorderRadius borderRadius;

  _DottedBoxPainter(this.color, this.borderRadius);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final rect = offset & configuration.size!;
    final rrect = RRect.fromRectAndCorners(
      rect,
      topLeft: borderRadius.topLeft,
      topRight: borderRadius.topRight,
      bottomLeft: borderRadius.bottomLeft,
      bottomRight: borderRadius.bottomRight,
    );

    final path = Path()..addRRect(rrect);
    final metrics = path.computeMetrics();

    for (final metric in metrics) {
      var distance = 0.0;
      while (distance < metric.length) {
        final start = metric.getTangentForOffset(distance)!.position;
        final end = metric
            .getTangentForOffset(distance + 4)!
            .position; // Dash length
        canvas.drawLine(start, end, paint);
        distance += 8; // Dash length + Gap length
      }
    }
  }
}
