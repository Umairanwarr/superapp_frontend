import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/main_screen_controller.dart';
import '../widgets/main_bottom_bar.dart';
import 'bottomNavScreen/home_screen.dart';
import 'bottomNavScreen/explore_screen.dart';
import 'bottomNavScreen/booking_screen.dart';
import 'bottomNavScreen/profile_screen.dart';
import 'bottomNavScreen/chat_screen.dart';
import 'bottomNavScreen/ai_assistant_screen.dart';
import 'bottomNavScreen/dashboard_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = Get.put(MainScreenController(), permanent: true);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Obx(() {
        final isProperty = controller.categoryIndex.value == 1;

        switch (controller.bottomIndex.value) {
          case 0:
            return const HomeScreen();
          case 1:
            return const ExploreScreen();
          case 2:
            return isProperty ? const DashboardScreen() : const BookingScreen();
          case 3:
            return isProperty ? const ChatScreen() : AiAssistantScreen();

          case 4:
            return const ProfileScreen();
          default:
            return const HomeScreen();
        }
      }),
      bottomNavigationBar: Obx(
        () => MainBottomBar(
          currentIndex: controller.bottomIndex.value,
          onTap: controller.onBottomNavTap,
          isPropertySelected: controller.categoryIndex.value == 1,
        ),
      ),
    );
  }
}
