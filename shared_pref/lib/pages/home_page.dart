import 'package:flutter/material.dart';
import 'package:shared_pref/pages/secure_storage_page.dart';
import 'package:shared_pref/pages/shared_preferences_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SharedPreferencesPage()),
                );
              },
              child: const Text('Shared Preferences'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SecureStoragePage()),
                );
              },
              child: const Text('Secure Storage'),
            ),
          ],
        ),
      ),
    );
  }
}
