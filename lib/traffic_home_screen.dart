import 'package:flutter/material.dart';
import 'package:traffic_counting_project/camera_screen.dart';
import 'package:traffic_counting_project/dashboard.dart';
import 'package:traffic_counting_project/loading_screen.dart';

class TrafficHomeScreen extends StatefulWidget {
  @override
  _TrafficHomeScreenState createState() => _TrafficHomeScreenState();
}
//hello-----

class _TrafficHomeScreenState extends State<TrafficHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Navigation"),
        backgroundColor: Color(0xFF3594DD),
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DashBoard()),
            );
          },
          child: Icon(
            Icons.bar_chart, // add custom icons also
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.1, 0.4, 0.7, 0.9],
                colors: [
                  Color(0xFF3594DD),
                  Color(0xFF4563DB),
                  Color(0xFF5036D5),
                  Color(0xFF5B16D0),
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.width * .2,
            alignment: Alignment.center,
            child: Text(
              "Application Name",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
          Center(
            child: Container(
              height: 200,
              width: 100,
              child: Stack(
                children: [
                  Container(
                    //  alignment: Alignment.center,
                    height: 200,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.1, 0.4, 0.7, 0.9],
                        colors: [
                          Colors.grey[500],
                          Colors.grey[500],
                          Colors.grey[500],
                          Colors.grey[600],
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 27, top: 20),
                        child: Container(
                          alignment: Alignment.topCenter,
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            color: Colors.red,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 27, top: 15),
                        child: Container(
                          alignment: Alignment.topCenter,
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            color: Colors.orange,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 27, top: 15),
                        child: Container(
                          alignment: Alignment.topCenter,
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          InkWell(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.white60,
                  width: double.infinity,
                  height: 50,
                  child: Center(
                    child: Text(
                      'Get started',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CameraScreen()),
                );
              }),
        ],
      ),
    );
  }
}
//------------------------------------------------------ Lola
