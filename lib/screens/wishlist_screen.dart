import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../widgets/wishlist_card.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  int _selectedTab = 1; // 0 for Hotels, 1 for Properties (default as per image)

  final List<Map<String, dynamic>> _wishlistItems = [
    {
      'title': 'Luxury Villa',
      'location': 'Dubai Marina',
      'price': '\$1.306 M',
      'rating': 4.8,
      'imagePath': 'assets/hotel1.png',
      'savedTime': 'saved 1 week ago',
      'tag': 'Price Dropped',
      'isLiked': true,
    },
    {
      'title': 'Conthey Apartment',
      'location': 'Conthey, Switzerland',
      'price': '\$980K',
      'rating': 4.1,
      'imagePath': 'assets/hotel2.png',
      'isLiked': true,
    },
    {
      'title': 'Family Room',
      'location': 'San Francisco',
      'price': '\$2.1M',
      'rating': 4.4,
      'imagePath': 'assets/hotel1.png',
      'isLiked': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              itemCount: _wishlistItems.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final item = _wishlistItems[index];
                return Dismissible(
                  key: Key(item['title']),
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
                    setState(() {
                      _wishlistItems.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${item['title']} removed from wishlist'),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            setState(() {
                              _wishlistItems.insert(index, item);
                            });
                          },
                        ),
                      ),
                    );
                  },
                  child: WishlistCard(
                    title: item['title'],
                    location: item['location'],
                    price: item['price'],
                    rating: item['rating'],
                    imagePath: item['imagePath'],
                    savedTime: item['savedTime'],
                    tag: item['tag'],
                    isLiked: item['isLiked'] ?? true,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
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
              Column(
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
                    '${_wishlistItems.length} Saved Properties',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
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
                const Icon(Icons.search_rounded, color: Color(0xFF9E9E9F), size: 24),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    cursorColor: theme.colorScheme.primary,
                    selectionControls: materialTextSelectionControls,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      hintText: 'Search Saved Properties...',
                      hintStyle: TextStyle(
                          color: theme.brightness == Brightness.dark
                              ? Colors.white54
                              : const Color(0xFF9AA0AF),
                          fontSize: 18),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      isCollapsed: true,
                    ),
                    style: TextStyle(
                      color: theme.textTheme.bodyLarge?.color,
                    ),
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Color(0xFF2FC1BE),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.tune_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    final theme = Theme.of(context);
    // Reusing the style from the image, but this might need to be the actual MainBottomBar if we want navigation to work.
    // For now, I'll just create a placeholder row to match the image visually if needed, 
    // or better, use the MainBottomBar if possible.
    // The user said "create this screen", implying it might be a standalone screen or part of the main flow.
    // Since it's navigated to, showing the bottom bar might be tricky if it's pushed on top of the stack.
    // But usually, sub-screens don't have the main bottom bar unless it's a tab.
    // However, the image shows a bottom bar.
    // I'll stick to a simple placeholder for now or omit it if it's a pushed screen.
    // Wait, the image shows the bottom bar. I should probably include it.
    
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: theme.cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(theme.brightness == Brightness.dark ? 0.2 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildBottomNavItem(Icons.home_filled, 'Home', true),
          _buildBottomNavItem(Icons.explore_outlined, 'Explore', false),
          _buildBottomNavItem(Icons.grid_view, 'Dashboard', false),
          _buildBottomNavItem(Icons.chat_bubble_outline, 'Chat', false),
          _buildBottomNavItem(Icons.person_outline, 'Profile', false),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(IconData icon, String label, bool isSelected) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF2FC1BE) : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: isSelected ? Colors.white : (isDark ? Colors.white54 : Colors.grey[400]),
            size: 24,
          ),
        ),
        if (isSelected)
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF2FC1BE),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
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
