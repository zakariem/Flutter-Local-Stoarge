import 'package:flutter/material.dart';
import '../services/shared_preferences_service.dart';

class SharedPreferencesPage extends StatefulWidget {
  const SharedPreferencesPage({super.key});

  @override
  _SharedPreferencesPageState createState() => _SharedPreferencesPageState();
}

class _SharedPreferencesPageState extends State<SharedPreferencesPage> {
  int storedInt = 0;
  double storedDouble = 0.0;
  bool storedBool = false;
  String storedString = '';
  List<String> storedStringList = [];

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _savePreferences() async {
    await SharedPreferencesService.savePreferences(
      storedInt: 42,
      storedDouble: 3.1415,
      storedBool: true,
      storedString: 'Hello, Flutter!',
      storedStringList: ['apple', 'banana', 'cherry'],
    );
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final preferences = await SharedPreferencesService.loadPreferences();
    setState(() {
      storedInt = preferences['storedInt'];
      storedDouble = preferences['storedDouble'];
      storedBool = preferences['storedBool'];
      storedString = preferences['storedString'];
      storedStringList = preferences['storedStringList'];
    });
  }

  Future<void> _clearPreferences() async {
    await SharedPreferencesService.clearPreferences();
    _loadPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shared Preferences')),
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
                  onPressed: _savePreferences,
                  child: const Text('Save Data'),
                ),
                ElevatedButton(
                  onPressed: _clearPreferences,
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
