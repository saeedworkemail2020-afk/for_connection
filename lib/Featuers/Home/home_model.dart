import 'dart:math';
import 'package:for_connection/Featuers/Home/home_services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomeModel extends GetxController {
  late GlobalKey<ScaffoldState> homeScaffoldKey;
  late HomeServices services;
  late WebSocketChannel channel;

  HomeModel() {
    homeScaffoldKey = GlobalKey<ScaffoldState>();
    channel = WebSocketChannel.connect(Uri.parse('ws://192.168.4.1:81'));
    services = HomeServices(channel);
  }
  SemiCircleProgressPainter semicircle(double progress) =>
      SemiCircleProgressPainter(progress);
  Container text(String label) {
    return Container(
      color: Colors.transparent,
      width: 100,
      height: 50,
      child: Center(
        child: Text(
          label,
          style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  ElevatedButton button(String action) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      onPressed: () {
        if (action == 'LED') {
          services.send('led');
        } else {}
      },
      child: Text(action),
    );
  }
}

class SemiCircleProgressPainter extends CustomPainter {
  final double progress; // عددی بین 0.0 تا 1.0

  SemiCircleProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round
      ..color = Colors.blue;

    // شروع از بالا-چپ و کشیدن به اندازه یک نیم‌دایره
    canvas.drawArc(rect, -pi, pi * progress, false, paint);
  }

  @override
  bool shouldRepaint(covariant SemiCircleProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
