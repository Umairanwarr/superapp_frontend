import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superapp/controllers/chat_controller.dart';
import 'package:superapp/controllers/profile_controller.dart';
import 'package:superapp/modal/chat_item_modal.dart';
import 'package:superapp/screens/all_review_screen.dart';
import 'package:superapp/services/auth_service.dart';

class ChatDetailController extends GetxController {
  ChatDetailController({required this.chat});

  final ChatItem chat;

  final TextEditingController messageCtrl = TextEditingController();
  final ScrollController scrollCtrl = ScrollController();

  final RxList<ChatMessage> messages = <ChatMessage>[].obs;

  final _authService = AuthService();
  String _token = '';

  @override
  void onInit() {
    super.onInit();

    final profile = Get.find<ProfileController>();
    _token = profile.token;
    fetchMessages();
  }

  Future<void> fetchMessages() async {
    if (_token.trim().isEmpty) return;
    if (chat.peerUserId <= 0) return;

    try {
      final msgs = await _authService.getMessagesWithUser(
        token: _token,
        otherUserId: chat.peerUserId,
      );

      final myUserId = Get.find<ProfileController>().userId;
      final mapped = msgs.map((m) {
        final senderId = (m['senderId'] as num?)?.toInt() ?? 0;
        final content = (m['content'] as String?) ?? '';
        final createdAt = (m['createdAt'] as String?) ?? '';
        return ChatMessage(
          fromMe: senderId == myUserId,
          text: content,
          time: _formatTime(createdAt),
        );
      }).toList();

      messages.assignAll(mapped);
      Future.delayed(const Duration(milliseconds: 50), _scrollToBottom);

      await _markAsRead();
    } catch (e) {
      Get.snackbar('Error', e.toString().replaceFirst('Exception: ', ''));
    }
  }

  Future<void> _markAsRead() async {
    if (_token.trim().isEmpty || chat.peerUserId <= 0) return;

    try {
      await _authService.markAsRead(token: _token, senderId: chat.peerUserId);

      final chatsController = Get.find<ChatsController>();
      chatsController.fetchThreads();
    } catch (_) {
      // Ignore errors for mark-as-read, UI still works
    }
  }

  void back() => Get.back();

  void sendMessage() {
    final text = messageCtrl.text.trim();
    if (text.isEmpty) return;

    if (_token.trim().isEmpty || chat.peerUserId <= 0) return;

    final optimistic = ChatMessage(fromMe: true, text: text, time: _nowTime());
    messages.add(optimistic);
    messageCtrl.clear();
    Future.delayed(const Duration(milliseconds: 50), _scrollToBottom);

    _authService
        .sendDirectMessage(
          token: _token,
          receiverId: chat.peerUserId,
          content: text,
        )
        .then((_) {
          final chatsController = Get.find<ChatsController>();
          chatsController.fetchThreads();
        })
        .catchError((e) {
      Get.snackbar('Error', e.toString().replaceFirst('Exception: ', ''));
      return null;
    });
  }

  void goTOReview() {
    Get.to(() => AllReviewsScreen());
  }

  void onCameraTap() {
    Get.snackbar('Camera', 'Open camera ');
  }

  void onMicTap() {
    Get.snackbar('Mic', 'Start recording ');
  }

  void onAddTap() {
    Get.snackbar('Add', 'Add Image ,Video');
  }

  void _scrollToBottom() {
    if (!scrollCtrl.hasClients) return;
    scrollCtrl.animateTo(
      scrollCtrl.position.maxScrollExtent,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  String _nowTime() {
    final t = TimeOfDay.now();
    final h = t.hour.toString().padLeft(2, '0');
    final m = t.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  String _formatTime(String iso) {
    if (iso.isEmpty) return '';
    try {
      final dt = DateTime.parse(iso).toLocal();
      final h = dt.hour.toString().padLeft(2, '0');
      final m = dt.minute.toString().padLeft(2, '0');
      return '$h:$m';
    } catch (_) {
      return '';
    }
  }

  @override
  void onClose() {
    messageCtrl.dispose();
    scrollCtrl.dispose();
    super.onClose();
  }
}

class ChatMessage {
  final bool fromMe;
  final String text;
  final String time;

  const ChatMessage({
    required this.fromMe,
    required this.text,
    required this.time,
  });
}
