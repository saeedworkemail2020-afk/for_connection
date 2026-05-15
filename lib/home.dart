import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Esp32DataPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Esp32DataPage extends StatefulWidget {
  const Esp32DataPage({super.key});

  @override
  State<Esp32DataPage> createState() => _Esp32DataPageState();
}

class _Esp32DataPageState extends State<Esp32DataPage> {
  String receivedText = "No data yet";
  String receivedNumber = "0";

  final String esp32Ip = "192.168.4.1";

  Future<void> fetchDataFromEsp32() async {
    try {
      final url = Uri.parse("http://$esp32Ip/data");
      final response = await http.get(url).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          receivedText = data["text"].toString();
          receivedNumber = data["number"].toString();
        });
      } else {
        setState(() {
          receivedText = "HTTP Error";
          receivedNumber = response.statusCode.toString();
        });
      }
    } catch (e) {
      setState(() {
        receivedText = "Connection failed";
        receivedNumber = "0";
      });
      print("Error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDataFromEsp32();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ESP32 -> Flutter")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Text: $receivedText", style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 10),
              Text(
                "Number: $receivedNumber",
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: fetchDataFromEsp32,
                child: const Text("Get Data from ESP32"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
