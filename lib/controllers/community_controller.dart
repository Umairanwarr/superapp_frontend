import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:superapp/modal/community_post_modal.dart';

class CommunityController extends GetxController {
  final tabs = const ['Forums', 'Reviews', 'Tips'];

  final RxInt tabIndex = 0.obs;

  // Posts list (API se later replace ho sakta hai)
  final RxList<CommunityPost> posts = <CommunityPost>[].obs;

  // Likes toggle maintain karne ke liye
  final RxSet<String> likedPostIds = <String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    _seedData();
  }

  void setTab(int index) {
    if (index < 0 || index >= tabs.length) return;
    tabIndex.value = index;
  }

  String get currentTab => tabs[tabIndex.value];

  List<CommunityPost> get visiblePosts {
    // Abhi simple filter by tab
    return posts.where((p) => p.tab == currentTab).toList();
  }

  void toggleLike(String postId) {
    final i = posts.indexWhere((p) => p.id == postId);
    if (i == -1) return;

    final post = posts[i];

    if (likedPostIds.contains(postId)) {
      likedPostIds.remove(postId);
      post.likes = (post.likes - 1).clamp(0, 999999);
    } else {
      likedPostIds.add(postId);
      post.likes = post.likes + 1;
    }

    // RxList me item mutate hua, refresh needed:
    posts.refresh();
  }

  bool isLiked(String postId) => likedPostIds.contains(postId);

  void _seedData() {
    posts.assignAll([
      CommunityPost(
        id: '1',
        tab: 'Forums',
        initial: 'M',
        avatarColor: const Color(0xFFE84D8A),
        name: 'Maria S.',
        role: 'Owner',
        timeAgo: '2 hours ago',
        message:
            'Best tips for quick turnovers during peak season? We have back-to-back bookings and need efficient strategies.',
        likes: 24,
        replies: 23,
      ),
      CommunityPost(
        id: '2',
        tab: 'Forums',
        initial: 'I',
        avatarColor: const Color(0xFF13B07D),
        name: 'Ivan P.',
        role: 'Staff',
        timeAgo: '5 hours ago',
        message:
            'Found great eco-friendly cleaning products that work amazing! Check out the attached link for details.',
        linkText: 'eco-clean-products.com/bundle',
        likes: 56,
        replies: 8,
      ),
      CommunityPost(
        id: '3',
        tab: 'Forums',
        initial: 'S',
        avatarColor: const Color(0xFFF59E0B),
        name: 'Stefan D.',
        role: 'Owner',
        timeAgo: 'Yesterday',
        message:
            'Anyone using inventory management apps? Looking for recommendations to track supplies across multiple properties.',
        likes: 12,
        replies: 15,
      ),

      // Dummy for other tabs (taake switching empty na ho)
      CommunityPost(
        id: '4',
        tab: 'Reviews',
        initial: 'A',
        avatarColor: const Color(0xFF8B5CF6),
        name: 'Ayesha K.',
        role: 'Owner',
        timeAgo: 'Today',
        message: 'Tried a new linen vendor — quality is great, pricing ok.',
        likes: 7,
        replies: 2,
      ),
      CommunityPost(
        id: '5',
        tab: 'Tips',
        initial: 'R',
        avatarColor: const Color(0xFF0EA5E9),
        name: 'Rohan',
        role: 'Staff',
        timeAgo: '2 days ago',
        message: 'Pro tip: Label keys by property + color code cleaning kits.',
        likes: 19,
        replies: 4,
      ),
    ]);
  }
}
