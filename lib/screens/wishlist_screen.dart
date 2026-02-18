import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../controllers/wishlist_controller.dart';
import '../services/listing_service.dart';
import '../widgets/wishlist_card.dart';
import 'hotel_detail_screen.dart';
import 'property_detail_screen.dart';

class WishlistScreen extends StatefulWidget {
  final int initialTab;

  const WishlistScreen({super.key, this.initialTab = 1});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  late int _selectedTab;
  final WishlistController _wishlistController = Get.put(WishlistController());
  final TextEditingController _searchController = TextEditingController();
  var searchQuery = ''.obs;

  @override
  void initState() {
    super.initState();
    _selectedTab = widget.initialTab;
    _wishlistController.fetchWishlist();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: RefreshIndicator(
              color: const Color(0xFF2FC1BE),
              onRefresh: () async {
                await _wishlistController.fetchWishlist();
              },
              child: Obx(() {
              if (_wishlistController.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF2FC1BE),
                  ),
                );
              }

              final items = _selectedTab == 0
                  ? _wishlistController.hotels
                  : _wishlistController.properties;

              // Filter items based on search query
              final filteredItems = items.where((item) {
                if (searchQuery.value.isEmpty) return true;
                final title = (item['title'] ?? '').toString().toLowerCase();
                final address = (item['address'] ?? '').toString().toLowerCase();
                final query = searchQuery.value.toLowerCase();
                return title.contains(query) || address.contains(query);
              }).toList();

              if (filteredItems.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite_border,
                        size: 80,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        searchQuery.value.isEmpty
                            ? 'No items in wishlist'
                            : 'No results found',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                itemCount: filteredItems.length,
                separatorBuilder: (context, index) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final item = filteredItems[index];
                  return Dismissible(
                    key: Key('${_selectedTab}_${item['id']}'),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFE5E5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      child: SvgPicture.asset(
                        'assets/bin.svg',
                        width: 28,
                        height: 28,
                      ),
                    ),
                    onDismissed: (direction) {
                      if (_selectedTab == 0) {
                        _wishlistController.toggleHotelWishlist(item['id'] as int);
                      } else {
                        _wishlistController.togglePropertyWishlist(item['id'] as int);
                      }
                    },
                    child: GestureDetector(
                      onTap: () {
                        if (_selectedTab == 0) {
                          Get.to(() => HotelDetailScreen(hotelData: item));
                        } else {
                          Get.to(() => PropertyDetailScreen(propertyData: item));
                        }
                      },
                      child: WishlistCard(
                        title: item['title'] ?? 'Untitled',
                        location: item['address'] ?? 'Unknown location',
                        price: _formatPrice(item, _selectedTab),
                        rating: 4.5,
                        imageUrl: _getImageUrl(item, _selectedTab),
                        isLiked: true,
                        onDelete: () {
                          if (_selectedTab == 0) {
                            _wishlistController.toggleHotelWishlist(item['id'] as int);
                          } else {
                            _wishlistController.togglePropertyWishlist(item['id'] as int);
                          }
                        },
                      ),
                    ),
                  );
                },
              );
            }),
            ),
          ),
        ],
      ),
    );
  }

  String _formatPrice(dynamic item, int tab) {
    if (tab == 0) {
      // For hotels, use controller method
      return _wishlistController.getHotelPrice(item);
    } else {
      // For properties, use controller method
      return _wishlistController.getPropertyPrice(item);
    }
  }

  String? _getImageUrl(Map<String, dynamic> item, int tab) {
    final images = item['images'] as List<dynamic>?;
    if (images == null || images.isEmpty) {
      return null;
    }

    final id = item['id'] as int?;
    if (id == null) return null;

    if (tab == 0) {
      return ListingService.hotelImageUrl(id, 0);
    } else {
      return ListingService.propertyImageUrl(id, 0);
    }
  }

  Widget _buildHeader() {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 60, 16, 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0.02, 0.49, 1.0],
          colors: [Color(0xFF38CAC7), Color(0xFF27B9B6), Color(0xFF119C99)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(44),
          bottomRight: Radius.circular(44),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: const Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Obx(() {
                final count = _selectedTab == 0
                    ? _wishlistController.hotels.length
                    : _wishlistController.properties.length;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'My Wishlist',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$count Saved ${_selectedTab == 0 ? 'Hotels' : 'Properties'}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
          const SizedBox(height: 24),
          // Toggle
          Container(
            height: 54,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: const Color(0xFFADD4E8).withOpacity(0.57),
              borderRadius: BorderRadius.circular(26),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _CategoryChip(
                    selected: _selectedTab == 0,
                    iconAssetPath: 'assets/hotel-header.png',
                    label: 'Hotels',
                    onTap: () => setState(() => _selectedTab = 0),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _CategoryChip(
                    selected: _selectedTab == 1,
                    iconAssetPath: 'assets/property-header.png',
                    label: 'Properties',
                    onTap: () => setState(() => _selectedTab = 1),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Search Bar
          Container(
            height: 54,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(26),
              border: Border.all(
                color: theme.brightness == Brightness.dark
                    ? Colors.transparent
                    : const Color(0x9CBAB1B1),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.search_rounded,
                  color: Color(0xFF9E9E9F),
                  size: 24,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      searchQuery.value = value;
                    },
                    cursorColor: theme.colorScheme.primary,
                    selectionControls: materialTextSelectionControls,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      hintText: 'Search Saved Properties...',
                      hintStyle: TextStyle(
                        color: theme.brightness == Brightness.dark
                            ? Colors.white54
                            : const Color(0xFF9AA0AF),
                        fontSize: 18,
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      isCollapsed: true,
                    ),
                    style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final bool selected;
  final String iconAssetPath;
  final String label;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.selected,
    required this.iconAssetPath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconAssetPath,
              width: 22,
              height: 22,
              color: selected
                  ? theme.colorScheme.primary
                  : Colors.white.withOpacity(0.9),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: theme.textTheme.titleMedium?.copyWith(
                color: selected
                    ? theme.colorScheme.primary
                    : Colors.white.withOpacity(0.9),
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
