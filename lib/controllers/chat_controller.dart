import 'package:get/get.dart';
import 'package:superapp/modal/chat_item_modal.dart';

class ChatsController extends GetxController {
  final RxList<ChatItem> allChats = <ChatItem>[
    const ChatItem(
      name: 'Martin Randolph',
      message: 'Yes, 2pm is awesome',
      date: '11/19/19',
      avatarUrl: 'https://i.pravatar.cc/150?img=12',
      status: MessageStatus.read,
      unreadCount: 0,
    ),
    const ChatItem(
      name: 'Andrew Parker',
      message: 'What kind of strategy is better?',
      date: '11/16/19',
      avatarUrl: 'https://i.pravatar.cc/150?img=13',
      status: MessageStatus.read,
      unreadCount: 0,
    ),
    const ChatItem(
      name: 'Karen Castillo',
      message: '0:14',
      date: '11/15/19',
      avatarUrl: 'https://i.pravatar.cc/150?img=5',
      status: MessageStatus.none,
      unreadCount: 14,
    ),
    const ChatItem(
      name: 'Maximillian Jacobson',
      message: 'Bro, I have a good idea!',
      date: '10/30/19',
      avatarUrl: 'https://i.pravatar.cc/150?img=15',
      status: MessageStatus.read,
      unreadCount: 0,
    ),
    const ChatItem(
      name: 'Martha Craig',
      message: 'Photo',
      date: '10/28/19',
      avatarUrl: 'https://i.pravatar.cc/150?img=21',
      status: MessageStatus.sent,
      unreadCount: 0,
      isPhoto: true,
    ),
    const ChatItem(
      name: 'Tabitha Potter',
      message:
          "Actually I wanted to check with you about your online business plan on our...",
      date: '8/25/19',
      avatarUrl: 'https://i.pravatar.cc/150?img=32',
      status: MessageStatus.none,
      unreadCount: 0,
    ),
    const ChatItem(
      name: 'Maisy Humphrey',
      message: "Welcome, to make design process faster, look at Pixsellz",
      date: '8/20/19',
      avatarUrl: 'https://i.pravatar.cc/150?img=44',
      status: MessageStatus.none,
      unreadCount: 2,
    ),
    const ChatItem(
      name: 'Kieron Dotson',
      message: 'Ok, have a good trip!',
      date: '7/29/19',
      avatarUrl: 'https://i.pravatar.cc/150?img=49',
      status: MessageStatus.read,
      unreadCount: 0,
    ),
  ].obs;

  final RxString query = ''.obs;

  void onSearchChanged(String val) => query.value = val;

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
    Get.snackbar('Chat', 'Open: ${chat.name}');
  }
}
