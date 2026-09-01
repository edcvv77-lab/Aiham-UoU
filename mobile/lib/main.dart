import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: NovaChatApp()));
}

class NovaChatApp extends StatelessWidget {
  const NovaChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nova Chat',
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(
          child: Text(
            'NOVA Chat\nv0.1',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
