import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../controllers/wishlist_controller.dart';

class HotelImageCarousel extends StatefulWidget {
  final List<String>? imageUrls;
  final int? hotelId;
  final int? propertyId;

  const HotelImageCarousel({
    super.key,
    this.imageUrls,
    this.hotelId,
    this.propertyId,
  });

  @override
  State<HotelImageCarousel> createState() => _HotelImageCarouselState();
}

class _HotelImageCarouselState extends State<HotelImageCarousel> {
  int _currentPage = 0;
  final PageController _pageController = PageController();
  final WishlistController _wishlistController = Get.put(WishlistController());

  final List<String> _fallbackImages = [
    'assets/hotel1.png',
    'assets/hotel2.png',
  ];

  @override
  Widget build(BuildContext context) {
    final useNetwork = widget.imageUrls != null && widget.imageUrls!.isNotEmpty;
    final imageCount = useNetwork
        ? widget.imageUrls!.length
        : _fallbackImages.length;

    return SafeArea(
      top: true,
      bottom: false,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            child: SizedBox(
              height: 380,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemCount: imageCount,
                itemBuilder: (context, index) {
                  if (useNetwork) {
                    return Image.network(
                      widget.imageUrls![index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: Colors.grey[200],
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF2FC1BE),
                            ),
                          ),
                        );
                      },
                      errorBuilder: (_, __, ___) => Container(
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(
                            Icons.hotel,
                            size: 60,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    );
                  }
                  return Image.asset(
                    _fallbackImages[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  );
                },
              ),
            ),
          ),
          // Navigation Buttons
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _circleButton(
                    icon: Icons.arrow_back,
                    onTap: () => Get.back(),
                  ),
                  Row(
                    children: [
                      _circleButton(icon: Icons.share_outlined, onTap: () {}),
                      const SizedBox(width: 12),
                      Obx(() {
                        bool isInWishlist = false;
                        if (widget.hotelId != null) {
                          isInWishlist = _wishlistController
                              .isHotelInWishlistSync(widget.hotelId!);
                        } else if (widget.propertyId != null) {
                          isInWishlist = _wishlistController
                              .isPropertyInWishlistSync(widget.propertyId!);
                        }

                        return _circleSvgButton(
                          assetPath: 'assets/heart.svg',
                          isFilled: isInWishlist,
                          onTap: () {
                            if (widget.hotelId != null) {
                              _wishlistController
                                  .toggleHotelWishlist(widget.hotelId!);
                            } else if (widget.propertyId != null) {
                              _wishlistController
                                  .togglePropertyWishlist(widget.propertyId!);
                            }
                          },
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Side Arrows
          Positioned(
            left: 10,
            top: 190,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () {
                if (_currentPage > 0) {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
            ),
          ),
          Positioned(
            right: 10,
            top: 190,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () {
                if (_currentPage < imageCount - 1) {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
            ),
          ),
          // Indicators
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(imageCount, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? const Color(0xFF2FC1BE)
                        : Colors.white,
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _circleButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.black, size: 24),
      ),
    );
  }

  Widget _circleSvgButton({
    required String assetPath,
    required VoidCallback onTap,
    bool isFilled = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isFilled
              ? const Color(0xFFFF6B6B).withOpacity(0.9)
              : Colors.white.withOpacity(0.9),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          assetPath,
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(
            isFilled ? Colors.white : Colors.black,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
