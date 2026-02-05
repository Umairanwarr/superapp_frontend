import 'package:flutter/material.dart';

class CommunityPost {
  final String id;
  final String tab;
  final String initial;
  final Color avatarColor;
  final String name;
  final String role;
  final String timeAgo;
  final String message;
  final String? linkText;

  int likes;
  int replies;

  CommunityPost({
    required this.id,
    required this.tab,
    required this.initial,
    required this.avatarColor,
    required this.name,
    required this.role,
    required this.timeAgo,
    required this.message,
    this.linkText,
    required this.likes,
    required this.replies,
  });
}
