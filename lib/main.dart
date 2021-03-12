import 'package:flutter/material.dart';
import 'package:traffic_counting_project/traffic_home_screen.dart';

void main() => runApp(MyApp());

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
//---------------Jack
