import 'package:flutter/material.dart';
import 'package:for_connection/Featuers/Home/home_controller.dart';
import 'package:for_connection/Featuers/Home/home_view.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final controller = HomeController();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(home: HomeView());
  }
}
// final controller = HomeController();
// final model = controller.model;
// final services = controller.services;