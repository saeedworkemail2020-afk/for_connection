import 'dart:convert';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:http/http.dart' as http;

class HomeServices extends GetxController {
  late WebSocketChannel channel;
  final String esp32Ip = "192.168.4.1";
  RxString mydata = '0'.obs;
  RxString ledstatus = 'off'.obs;
  HomeServices(this.channel);
  void get() async {
    try {
      final url = Uri.parse("http://$esp32Ip/data");
      final response = await http.get(url).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        mydata.value = data["number"].toString();
      } else {
        mydata.value = response.statusCode.toString();
      }
    } catch (e) {
      mydata.value = "0";

      print("Error: $e");
    }
    print("Data: ${mydata.value}");
  }

  void send(String msg) {
    channel.sink.add(msg);
  }

  void status() {
    channel.stream.listen((message) {
      ledstatus.value = message;
    });
  }
}
