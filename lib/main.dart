import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final channel = WebSocketChannel.connect(Uri.parse('ws://192.168.4.1:81'));

  String text = "";

  @override
  void initState() {
    super.initState();

    channel.stream.listen((message) {
      setState(() {
        text += "\n$message";
      });
    });
  }

  void send(String msg) {
    channel.sink.add(msg);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("ESP32 WebSocket")),
        body: Column(
          children: [
            ElevatedButton(onPressed: () => send("on"), child: Text("LED ON")),
            ElevatedButton(
              onPressed: () => send("off"),
              child: Text("LED OFF"),
            ),
            ElevatedButton(
              onPressed: () => send("add"),
              child: Text("Add Text"),
            ),
            Expanded(child: SingleChildScrollView(child: Text(text))),
          ],
        ),
      ),
    );
  }
}
