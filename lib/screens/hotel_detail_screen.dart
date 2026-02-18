import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_screen_controller.dart';
import '../screens/main_screen.dart';
import '../services/listing_service.dart';
import '../widgets/main_bottom_bar.dart';
import '../widgets/hotel_image_carousel.dart';
import '../widgets/hotel_header_info.dart';
import '../widgets/check_in_out_section.dart';
import '../widgets/ar_experience_section.dart';
import '../widgets/hotel_amenities_section.dart';
import '../widgets/hotel_about_section.dart';
import '../widgets/select_room_section.dart';
import '../widgets/hotel_reviews_section.dart';

class HotelDetailScreen extends StatelessWidget {
  final Map<String, dynamic>? hotelData;

  const HotelDetailScreen({super.key, this.hotelData});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<MainScreenController>()
        ? Get.find<MainScreenController>()
        : Get.put(MainScreenController());
    final theme = Theme.of(context);

    // Extract data
    final title = hotelData?['title'] ?? 'Grand Plaza Hotel';
    final address = hotelData?['address'] ?? 'London';
    final description = hotelData?['description'] ?? '';
    final amenities =
        (hotelData?['amenities'] as List<dynamic>?)?.cast<String>() ?? [];
    final rooms = (hotelData?['rooms'] as List<dynamic>?) ?? [];
    final reviews = (hotelData?['reviews'] as List<dynamic>?) ?? [];
    final images = (hotelData?['images'] as List<dynamic>?) ?? [];
    final hotelId = hotelData?['id'] as int?;

    // Calculate rating
    double rating = 0.0;
    if (reviews.isNotEmpty) {
      double sum = 0;
      for (final r in reviews) {
        sum += (r['rating'] as num?)?.toDouble() ?? 0;
      }
      rating = sum / reviews.length;
    }

    // Rating label
    String ratingLabel = 'New';
    if (rating >= 4.5) {
      ratingLabel = 'Superb';
    } else if (rating >= 4.0) {
      ratingLabel = 'Excellent';
    } else if (rating >= 3.5) {
      ratingLabel = 'Very Good';
    } else if (rating >= 3.0) {
      ratingLabel = 'Good';
    } else if (rating > 0) {
      ratingLabel = 'Average';
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HotelImageCarousel(
              imageUrls: images.isNotEmpty && hotelId != null
                  ? List.generate(
                      images.length,
                      (i) => ListingService.hotelImageUrl(hotelId, i),
                    )
                  : null,
              hotelId: hotelId,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  HotelHeaderInfo(
                    name: title,
                    rating: rating,
                    ratingLabel: ratingLabel,
                    reviewCount: reviews.length,
                    location: address,
                  ),
                  const SizedBox(height: 24),
                  const CheckInOutSection(),
                  const SizedBox(height: 24),
                  const ARExperienceSection(),
                  const SizedBox(height: 24),
                  HotelAmenitiesSection(amenities: amenities),
                  const SizedBox(height: 24),
                  HotelAboutSection(description: description),
                  const SizedBox(height: 24),
                  SelectRoomSection(rooms: rooms),
                  const SizedBox(height: 24),
                  const HotelReviewsSection(),
                  const SizedBox(height: 100),
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
