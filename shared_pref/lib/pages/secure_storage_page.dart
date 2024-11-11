import 'package:flutter/material.dart';
import '../services/secure_storage_service.dart';

class SecureStoragePage extends StatefulWidget {
  const SecureStoragePage({super.key});

  @override
  SecureStoragePageState createState() => SecureStoragePageState();
}

class SecureStoragePageState extends State<SecureStoragePage> {
  int storedInt = 0;
  double storedDouble = 0.0;
  bool storedBool = false;
  String storedString = '';
  List<String> storedStringList = [];

  @override
  void initState() {
    super.initState();
    _loadSecureData();
  }

  Future<void> _saveSecureData() async {
    await SecureStorageService.saveInt('storedInt', 42);
    await SecureStorageService.saveDouble('storedDouble', 3.1415);
    await SecureStorageService.saveBool('storedBool', true);
    await SecureStorageService.saveSecureData(
        'storedString', 'Hello, Flutter!');
    await SecureStorageService.saveStringList(
        'storedStringList', ['apple', 'banana', 'cherry']);
    await _loadSecureData();
  }

  Future<void> _loadSecureData() async {
    final intVal = await SecureStorageService.getInt('storedInt');
    final doubleVal = await SecureStorageService.getDouble('storedDouble');
    final boolVal = await SecureStorageService.getBool('storedBool');
    final stringVal = await SecureStorageService.getSecureData('storedString');
    final stringListVal =
        await SecureStorageService.getStringList('storedStringList');

    setState(() {
      storedInt = intVal ?? 0;
      storedDouble = doubleVal ?? 0.0;
      storedBool = boolVal ?? false;
      storedString = stringVal ?? '';
      storedStringList = stringListVal;
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
            Text('Stored Integer: $storedInt'),
            Text('Stored Double: $storedDouble'),
            Text('Stored Boolean: $storedBool'),
            Text('Stored String: $storedString'),
            Text('Stored String List: $storedStringList'),
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
