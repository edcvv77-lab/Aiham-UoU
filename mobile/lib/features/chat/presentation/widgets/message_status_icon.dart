import 'package:flutter/material.dart';

class MessageStatusIcon extends StatelessWidget {
  final String status;

  const MessageStatusIcon({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case 'read':
        return const Icon(Icons.done_all, size: 16);
      case 'delivered':
        return const Icon(Icons.done_all, size: 16);
      case 'sent':
        return const Icon(Icons.done, size: 16);
      default:
        return const Icon(Icons.schedule, size: 16);
    }
  }
}
