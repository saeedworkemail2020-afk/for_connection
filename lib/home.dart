import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'ESP32 Communication', home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  String _esp32Response = 'No response yet';

  // این آدرس آی‌پی پیش‌فرض ESP32 در حالت AP هست
  final String esp32IpAddress = "192.168.4.1";

  Future<void> sendDataToESP32() async {
    final url = Uri.parse("http://$esp32IpAddress/postData"); // آدرس ESP32

    try {
      final response = await http
          .post(
            url,
            body: {
              "text": _textController.text,
              "number": _numberController.text.isEmpty
                  ? "0"
                  : _numberController.text,
            },
          )
          .timeout(
            Duration(seconds: 5),
          ); // اضافه کردن تایم‌اوت برای جلوگیری از هنگ کردن

      setState(() {
        _esp32Response = 'ESP32 Response: ${response.body}';
      });
      print("Response from ESP32: ${response.body}");
    } catch (e) {
      setState(() {
        _esp32Response =
            'Error: Could not connect to ESP32. Make sure you are connected to the "${_getApSsid()}" Wi-Fi network.';
      });
      print("Error sending data: $e");
    }
  }

  // این تابع کمک می‌کنه که اسم AP رو از تنظیمات احتمالی بخونیم یا پیش‌فرض بدیم
  String _getApSsid() {
    // در اینجا می‌تونید اسم AP رو ثابت بذارید یا از تنظیمات اپلیکیشن بخونید
    return "ESP32_AP"; // باید با اسم `ap_ssid` در کد ESP32 یکی باشه
  }

  @override
  void dispose() {
    _textController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ESP32 AP Communicator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    labelText: 'Enter Text',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _numberController,
                  decoration: InputDecoration(
                    labelText: 'Enter Number',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: sendDataToESP32,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                  child: Text('Send Data to ESP32'),
                ),
                SizedBox(height: 30),
                Text(
                  _esp32Response,
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  "Ensure your device is connected to the '${_getApSsid()}' Wi-Fi network.",
                  style: TextStyle(fontSize: 12, color: Colors.redAccent),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
