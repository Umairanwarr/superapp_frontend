import 'package:get/get.dart';
import 'package:superapp/screens/bottomNavScreen/dashboard_screen.dart';
import 'package:superapp/screens/notification_screen.dart';

import '../modal/announcement_modal.dart';
import '../modal/hotel_modal.dart';
import '../screens/bottomNavScreen/booking_screen.dart';
import '../screens/bottomNavScreen/explore_screen.dart';
import '../screens/bottomNavScreen/profile_screen.dart';
import '../screens/bottomNavScreen/chat_screen.dart';

class MainScreenController extends GetxController {
  final RxInt bottomIndex = 0.obs;
  final RxInt categoryIndex = 0.obs;

  final List<HotelModal> featuredHotels = const [
    HotelModal(
      name: 'Grand Plaza Hotel',
      location: 'Paris, France',
      rating: 4.8,
      price: '\$180/night',
    ),
    HotelModal(
      name: 'Ocean View Resort',
      location: 'Maldives',
      rating: 4.9,
      price: '\$220/night',
    ),
  ];

  final List<HotelModal> featuredProperties = const [
    HotelModal(
      name: 'Luxury Villa',
      location: 'Dubai Marina',
      rating: 4.8,
      price: '\$1.306 M',
      tag: '+8.5%',
    ),
    HotelModal(
      name: 'City Loft Villa',
      location: 'Miami',
      rating: 4.9,
      price: '\$850 k',
      tag: '+5.2%',
    ),
  ];

  final AnnouncementModal announcement = const AnnouncementModal(
    title: 'Summer Special!',
    description: 'Get 20% off on all hotel bookings this\nmonth',
    buttonText: 'Book now',
  );

  final AnnouncementModal propertyAnnouncement = const AnnouncementModal(
    title: 'Investment Alert!',
    description: 'Exclusive pre-launch properties with up\nto 15% ROI',
    buttonText: 'Explore now',
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
        Get.to(() => const ExploreScreen());
        break;
      case 2:
        if (categoryIndex.value == 1) {
          // Dashboard
          Get.to(() => DashboardScreen());
        } else {
          // Bookings
          Get.to(() => const BookingScreen());
        }
        break;
      case 3:
        if (categoryIndex.value == 1) {
          // Messages
          Get.to(() => const ChatScreen());
        } else {
          // AI
          // TODO: Navigate to AI screen
        }
        break;
      case 4:
        // Profile
        Get.to(() => const ProfileScreen());
        break;
    }
  }

  void onCategoryTap(int index) {
    categoryIndex.value = index;
  }

  void goToNotifiction() {
    Get.to(() => const NotificationScreen());
  }
}
