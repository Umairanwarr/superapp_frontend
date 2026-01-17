import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  const HotelDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
                  const HotelHeaderInfo(),
                  const SizedBox(height: 24),
                  const CheckInOutSection(),
                  const SizedBox(height: 24),
                  const ARExperienceSection(),
                  const SizedBox(height: 24),
                  const HotelAmenitiesSection(),
                  const SizedBox(height: 24),
                  const HotelAboutSection(),
                  const SizedBox(height: 24),
                  const SelectRoomSection(),
                  const SizedBox(height: 24),
                  const HotelReviewsSection(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MainBottomBar(
        currentIndex: 0,
        onTap: (index) => Get.back(),
      ),
    );
  }
}
