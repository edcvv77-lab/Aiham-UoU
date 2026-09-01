import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/firebase/firebase_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final remoteEnabled = FirebaseService.remoteChatEnabled;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.lock_outline_rounded),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'UoU',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text('Private communication'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  Icon(
                    remoteEnabled
                        ? Icons.cloud_done_outlined
                        : Icons.phone_android_rounded,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      remoteEnabled
                          ? 'Firebase backend enabled'
                          : 'Demo mode — messages stay on this device',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Text(
              'المحادثات',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: const CircleAvatar(
                  child: Icon(Icons.person_outline_rounded),
                ),
                title: const Text('صديق تجريبي'),
                subtitle: const Text('اختبر الرسائل المؤقتة الآن'),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () {
                  context.push(
                    Uri(
                      path: '/chat/demo-friend',
                      queryParameters: const {'name': 'صديق تجريبي'},
                    ).toString(),
                  );
                },
              ),
            ),
            const SizedBox(height: 28),
            const Text(
              'مدة الرسالة الافتراضية يومان. ويمكن تغييرها إلى أسبوع أو '
              'أسبوعين أو ثلاثة أسابيع قبل الإرسال.',
            ),
          ],
        ),
      ),
    );
  }
}
