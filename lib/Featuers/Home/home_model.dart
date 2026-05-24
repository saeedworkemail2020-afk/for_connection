import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomeModel extends GetxController {
  late GlobalKey<ScaffoldState> homeScaffoldKey;
  HomeModel() {
    homeScaffoldKey = GlobalKey<ScaffoldState>();
  }
}
