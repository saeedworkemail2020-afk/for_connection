import 'package:web_socket_channel/web_socket_channel.dart';

class HomeServices {
  late WebSocketChannel channel;
  HomeServices() {
    channel = WebSocketChannel.connect(Uri.parse('ws://192.168.4.1:81'));
  }
}
