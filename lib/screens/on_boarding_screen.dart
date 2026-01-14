import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superapp/controllers/on_boarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  const Spacer(),
                  TextButton(
                    onPressed: controller.skip,
                    child: Text(
                      'Skip',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                itemCount: controller.item.length,
                itemBuilder: (_, i) {
                  final item = controller.item[i];

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Spacer(flex: 5),
                        SizedBox(
                          height: 240,
                          child: Center(
                            child: Image.asset(
                              item.image,
                              fit: BoxFit.contain,
                              height: 230,
                              width: 230,
                            ),
                          ),
                        ),

                        //  const SizedBox(height: 18),
                        Text(
                          item.title,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: 6),

                        SizedBox(
                          width: 260,
                          child: Text(
                            item.subtitle,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: const Color(0xFF353B4A),
                              fontWeight: FontWeight.w300,
                              height: 1.3,
                            ),
                          ),
                        ),

                        const Spacer(flex: 8),
                      ],
                    ),
                  );
                },
              ),
            ),

            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(controller.item.length, (i) {
                  final active = controller.currentIndex.value == i;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: active ? 18 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: active
                          ? theme.colorScheme.primary
                          : theme.colorScheme.primary.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  );
                }),
              );
            }),

            const SizedBox(height: 70),

            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: controller.next,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Obx(() {
                    final isLast =
                        controller.currentIndex.value ==
                        controller.item.length - 1;
                    return Text(
                      isLast ? 'Get Started' : 'Next',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFFB6BAC5),
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
