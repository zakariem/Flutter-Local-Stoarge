import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isDarkMode = prefs.getBool('isDarkMode') ?? false;

  runApp(MyApp(isDarkMode: isDarkMode));
}

class MyApp extends StatefulWidget {
  final bool isDarkMode;

  const MyApp({super.key, required this.isDarkMode});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool isDarkMode;

  @override
  void initState() {
    super.initState();
    isDarkMode = widget.isDarkMode;
  }

  void _toggleTheme() async {
    setState(() {
      isDarkMode = !isDarkMode;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: SharedPreferencesExample(
        isDarkMode: isDarkMode,
        toggleTheme: _toggleTheme,
      ),
    );
  }
}

class SharedPreferencesExample extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const SharedPreferencesExample({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  _SharedPreferencesExampleState createState() =>
      _SharedPreferencesExampleState();
}

class _SharedPreferencesExampleState extends State<SharedPreferencesExample> {
  late SharedPreferences prefs;

  int storedInt = 0;
  double storedDouble = 0.0;
  bool storedBool = false;
  String storedString = '';
  List<String> storedStringList = [];

  @override
  void initState() {
    super.initState();
    _initializePreferences();
  }

  Future<void> _initializePreferences() async {
    prefs = await SharedPreferences.getInstance();
    _loadPreferences();
  }

  Future<void> _savePreferences() async {
    await prefs.setInt('storedInt', 42);
    await prefs.setDouble('storedDouble', 3.1415);
    await prefs.setBool('storedBool', true);
    await prefs.setString('storedString', 'Hello, Flutter!');
    await prefs
        .setStringList('storedStringList', ['apple', 'banana', 'cherry']);
    _loadPreferences();
  }

  void _loadPreferences() {
    setState(() {
      storedInt = prefs.getInt('storedInt') ?? 0;
      storedDouble = prefs.getDouble('storedDouble') ?? 0.0;
      storedBool = prefs.getBool('storedBool') ?? false;
      storedString = prefs.getString('storedString') ?? '';
      storedStringList = prefs.getStringList('storedStringList') ?? [];
    });
  }

  Future<void> _clearPreferences() async {
    await prefs.clear();
    _loadPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shared Preferences Example')),
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
                  onPressed: widget.toggleTheme,
                  child: Text('Toggle Theme: ${widget.isDarkMode}'),
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
