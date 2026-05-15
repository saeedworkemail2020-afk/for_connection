import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'ESP32 Send Data', home: const SendDataPage());
  }
}

class SendDataPage extends StatelessWidget {
  const SendDataPage({super.key});

  // IP پیش‌فرضی که ESP32 AP می‌دهد معمولاً این است: 192.168.4.1
  // اگر در سریال چیز دیگری دیدی همین را تغییر بده.
  final String esp32Url = 'http://192.168.4.1';

  Future<void> send(String text, int num) async {
    final uri = Uri.parse(
      '$esp32Url/set?text=${Uri.encodeQueryComponent(text)}&num=$num',
    );

    try {
      final response = await http.get(uri).timeout(const Duration(seconds: 3));

      // برای دیباگ می‌تونی ببینی چی برگشته
      debugPrint('Request URL: $uri');
      debugPrint('Status: ${response.statusCode}');
      debugPrint('Body: ${response.body}');
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<void> fetchData() async {
    final url = Uri.parse('$esp32Url/data');
    print("=======1");

    final response = await http.get(url);
    print("=======2");

    if (response.statusCode == 200) {
      print("=======3");

      final data = jsonDecode(response.body);
      print(data['name']);
      print(data['temp']);
      print(data['state']);
    } else {
      print('Error: ${response.statusCode}');
      print('Error: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ESP32 Send Data')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                send("ESP 32", 42);
                fetchData();
              },
              child: const Text('ارسال رشته + عدد (سلام / 42)'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => send("Hello", 123),
              child: const Text('ارسال رشته + عدد (Hello / 123)'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => send("Hesldghlskjdfhglsllo", 1249673),
              child: const Text('ارسال رشته + عدد (Hello / 123)'),
            ),
          ],
        ),
      ),
    );
  }
}
