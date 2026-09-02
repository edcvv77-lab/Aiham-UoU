import 'package:flutter/material.dart';

import '../../data/models/message_model.dart';

class MessageStatusIcon extends StatelessWidget {
  const MessageStatusIcon({super.key, required this.status});

  final MessageStatus status;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case MessageStatus.sending:
        return const Icon(Icons.schedule, size: 16);
      case MessageStatus.sent:
        return const Icon(Icons.done, size: 16);
      case MessageStatus.delivered:
      case MessageStatus.read:
        return const Icon(Icons.done_all, size: 16);
    }
  }
}
