import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/conversation_repository.dart';
import '../data/models/conversation_model.dart';

class ConversationsPage extends StatelessWidget {
  const ConversationsPage({
    super.key,
    required this.userId,
  });

  final String userId;

  @override
  Widget build(BuildContext context) {
    final repository = ConversationRepository(FirebaseFirestore.instance);

    return Scaffold(
      appBar: AppBar(title: const Text('المحادثات')),
      body: StreamBuilder<List<ConversationModel>>(
        stream: repository.watchUserConversations(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final conversations = snapshot.data ?? const [];
          if (conversations.isEmpty) {
            return const Center(child: Text('لا توجد محادثات'));
          }

          return ListView.builder(
            itemCount: conversations.length,
            itemBuilder: (context, index) {
              final conversation = conversations[index];
              return ListTile(
                title: Text(
                  conversation.participants
                      .where((id) => id != userId)
                      .firstOrNull ??
                      'مستخدم',
                ),
                subtitle: Text(conversation.lastMessage),
                trailing: conversation.unreadCount > 0
                    ? CircleAvatar(
                        radius: 12,
                        child: Text('${conversation.unreadCount}'),
                      )
                    : null,
              );
            },
          );
        },
      ),
    );
  }
}
