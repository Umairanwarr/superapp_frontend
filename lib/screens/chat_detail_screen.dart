import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superapp/controllers/chat_detail_controller.dart';
import 'package:superapp/modal/chat_item_modal.dart';

class ChatDetailScreen extends StatelessWidget {
  ChatDetailScreen({super.key});
  final chat = Get.arguments as ChatItem;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatDetailController(chat: chat));
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F8F8),

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: AppBar(
          toolbarHeight: 120,
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          titleSpacing: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, size: 20),
            onPressed: controller.back,
          ),
          title: Text(
            controller.chat.name,
            style: theme.textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [0.02, 0.49, 1.0],
                colors: [
                  Color(0xFF38CAC7),
                  Color(0xFF27B9B6),
                  Color(0xFF119C99),
                ],
              ),
            ),
          ),
        ),
      ),

      body: SafeArea(
        top: false,
        child: Column(
          children: [
            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _PropertyCard(
                onTap: controller.goTOReview,
                accent: theme.colorScheme.primary,
                imageAsset: 'assets/hotel1.png',
                title: 'Family Room',
                location: 'San Francisco',
                price: '\$2.1M',
                rating: '4.4',
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: Obx(() {
                final msgs = controller.messages;
                return ListView.builder(
                  controller: controller.scrollCtrl,
                  padding: const EdgeInsets.fromLTRB(16, 6, 16, 10),
                  itemCount: msgs.length,
                  itemBuilder: (context, i) {
                    final m = msgs[i];
                    return _ChatBubble(
                      fromMe: m.fromMe,
                      text: m.text,
                      time: m.time,
                      accent: theme.colorScheme.primary,
                    );
                  },
                );
              }),
            ),

            _ComposerBar(
              onAdd: controller.onAddTap,
              messageCtrl: controller.messageCtrl,
              onSend: controller.sendMessage,
              onCamera: controller.onCameraTap,
              onMic: controller.onMicTap,
            ),
          ],
        ),
      ),
    );
  }
}

class _PropertyCard extends StatelessWidget {
  const _PropertyCard({
    required this.accent,
    required this.imageAsset,
    required this.title,
    required this.location,
    required this.price,
    required this.rating,
    required this.onTap,
  });

  final Color accent;
  final String imageAsset;
  final String title;
  final String location;
  final String price;
  final String rating;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: accent.withOpacity(0.55), width: 1),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
              child: Image.asset(
                imageAsset,
                width: 80,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1D2330),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_rounded,
                        size: 14,
                        color: Color(0xFF9AA0AF),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          location,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: const Color(0xFF9AA0AF),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        price,
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: accent,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(width: 120),
                      const Icon(
                        Icons.star_rounded,
                        size: 18,
                        color: Color(0xFFFFC107),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        rating,
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: const Color(0xFF1D2330),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  const _ChatBubble({
    required this.fromMe,
    required this.text,
    required this.time,
    required this.accent,
  });

  final bool fromMe;
  final String text;
  final String time;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final bubbleColor = fromMe ? accent : const Color(0xFFEAEAEA);
    final textColor = fromMe ? Colors.white : const Color(0xFF1D2330);
    final timeColor = fromMe
        ? Colors.white.withOpacity(0.85)
        : const Color(0xFF9AA0AF);

    final radius = BorderRadius.only(
      topLeft: const Radius.circular(14),
      topRight: const Radius.circular(14),
      bottomLeft: Radius.circular(fromMe ? 14 : 6),
      bottomRight: Radius.circular(fromMe ? 6 : 14),
    );

    return Padding(
      padding: EdgeInsets.only(
        top: 10,
        left: fromMe ? 52 : 0,
        right: fromMe ? 0 : 52,
      ),
      child: Align(
        alignment: fromMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 320),
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
          decoration: BoxDecoration(color: bubbleColor, borderRadius: radius),
          child: Column(
            crossAxisAlignment: fromMe
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.end,
            children: [
              Text(
                text,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: textColor,
                  height: 1.25,
                  fontWeight: FontWeight.w500,
                  fontSize: 13.5,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                time,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: timeColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ComposerBar extends StatelessWidget {
  const _ComposerBar({
    required this.messageCtrl,
    required this.onSend,
    required this.onCamera,
    required this.onMic,
    required this.onAdd,
  });

  final TextEditingController messageCtrl;
  final VoidCallback onSend;
  final VoidCallback onCamera;
  final VoidCallback onMic;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 10),
      child: Expanded(
        child: Row(
          children: [
            IconButton(
              onPressed: onAdd,
              icon: Icon(Icons.add),
              color: theme.colorScheme.primary,
            ),
            const SizedBox(width: 5),
            Expanded(
              child: SizedBox(
                height: 45,
                child: TextField(
                  controller: messageCtrl,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => onSend(),
                  cursorColor: theme.colorScheme.primary,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.image_outlined,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    focusColor: theme.colorScheme.primary,
                    hintText: 'Message...',
                    hintStyle: theme.textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF9AA0AF),
                      fontWeight: FontWeight.w500,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            IconButton(
              onPressed: onCamera,
              icon: Icon(Icons.camera_alt),
              color: theme.colorScheme.primary,
            ),
            const SizedBox(width: 5),
            IconButton(
              onPressed: () => onMic,
              icon: Icon(Icons.mic_rounded, color: theme.colorScheme.primary),
            ),
          ],
        ),
      ),
    );
  }
}
