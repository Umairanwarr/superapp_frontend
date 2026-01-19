import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superapp/modal/chat_item_modal.dart';
import 'package:superapp/screens/all_review_screen.dart';

class ChatDetailController extends GetxController {
  ChatDetailController({required this.chat});

  final ChatItem chat;

  final TextEditingController messageCtrl = TextEditingController();
  final ScrollController scrollCtrl = ScrollController();

  final RxList<ChatMessage> messages = <ChatMessage>[].obs;

  @override
  void onInit() {
    super.onInit();

    messages.assignAll([
      const ChatMessage(
        fromMe: true,
        text:
            "Hi I hope you are well this property is really great whats the asking price for it I am here to purchase it. Can you please share more details",
        time: "10:10",
      ),
      const ChatMessage(
        fromMe: false,
        text:
            "Hi I hope you are well this property is really great whats the asking price for it I am here to purchase it. Can you please share more details",
        time: "10:10",
      ),
      const ChatMessage(
        fromMe: false,
        text:
            "Hi I hope you are well this property is really great whats the asking price for it I am here to purchase it. Can you please share more details",
        time: "10:10",
      ),
      const ChatMessage(
        fromMe: true,
        text:
            "Hi I hope you are well this property is really great whats the asking price for it I am here to purchase it. Can you please share more details",
        time: "10:10",
      ),
    ]);

    Future.delayed(const Duration(milliseconds: 50), _scrollToBottom);
  }

  void back() => Get.back();

  void sendMessage() {
    final text = messageCtrl.text.trim();
    if (text.isEmpty) return;

    messages.add(ChatMessage(fromMe: true, text: text, time: _nowTime()));
    messageCtrl.clear();

    Future.delayed(const Duration(milliseconds: 50), _scrollToBottom);
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
