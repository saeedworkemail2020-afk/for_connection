import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomeServices extends GetxController {
  late WebSocketChannel channel;
  RxString ledstatus = 'off'.obs;
  RxInt mydata = 0.obs;
  HomeServices(this.channel);

  void send(String msg) {
    channel.sink.add(msg);
  }

  void status() {
    channel.stream.listen((message) {
      ledstatus.value = message;
    });
  }
}
