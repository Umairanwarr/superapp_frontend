import 'package:get/get.dart';

import '../modal/announcement_modal.dart';
import '../modal/hotel_modal.dart';
import '../screens/bottomNavScreen/booking_screen.dart';

class MainScreenController extends GetxController {
  final RxInt bottomIndex = 0.obs;
  final RxInt categoryIndex = 0.obs;

  final List<HotelModal> featuredHotels = const [
    HotelModal(
      name: 'Grand Plaza Hotel',
      location: 'Paris, France',
      rating: 4.8,
    ),
    HotelModal(
      name: 'Ocean View Resort',
      location: 'Maldives',
      rating: 4.9,
    ),
  ];

  final AnnouncementModal announcement = const AnnouncementModal(
    title: 'Summer Special!',
    description: 'Get 20% off on all hotel bookings this\nmonth',
    buttonText: 'Book now',
  );

  void onBottomNavTap(int index) {
    bottomIndex.value = index;
    
    // Navigate to different screens based on index
    switch (index) {
      case 0:
        // Home - already on main screen
        break;
      case 1:
        // Explore
        // TODO: Navigate to explore screen
        break;
      case 2:
        // Bookings
        Get.to(() => const BookingScreen());
        break;
      case 3:
        // AI
        // TODO: Navigate to AI screen
        break;
      case 4:
        // Profile
        // TODO: Navigate to profile screen
        break;
    }
  }

  void onCategoryTap(int index) {
    categoryIndex.value = index;
  }
}
