import 'dart:math';

import 'package:flutter/material.dart';
import 'package:for_connection/Featuers/Home/home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'ESP32 Send Data', home: const SendDataPage());
  }
}

final controller = HomeController();
final model = controller.model;

class SendDataPage extends StatelessWidget {
  const SendDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: model.homeScaffoldKey,
      appBar: AppBar(title: const Text('ESP32 Send Data')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Center(
                  child: CustomPaint(
                    size: Size(300, 300),
                    painter: SemiCircleProgressPainter(0.5),
                  ),
                ),
                Center(
                  child: Column(
                    children: [SizedBox(height: 150), Text('data')],
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Container(
                      color: Colors.transparent,
                      width: 100,
                      height: 50,
                      child: Center(child: Text('data')),
                    ),
                    ElevatedButton(onPressed: () {}, child: Text("Refresh")),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      color: Colors.transparent,
                      width: 100,
                      height: 50,
                      child: Center(child: Text('status')),
                    ),
                    ElevatedButton(onPressed: () {}, child: Text("LED")),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
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
