import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:superapp/modal/on_boarding_modal.dart';
import 'package:superapp/screens/auth/signin_screen.dart';

class OnBoardingController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentIndex = 0.obs;

  final List<OnboardingModal> item = [
    OnboardingModal(
      image: 'assets/on_boarding_1.png',
      title: 'Book Hotels Effortlessly',
      subtitle: 'Find the best hotels',
    ),
    OnboardingModal(
      image: 'assets/on_boarding_2.png',
      title: 'Buy, Rent & Sell Properties',
      subtitle: 'Rent, buy, or sell properties with\nverified listings',
    ),
    OnboardingModal(
      image: 'assets/on_boarding_3.png',
      title: 'AI + AR Experience',
      subtitle:
          'Explore properties and hotels with\nAI insights and immersive AR views',
    ),
  ];
  void onPageChanged(int index) {
    currentIndex.value = index;
  }

  void next() {
    if (currentIndex.value < item.length - 1) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } else {
      finish();
    }
  }

  void skip() => finish();

  void finish() {
    Get.offAll(() => SignInScreen());
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
