import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superapp/screens/bottomNavScreens/booking_screen.dart';
import 'package:superapp/screens/bottomNavScreens/explore_screen.dart';
import 'package:superapp/screens/bottomNavScreens/home_screen.dart';
import 'package:superapp/screens/bottomNavScreens/chat_screen.dart';
import 'package:superapp/screens/bottomNavScreens/profile_screen.dart';

import '../controllers/main_screen_controller.dart';
import '../widgets/main_bottom_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = Get.put(MainScreenController());

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Obx(() {
        return IndexedStack(
          index: controller.bottomIndex.value,
          children: const [
            HomeScreen(),
            ExploreScreen(),
            BookingScreen(),
            ChatScreen(),
            ProfileScreen(),
          ],
        );
      }),

      bottomNavigationBar: Obx(
        () => _MainBottomBar(
          currentIndex: controller.bottomIndex.value,
          onTap: controller.onBottomNavTap,
        ),
      ),
    );
  }
}

class _MainBottomBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _MainBottomBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return MainBottomBar(currentIndex: currentIndex, onTap: onTap);
  }
}
