import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:superapp/modal/community_post_modal.dart';
import 'package:superapp/controllers/profile_controller.dart';
import '../services/api_service.dart';

class CommunityController extends GetxController {
  final tabs = const ['Forums', 'Reviews', 'Tips'];

  final RxInt tabIndex = 0.obs;

  final RxList<CommunityPost> posts = <CommunityPost>[].obs;

  final RxSet<String> likedPostIds = <String>{}.obs;

  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchForums();
  }

  void setTab(int index) {
    if (index < 0 || index >= tabs.length) return;
    tabIndex.value = index;
  }

  String get currentTab => tabs[tabIndex.value];

  List<CommunityPost> get visiblePosts {
    return posts.where((p) => p.tabName == currentTab).toList();
  }

  Future<void> fetchForums() async {
    isLoading.value = true;
    try {
      final profileController = Get.find<ProfileController>();
      final token = profileController.token;
      final userId = profileController.userId;

      final baseUrl = ApiService.baseUrl;
      final uri = userId > 0 
          ? Uri.parse('$baseUrl/forums?userId=$userId')
          : Uri.parse('$baseUrl/forums');
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          if (token.isNotEmpty) 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final List<dynamic> data = jsonDecode(response.body);
        final forumList = data.map((json) {
          final post = CommunityPost.fromJson(json);
          // Use API response, fallback to local state
          if (json['isLiked'] == true) {
            post.isLiked = true;
            likedPostIds.add(post.id);
          } else if (likedPostIds.contains(post.id)) {
            post.isLiked = true;
          }
          return post;
        }).toList();
        
        posts.assignAll(forumList);
      }
    } catch (e) {
      debugPrint('Error fetching forums: $e');
      _seedData();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> toggleLike(String postId) async {
    final i = posts.indexWhere((p) => p.id == postId);
    if (i == -1) return;

    final post = posts[i];
    final forumId = post.forumId;
    if (forumId == null) return;

    try {
      final profileController = Get.find<ProfileController>();
      final token = profileController.token;
      final userId = profileController.userId;

      final baseUrl = ApiService.baseUrl;
      final response = await http.post(
        Uri.parse('$baseUrl/forums/$forumId/like'),
        headers: {
          'Content-Type': 'application/json',
          if (token.isNotEmpty) 'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'userId': userId}),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final result = jsonDecode(response.body);
        final isLiked = result['liked'] == true;

        if (isLiked) {
          likedPostIds.add(postId);
          post.likes = post.likes + 1;
        } else {
          likedPostIds.remove(postId);
          post.likes = (post.likes - 1).clamp(0, 999999);
        }
        post.isLiked = isLiked;
        posts.refresh();
      }
    } catch (e) {
      if (likedPostIds.contains(postId)) {
        likedPostIds.remove(postId);
        post.likes = (post.likes - 1).clamp(0, 999999);
      } else {
        likedPostIds.add(postId);
        post.likes = post.likes + 1;
      }
      post.isLiked = likedPostIds.contains(postId);
      posts.refresh();
    }
  }

  Future<void> addComment(String postId, String content) async {
    final i = posts.indexWhere((p) => p.id == postId);
    if (i == -1) return;

    final post = posts[i];
    final forumId = post.forumId;
    if (forumId == null) return;

    try {
      final profileController = Get.find<ProfileController>();
      final token = profileController.token;
      final userId = profileController.userId;

      final baseUrl = ApiService.baseUrl;
      final response = await http.post(
        Uri.parse('$baseUrl/forums/$forumId/comments'),
        headers: {
          'Content-Type': 'application/json',
          if (token.isNotEmpty) 'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'userId': userId, 'content': content}),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        post.replies = post.replies + 1;
        posts.refresh();
      }
    } catch (e) {
      post.replies = post.replies + 1;
      posts.refresh();
    }
  }

  bool isLiked(String postId) => likedPostIds.contains(postId);

  void _seedData() {
    posts.assignAll([
      CommunityPost(
        id: '1',
        type: ForumType.FORUM,
        initial: 'M',
        avatarColor: const Color(0xFFE84D8A),
        name: 'Maria S.',
        role: 'Owner',
        timeAgo: '2 hours ago',
        message: 'Best tips for quick turnovers during peak season? We have back-to-back bookings and need efficient strategies.',
        likes: 24,
        replies: 23,
      ),
      CommunityPost(
        id: '2',
        type: ForumType.FORUM,
        initial: 'I',
        avatarColor: const Color(0xFF13B07D),
        name: 'Ivan P.',
        role: 'Staff',
        timeAgo: '5 hours ago',
        message: 'Found great eco-friendly cleaning products that work amazing! Check out the attached link for details.',
        linkText: 'eco-clean-products.com/bundle',
        likes: 56,
        replies: 8,
      ),
      CommunityPost(
        id: '3',
        type: ForumType.FORUM,
        initial: 'S',
        avatarColor: const Color(0xFFF59E0B),
        name: 'Stefan D.',
        role: 'Owner',
        timeAgo: 'Yesterday',
        message: 'Anyone using inventory management apps? Looking for recommendations to track supplies across multiple properties.',
        likes: 12,
        replies: 15,
      ),
      CommunityPost(
        id: '4',
        type: ForumType.REVIEW,
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
        type: ForumType.TIPS,
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
