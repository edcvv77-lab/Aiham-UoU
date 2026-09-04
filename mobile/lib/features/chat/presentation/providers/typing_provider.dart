import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/services/typing_service.dart';

final typingServiceProvider = Provider<TypingService>((ref) {
  return TypingService(FirebaseFirestore.instance);
});

final typingStateProvider =
    StreamProvider.family<Map<String, dynamic>, String>((ref, conversationId) {
  return ref.watch(typingServiceProvider).watchTyping(conversationId);
});
