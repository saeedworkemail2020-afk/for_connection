import 'dart:convert';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:http/http.dart' as http;

class HomeServices extends GetxController {
  late WebSocketChannel channel;
  final String esp32Ip = "192.168.4.1";
  String mydata = '0';
  RxString ledstatus = 'off'.obs;
  RxDouble touch = 0.0.obs;
  HomeServices(this.channel);
  Future<String> get() async {
    try {
      final url = Uri.parse("http://$esp32Ip/data");
      final response = await http.get(url).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        mydata = data["number"].toString();
      } else {
        mydata = response.statusCode.toString();
      }
    } catch (e) {
      mydata = "0";

      print("Error: $e");
    }
    return mydata;
  }

  void sendled() {
    final msg = jsonEncode({"cmd": "led"});
    channel.sink.add(msg);
  }

  void sendreset() {
    final msg = jsonEncode({"cmd": "reset"});
    channel.sink.add(msg);
    ledstatus.value = "off";

    mydata = '0';
    touch.value = 0.0;
  }

  void status() {
    channel.stream.listen((message) {
      final data = jsonDecode(message);
      ledstatus.value = data["status"];
      touch.value = (data["touch"] as num).toDouble();
    });
  }
}
