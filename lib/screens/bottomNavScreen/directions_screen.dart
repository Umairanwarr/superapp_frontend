import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../widgets/main_bottom_bar.dart';
import '../../controllers/main_screen_controller.dart';
import 'booking_screen.dart';

class DirectionsScreen extends StatelessWidget {
  const DirectionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
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
                    'Directions',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2FC1BE),
                    ),
                  ),
                ],
              ),
            ),
            
            // Input Section
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Indicators
                  Padding(
                    padding: const EdgeInsets.only(top: 14),
                    child: Column(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: theme.brightness == Brightness.dark ? Colors.white : Colors.black,
                              width: 2.5,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(
                              3,
                              (index) => Container(
                                width: 4,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: theme.brightness == Brightness.dark ? Colors.white : Colors.black,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.location_on_outlined,
                          color: Colors.red,
                          size: 24,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  
                  // Text Fields
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          height: 48,
                          decoration: BoxDecoration(
                            border: Border.all(color: theme.brightness == Brightness.dark ? Colors.white24 : const Color(0xFFE8E8E8)),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Your Location',
                            style: TextStyle(
                              color: theme.brightness == Brightness.dark ? Colors.white70 : const Color(0xFF555555),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          height: 48,
                          decoration: BoxDecoration(
                            border: Border.all(color: theme.brightness == Brightness.dark ? Colors.white24 : const Color(0xFFE8E8E8)),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Heden golf Hotel',
                            style: TextStyle(
                              color: theme.brightness == Brightness.dark ? Colors.white70 : const Color(0xFF555555),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Map Area
            Expanded(
              child: Stack(
                children: [
                  Image.asset(
                    'assets/direction.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  // Gradient overlay at top to blend map with white background
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: 20,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.05),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MainBottomBar(
        currentIndex: 1, // Explore tab
        onTap: (index) {
          final controller = Get.find<MainScreenController>();
          if (index == 1) {
             Get.back(); // Go back to Explore main view
             return;
          }

          if (index == 0) {
            controller.bottomIndex.value = 0;
            Get.back(); // Back to explore
            Get.back(); // Back to home if needed, or just let MainScreen handle it
            // Since we are pushing this screen, we might need to handle nav carefully.
            // For now, assuming simple back + controller update
          } else if (index == 2) {
            controller.bottomIndex.value = 2;
            Get.off(() => const BookingScreen());
          } else {
            controller.onBottomNavTap(index);
          }
        },
      ),
    );
  }
}
