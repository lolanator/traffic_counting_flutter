import 'package:flutter/material.dart';
import 'package:traffic_counting_project/dashboard.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.yellow,
          ),
          Center(
            child: SizedBox(
              height: 50,
              width: 50,
              child: InkWell(
                child: Icon(Icons.camera),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DashBoard()),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
