import 'package:flutter/material.dart';
import '../services/secure_storage_service.dart';

class SecureStoragePage extends StatefulWidget {
  const SecureStoragePage({super.key});

  @override
  _SecureStoragePageState createState() => _SecureStoragePageState();
}

class _SecureStoragePageState extends State<SecureStoragePage> {
  String storedValue = '';

  Future<void> _saveSecureData() async {
    await SecureStorageService.saveSecureData('secureKey', 'Secure Data');
    _loadSecureData();
  }

  Future<void> _loadSecureData() async {
    final value = await SecureStorageService.getSecureData('secureKey');
    setState(() {
      storedValue = value ?? '';
    });
  }

  Future<void> _clearSecureData() async {
    await SecureStorageService.clearSecureData();
    _loadSecureData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Secure Storage')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Stored Value: $storedValue'),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: _saveSecureData,
                  child: const Text('Save Data'),
                ),
                ElevatedButton(
                  onPressed: _clearSecureData,
                  child: const Text('Clear Data'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
