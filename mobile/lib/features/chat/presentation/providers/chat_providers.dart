import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/firebase/firebase_service.dart';
import '../../data/models/message_model.dart';
import '../../data/repositories/chat_repository.dart';
import '../../data/repositories/firestore_chat_repository.dart';
import '../../data/repositories/in_memory_chat_repository.dart';

final _demoChatRepository = InMemoryChatRepository();

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  if (FirebaseService.remoteChatEnabled) {
    return FirestoreChatRepository();
  }
  return _demoChatRepository;
});

final chatMessagesProvider =
    StreamProvider.family<List<MessageModel>, String>((ref, conversationId) {
  return ref.watch(chatRepositoryProvider).watchMessages(conversationId);
});
