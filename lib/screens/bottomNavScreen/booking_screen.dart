import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/booking_card.dart';
import '../../widgets/main_bottom_bar.dart';

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
    return Scaffold(
      backgroundColor: const Color(0xFFF4F8F8),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Color(0xFF2FC1BE),
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'My Bookings',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2FC1BE),
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
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
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
      bottomNavigationBar: MainBottomBar(
        currentIndex: 2,
        onTap: (index) {
          if (index != 2) {
            Get.back();
          }
        },
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
            // Navigate to booking details
          },
        ),
        BookingCard(
          hotelName: 'Heden Golf',
          location: 'Epsom   United Kingdom',
          imagePath: 'assets/hotel2.png',
          dateRange: 'Dec 22 - Dec 26 ,2025',
          status: 'Pending',
          onBookingDetailsTap: () {
            // Navigate to booking details
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
            // Navigate to booking details
          },
        ),
        BookingCard(
          hotelName: 'Sofitel',
          location: 'Epsom   United Kingdom',
          imagePath: 'assets/hotel2.png',
          dateRange: 'Dec 22 - Dec 26 ,2023',
          status: 'Completed',
          onBookingDetailsTap: () {
            // Navigate to booking details
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
            // Navigate to booking details
          },
        ),
        BookingCard(
          hotelName: 'Sofitel',
          location: 'Epsom   United Kingdom',
          imagePath: 'assets/hotel2.png',
          dateRange: 'Dec 21 - Dec 26 ,2021',
          status: 'Cancelled',
          onBookingDetailsTap: () {
            // Navigate to booking details
          },
        ),
      ],
    );
  }
}
