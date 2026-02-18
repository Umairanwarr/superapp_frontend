import 'package:flutter/material.dart';

enum ForumType { FORUM, REVIEW, TIPS }

class CommunityPost {
  final String id;
  final ForumType type;
  final String initial;
  final Color avatarColor;
  final String name;
  final String role;
  final String timeAgo;
  final String message;
  final String? linkText;
  final int userId;
  final int? forumId;
  final String? userAvatarUrl;

  int likes;
  int replies;
  bool isLiked;
  List<ForumComment> comments;

  CommunityPost({
    required this.id,
    required this.type,
    required this.initial,
    required this.avatarColor,
    required this.name,
    required this.role,
    required this.timeAgo,
    required this.message,
    this.linkText,
    required this.likes,
    required this.replies,
    this.isLiked = false,
    this.comments = const [],
    this.userId = 0,
    this.forumId,
    this.userAvatarUrl,
  });

  factory CommunityPost.fromJson(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>? ?? {};
    final typeStr = json['type'] as String? ?? 'FORUM';
    
    return CommunityPost(
      id: json['id']?.toString() ?? '',
      type: ForumType.values.firstWhere(
        (e) => e.name == typeStr,
        orElse: () => ForumType.FORUM,
      ),
      initial: (user['fullName'] ?? user['firstName'] ?? 'U')?.toString().substring(0, 1).toUpperCase() ?? 'U',
      avatarColor: _getAvatarColor(user['id'] ?? 0),
      name: user['fullName'] ?? user['firstName'] ?? 'Unknown',
      role: user['role']?.toString() ?? 'User',
      timeAgo: _formatTimeAgo(json['createdAt']),
      message: json['content'] ?? json['message'] ?? '',
      linkText: json['link'],
      likes: json['likes'] ?? 0,
      replies: json['replies'] ?? 0,
      isLiked: false,
      userId: user['id'] ?? 0,
      forumId: json['id'],
      userAvatarUrl: user['avatar'] as String?,
    );
  }

  static Color _getAvatarColor(dynamic id) {
    final colors = [
      const Color(0xFFE84D8A),
      const Color(0xFF13B07D),
      const Color(0xFFF59E0B),
      const Color(0xFF8B5CF6),
      const Color(0xFF0EA5E9),
      const Color(0xFFEC4899),
      const Color(0xFF10B981),
      const Color(0xFF6366F1),
    ];
    return colors[(id as int? ?? 0) % colors.length];
  }

  static String _formatTimeAgo(dynamic dateStr) {
    if (dateStr == null) return 'Just now';
    try {
      final date = DateTime.parse(dateStr.toString());
      final diff = DateTime.now().difference(date);
      if (diff.inDays > 30) return '${(diff.inDays / 30).floor()} months ago';
      if (diff.inDays > 0) return '${diff.inDays} days ago';
      if (diff.inHours > 0) return '${diff.inHours} hours ago';
      if (diff.inMinutes > 0) return '${diff.inMinutes} minutes ago';
      return 'Just now';
    } catch (_) {
      return 'Just now';
    }
  }

  String get tabName {
    switch (type) {
      case ForumType.FORUM:
        return 'Forums';
      case ForumType.REVIEW:
        return 'Reviews';
      case ForumType.TIPS:
        return 'Tips';
    }
  }
}

class ForumComment {
  final int id;
  final String content;
  final String initial;
  final Color avatarColor;
  final String name;
  final String timeAgo;
  final int userId;

  ForumComment({
    required this.id,
    required this.content,
    required this.initial,
    required this.avatarColor,
    required this.name,
    required this.timeAgo,
    required this.userId,
  });

  factory ForumComment.fromJson(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>? ?? {};
    return ForumComment(
      id: json['id'] ?? 0,
      content: json['content'] ?? '',
      initial: (user['fullName'] ?? user['firstName'] ?? 'U')?.toString().substring(0, 1).toUpperCase() ?? 'U',
      avatarColor: CommunityPost._getAvatarColor(user['id'] ?? 0),
      name: user['fullName'] ?? user['firstName'] ?? 'Unknown',
      timeAgo: CommunityPost._formatTimeAgo(json['createdAt']),
      userId: user['id'] ?? 0,
    );
  }
}
