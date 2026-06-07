import 'package:flutter/material.dart';
import 'package:for_connection/Featuers/Home/home_controller.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

final controller = HomeController();
final model = controller.model;
final services = controller.services;

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    services.status();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: model.homeScaffoldKey,
      appBar: AppBar(
        title: const Text('ESP32 Data'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white54,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Center(
                  child: CustomPaint(
                    size: Size(300, 300),
                    painter: model.semicircle(0.5),
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      SizedBox(height: 150),
                      Text(
                        'data',
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Column(
              children: [
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      model.text(model.mydata.value),
                      model.text('  ${services.ledstatus.value}'),
                    ],
                  ),
                ),

                Divider(thickness: 1.5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [model.button("Refresh"), model.button("LED")],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
