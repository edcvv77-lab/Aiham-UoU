import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NOVA Chat'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.forum_outlined, size: 72),
            SizedBox(height: 16),
            Text(
              'Private communication space',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
