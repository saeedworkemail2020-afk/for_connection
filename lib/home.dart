import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatelessWidget {
  const Homepage({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'ESP32 Control', home: ESP32ControlPage());
  }
}

class ESP32ControlPage extends StatelessWidget {
  final String esp32Url = 'http://192.168.4.1'; // IP پیش‌فرض ESP32 در حالت AP

  Future<void> sendCommand(String command) async {
    try {
      final response = await http.get(Uri.parse('$esp32Url/led/$command'));
      // print(response.body); // اختیاری: خطاگیری یا لاگ خروجی سرور
    } catch (e) {
      // خطاگیری ساده
      // print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ESP32 Control')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => sendCommand('on'),
              child: const Text('LED روشن کن'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => sendCommand('off'),
              child: const Text('LED خاموش کن'),
            ),
          ],
        ),
      ),
    );
  }
}
