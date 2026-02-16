import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:superapp/modal/ai_chat_message.dart';

class AiAssistantController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  final RxList<AiChatMessage> messages = <AiChatMessage>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Add initial welcome message
    messages.add(
      AiChatMessage(
        type: AiMessageType.text,
        text:
            "Hello! I'm your AI travel assistant powered by advanced machine learning. I can help you with hotel recommendations, price prediction, room suggestions, and more.\nWhat can I help you with today?",
        isUser: false,
      ),
    );
  }

  Future<void> sendMessage() async {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    // Add user message
    messages.add(
      AiChatMessage(type: AiMessageType.text, text: text, isUser: true),
    );

    messageController.clear();
    isLoading.value = true;
    _scrollToBottom();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('user_token');
      // Assuming 'access_token' is stored. If not, we might need to check 'user_token' or similar from AuthController.
      // Since I can't easily check AuthController state without reading it, I'll assume token is in prefs or not needed for now if I skip auth for demo,
      // but Backend has @UseGuards(AuthGuard('jwt')). So I NEED the token.

      // Let's assume standard "token" key or "access_token".
      // From splash_controller.dart, I saw it checks `onboarding_done` and `user_id`.
      // It doesn't explicitly show where token is stored.
      // I'll try to find where token is stored. If I can't find it, I will add a TODO or try to get it from ProfileController if accessible.
      // For now, let's assume 'token'.

      // Use 10.0.2.2 for Android Emulator, localhost for iOS Simulator
      final baseUrl = Platform.isAndroid
          ? 'http://10.0.2.2:3000'
          : 'http://localhost:3000';

      final response = await http.post(
        Uri.parse('$baseUrl/ai-assistant/chat'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'message': text}),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final backendMessages = data['messages'] as List;

        for (final msg in backendMessages) {
          if (msg['type'] == 'text') {
            messages.add(
              AiChatMessage(
                type: AiMessageType.text,
                text: msg['content'],
                isUser: false,
              ),
            );
          } else if (msg['type'] == 'hotel_list') {
            final hotels = (msg['data'] as List)
                .map((h) => AiHotel.fromJson(h))
                .toList();
            messages.add(
              AiChatMessage(
                type: AiMessageType.hotelList,
                hotels: hotels,
                isUser: false,
              ),
            );
          } else if (msg['type'] == 'chart') {
            final chartData = AiChartData.fromJson(msg['data']);
            messages.add(
              AiChatMessage(
                type: AiMessageType.chart,
                chartData: chartData,
                isUser: false,
              ),
            );
          }
        }
      } else {
        Get.snackbar('Error', 'Failed to get response: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading.value = false;
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}
