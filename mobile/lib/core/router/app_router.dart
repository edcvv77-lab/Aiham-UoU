import 'package:go_router/go_router.dart';

import '../../features/chat/presentation/chat_screen.dart';
import '../../features/home/presentation/home_screen.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/chat/:peerId',
        builder: (context, state) {
          final peerId = state.pathParameters['peerId'] ?? 'demo-friend';
          final peerName =
              state.uri.queryParameters['name'] ?? 'صديق تجريبي';

          return ChatScreen(
            conversationId: _conversationId('demo-owner', peerId),
            currentUserId: 'demo-owner',
            peerId: peerId,
            peerName: peerName,
          );
        },
      ),
    ],
  );

  static String _conversationId(String first, String second) {
    final ids = [first, second]..sort();
    return ids.join('_');
  }
}
