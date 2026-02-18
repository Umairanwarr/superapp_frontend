enum MessageStatus { none, sent, delivered, read }

class ChatItem {
  final int peerUserId;
  final String name;
  final String message;
  final String date;
  final String avatarUrl;
  final MessageStatus status;
  final int unreadCount;
  final bool isPhoto;
  final bool isVoice;
  final Map<String, dynamic>? propertyData;
  final int? propertyId;

  const ChatItem({
    required this.peerUserId,
    required this.name,
    required this.message,
    required this.date,
    required this.avatarUrl,
    required this.status,
    required this.unreadCount,
    this.isPhoto = false,
    this.isVoice = false,
    this.propertyData,
    this.propertyId,
  });
}
