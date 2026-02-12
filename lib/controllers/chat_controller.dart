import 'dart:async';

import 'package:get/get.dart';
import 'package:superapp/controllers/profile_controller.dart';
import 'package:superapp/modal/chat_item_modal.dart';
import 'package:superapp/screens/chat_detail_screen.dart';
import 'package:superapp/services/auth_service.dart';

class ChatsController extends GetxController {
  final _authService = AuthService();

  final RxList<ChatItem> allChats = <ChatItem>[].obs;

  final RxString query = ''.obs;

  final isLoading = false.obs;
  Timer? _debounce;

  @override
  void onInit() {
    super.onInit();
    fetchThreads();
  }

  void onSearchChanged(String val) {
    query.value = val;
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 150), () {});
  }

  Future<void> fetchThreads() async {
    isLoading.value = true;
    try {
      final profile = Get.find<ProfileController>();
      final token = profile.token;
      if (token.trim().isEmpty) {
        allChats.assignAll([]);
        return;
      }

      final threads = await _authService.getThreads(token: token);
      final mapped = threads.map((t) {
        final peer = (t['peer'] as Map?) ?? {};
        final peerId = (peer['id'] as num?)?.toInt() ?? 0;

        final fullName = (peer['fullName'] as String?) ?? '';
        final firstName = (peer['firstName'] as String?) ?? '';
        final lastName = (peer['lastName'] as String?) ?? '';
        final name = fullName.isNotEmpty
            ? fullName
            : '${firstName.trim()} ${lastName.trim()}'.trim();
        final email = (peer['email'] as String?) ?? '';

        final avatar = (peer['avatar'] as String?) ?? '';
        final avatarUrl = avatar.isNotEmpty
            ? avatar
            : 'https://i.pravatar.cc/150?u=${Uri.encodeComponent(email.isNotEmpty ? email : name)}';

        final lastMessage = (t['lastMessage'] as Map?) ?? {};
        final content = (lastMessage['content'] as String?) ?? '';

        final unreadCount = (t['unreadCount'] as num?)?.toInt() ?? 0;

        return ChatItem(
          peerUserId: peerId,
          name: name.isNotEmpty ? name : (email.isNotEmpty ? email : 'User'),
          message: content,
          date: '',
          avatarUrl: avatarUrl,
          status: MessageStatus.none,
          unreadCount: unreadCount,
        );
      }).where((c) => c.peerUserId > 0).toList();

      allChats.assignAll(mapped);
    } catch (e) {
      Get.snackbar('Error', e.toString().replaceFirst('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  List<ChatItem> get filteredChats {
    final q = query.value.trim().toLowerCase();
    if (q.isEmpty) return allChats;
    return allChats
        .where(
          (c) =>
              c.name.toLowerCase().contains(q) ||
              c.message.toLowerCase().contains(q),
        )
        .toList();
  }

  void onChatTap(ChatItem chat) {
    Get.to(() => ChatDetailScreen(), arguments: chat);
  }

  @override
  void onClose() {
    _debounce?.cancel();
    super.onClose();
  }
}
