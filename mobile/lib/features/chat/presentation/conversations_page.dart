import 'package:flutter/material.dart';

class ConversationsPage extends StatelessWidget {
  const ConversationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('المحادثات')),
      body: const Center(
        child: Text(
          'قائمة المحادثات الحقيقية جاهزة للربط مع ConversationRepository',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
