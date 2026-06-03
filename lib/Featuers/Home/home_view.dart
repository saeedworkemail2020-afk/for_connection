import 'package:flutter/material.dart';
import 'package:for_connection/Featuers/Home/home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const SendDataPage());
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [model.text('data'), model.text('  status')],
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
