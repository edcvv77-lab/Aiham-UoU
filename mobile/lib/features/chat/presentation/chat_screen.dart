import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../data/models/message_model.dart';
import '../domain/services/message_expiration_service.dart';
import 'providers/chat_providers.dart';
import 'widgets/message_status_icon.dart';
import 'widgets/typing_indicator.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key, required this.conversationId, required this.currentUserId, required this.peerId, required this.peerName});

  final String conversationId;
  final String currentUserId;
  final String peerId;
  final String peerName;

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final controller = TextEditingController();
  MessageDuration duration = MessageDuration.twoDays;
  bool sending = false;
  bool peerTyping = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(chatRepositoryProvider).markMessagesAsRead(
      conversationId: widget.conversationId,
      userId: widget.currentUserId,
    ));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> send() async {
    final text = controller.text.trim();
    if (text.isEmpty || sending) return;
    setState(() => sending = true);
    final now = DateTime.now().toUtc();
    await ref.read(chatRepositoryProvider).sendMessage(MessageModel(
      id: '${widget.currentUserId}-${now.microsecondsSinceEpoch}',
      conversationId: widget.conversationId,
      senderId: widget.currentUserId,
      receiverId: widget.peerId,
      text: text,
      createdAt: now,
      expireAt: MessageExpirationService.calculateExpiry(duration, from: now),
    ));
    controller.clear();
    if (mounted) {
      setState(() {
        sending = false;
        peerTyping = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(chatMessagesProvider(widget.conversationId));
    return Scaffold(
      appBar: AppBar(title: Text(widget.peerName)),
      body: Column(
        children: [
          Expanded(
            child: messages.when(
              data: (items) => ListView.builder(
                itemCount: items.length,
                itemBuilder: (_, index) {
                  final message = items[index];
                  final mine = message.senderId == widget.currentUserId;
                  return Align(
                    alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(message.text),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(DateFormat.Hm().format(message.createdAt.toLocal())),
                              if (mine) MessageStatusIcon(status: message.status),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('$e')),
            ),
          ),
          TypingIndicator(visible: peerTyping),
          Row(
            children: [
              Expanded(child: TextField(controller: controller, onChanged: (v) => setState(() => peerTyping = v.isNotEmpty))),
              IconButton(onPressed: send, icon: const Icon(Icons.send)),
            ],
          ),
        ],
      ),
    );
  }
}
