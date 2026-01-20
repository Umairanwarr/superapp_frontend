import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../booking_details_screen.dart';
import '../../widgets/booking_card.dart';
import '../../controllers/main_screen_controller.dart';
import 'explore_screen.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF4F8F8),
      child: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
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
                    'My Bookings',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2FC1BE),
                      decoration: TextDecoration.none,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),
            // Tab Bar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0xFFE8E8E8),
                borderRadius: BorderRadius.circular(30),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(26),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                labelColor: const Color(0xFF1D2330),
                unselectedLabelColor: const Color(0xFF1D2330),
                labelStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                ),
                tabs: const [
                  Tab(text: 'Upcoming'),
                  Tab(text: 'Past'),
                  Tab(text: 'Cancelled'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Tab Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildUpcomingTab(),
                  _buildPastTab(),
                  _buildCancelledTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingTab() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        BookingCard(
          hotelName: 'Grand Plaza Hotel',
          location: 'London, United Kingdom',
          imagePath: 'assets/hotel1.png',
          dateRange: 'Dec 13 - Dec 16 ,2025',
          status: 'Confirmed',
          onBookingDetailsTap: () {
            Get.to(() => const BookingDetailsScreen());
          },
        ),
        BookingCard(
          hotelName: 'Heden Golf',
          location: 'Epsom   United Kingdom',
          imagePath: 'assets/hotel2.png',
          dateRange: 'Dec 22 - Dec 26 ,2025',
          status: 'Pending',
          onBookingDetailsTap: () {
            Get.to(() => const BookingDetailsScreen());
          },
        ),
      ],
    );
  }

  Widget _buildPastTab() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        BookingCard(
          hotelName: 'Onomo',
          location: 'Berlin, Germany',
          imagePath: 'assets/hotel1.png',
          dateRange: 'Sep 13 - Sep 16 ,2025',
          status: 'Completed',
          onBookingDetailsTap: () {
            Get.to(() => const BookingDetailsScreen());
          },
        ),
        BookingCard(
          hotelName: 'Sofitel',
          location: 'Epsom   United Kingdom',
          imagePath: 'assets/hotel2.png',
          dateRange: 'Dec 22 - Dec 26 ,2023',
          status: 'Completed',
          onBookingDetailsTap: () {
            Get.to(() => const BookingDetailsScreen());
          },
        ),
      ],
    );
  }

  Widget _buildCancelledTab() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        BookingCard(
          hotelName: 'Adagio',
          location: 'Ankara, Turkey',
          imagePath: 'assets/hotel1.png',
          dateRange: 'Sep 13 - Sep 16 ,2022',
          status: 'Cancelled',
          onBookingDetailsTap: () {
            Get.to(() => const BookingDetailsScreen());
          },
        ),
        BookingCard(
          hotelName: 'Sofitel',
          location: 'Epsom   United Kingdom',
          imagePath: 'assets/hotel2.png',
          dateRange: 'Dec 21 - Dec 26 ,2021',
          status: 'Cancelled',
          onBookingDetailsTap: () {
            Get.to(() => const BookingDetailsScreen());
          },
        ),
      ],
    );
  }
}
