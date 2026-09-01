import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الملف الشخصي')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 42,
              child: Icon(Icons.person_outline_rounded, size: 42),
            ),
            const SizedBox(height: 20),
            Text(
              userId,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 24),
            const Text(
              'سيتم ربط هذه الصفحة مع Firestore لإدارة الاسم والصورة والحالة.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
