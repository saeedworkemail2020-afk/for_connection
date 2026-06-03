import 'dart:math';

import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomeModel extends GetxController {
  late GlobalKey<ScaffoldState> homeScaffoldKey;
  HomeModel() {
    homeScaffoldKey = GlobalKey<ScaffoldState>();
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
