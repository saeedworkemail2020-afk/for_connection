// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'dart:io';

// class Functions {
//   void send() {}
//   int getData() {
//     return 0;
//   }

//   void getpermission() async {
//     if (Platform.isAndroid) {
//       await Permission.bluetoothScan.request();
//       await Permission.bluetoothConnect.request();
//       await Permission.location.request();
//     }
//   }

//   Future checking<bool>() async {
//     return await FlutterBluePlus.adapterState
//         .where((state) => state == BluetoothAdapterState.on)
//         .first;
//   }

//   scanning() async {
//     // شروع اسکن
//     await FlutterBluePlus.startScan(timeout: Duration(seconds: 4));

//     FlutterBluePlus.scanResults.listen((results) {
//       for (ScanResult r in results) {
//         if (r.device.platformName == 'ESP32') {
//           print('دستگاه پیدا شد: ${r.device.name}');
//         }
//       }
//     });
//   }

//   connection() async {}
// }
