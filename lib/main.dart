import 'package:flutter/material.dart';
import 'package:traffic_counting_project/traffic_home_screen.dart';
import 'package:traffic_counting_project/camera_screen.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Traffic UI',
      debugShowCheckedModeBanner: false,
      home: TrafficHomeScreen(),
    );
  }
}
