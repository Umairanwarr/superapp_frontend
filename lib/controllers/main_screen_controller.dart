import 'package:get/get.dart';

import '../modal/announcement_modal.dart';
import '../modal/hotel_modal.dart';

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
  }

  void onCategoryTap(int index) {
    categoryIndex.value = index;
  }
}
