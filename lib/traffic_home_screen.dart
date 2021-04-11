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
  Color _colorRed = Colors.pinkAccent;
  Color _colorGreen = Colors.lightGreenAccent;
  Color _colorYellow = Colors.yellowAccent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Countify+",
          style: TextStyle(fontFamily: "Chicle", fontSize: 40),
        ),
        backgroundColor: Color(0xFF3594DD),
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DashBoard()),
            );
          },
          child: Icon(
            Icons.bar_chart,
            color: Colors.orangeAccent, // add custom icons also
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
            padding: EdgeInsets.only(top: 30),
            height: MediaQuery.of(context).size.width * .2,
            alignment: Alignment.center,
            child: Text(
              "Ready... Steady... GO!",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white, fontSize: 30, fontFamily: "Ubuntu"),
            ),
          ),
          Center(
            child: Container(
              height: 300,
              width: 150,
              child: Stack(
                children: [
                  Container(
                    //  alignment: Alignment.center,
                    height: 300,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.0),
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
                      TweenAnimationBuilder(
                        child: Padding(
                          padding: EdgeInsets.only(left: 40.25, top: 20),
                          child: Container(
                            alignment: Alignment.topCenter,
                            height: 67.5,
                            width: 67.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0),
                              color: Colors.red[800],
                            ),
                          ),
                        ),
                        duration: Duration(milliseconds: 450),
                        tween: ColorTween(begin: Colors.red[800], end: _colorRed),
                        builder: (BuildContext context, Color color, Widget child) {
                          return Padding(
                            padding: EdgeInsets.only(left: 40.25, top: 20),
                            child: Container(
                              alignment: Alignment.topCenter,
                              height: 67.5,
                              width: 67.5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.0),
                                color: color,
                              ),
                            ),
                          );
                        },
                        onEnd: () => setState(() => _colorRed = Colors.red[800],
                        ),
                      ),
                      TweenAnimationBuilder(
                        child: Padding(
                          padding: EdgeInsets.only(left: 40.25, top: 20),
                          child: Container(
                            alignment: Alignment.topCenter,
                            height: 67.5,
                            width: 67.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0),
                              color: Colors.orange,
                            ),
                          ),
                        ),
                        duration: Duration(milliseconds: 600),
                        tween: ColorTween(begin: Colors.orange, end: _colorYellow),
                        builder: (BuildContext context, Color color, Widget child) {
                          return Padding(
                            padding: EdgeInsets.only(left: 40.25, top: 20),
                            child: Container(
                              alignment: Alignment.topCenter,
                              height: 67.5,
                              width: 67.5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.0),
                                color: color,
                              ),
                            ),
                          );
                        },
                        onEnd: () => setState(() => _colorYellow = Colors.orange,
                        ),
                      ),
                      TweenAnimationBuilder(
                        child: Padding(
                          padding: EdgeInsets.only(left: 40.25, top: 20),
                          child: Container(
                            alignment: Alignment.topCenter,
                            height: 67.5,
                            width: 67.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0),
                              color: Colors.green,
                            ),
                          ),
                        ),
                        duration: Duration(milliseconds: 750),
                        tween: ColorTween(begin: Colors.green, end: _colorGreen),
                        builder: (BuildContext context, Color color, Widget child) {
                          return Padding(
                            padding: EdgeInsets.only(left: 40.25, top: 20),
                            child: Container(
                              alignment: Alignment.topCenter,
                              height: 67.5,
                              width: 67.5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.0),
                                color: color,
                              ),
                            ),
                          );
                        },
                        onEnd: () => setState(() => _colorGreen = Colors.green,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 5,
            child: const DecoratedBox(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.red,
                    Colors.green,
                  ],
                ),
              ),
            ),
          ),
          InkWell(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.white60,
                  width: double.infinity,
                  height: 80,
                  child: Center(
                    child: Text(
                      'Get started',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Ubuntu",
                        fontWeight: FontWeight.bold,
                        fontSize: 37,
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