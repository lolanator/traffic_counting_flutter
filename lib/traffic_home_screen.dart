import 'package:flutter/material.dart';
import 'package:traffic_counting_project/camera_screen.dart';
import 'package:traffic_counting_project/dashboard.dart';
import 'package:traffic_counting_project/loading_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class TrafficHomeScreen extends StatefulWidget {
  @override
  _TrafficHomeScreenState createState() => _TrafficHomeScreenState();
}

class _TrafficHomeScreenState extends State<TrafficHomeScreen> {

  AnimationController _animation;
  File _galleryVideo;
  File _cameraVideo;

  ImagePicker picker = ImagePicker();

  _pickVideoFromCamera() async {
    PickedFile pickedFile = await picker.getVideo(source: ImageSource.camera);

    _cameraVideo = File(pickedFile.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Traffic Counting",
            style: GoogleFonts.sunflower(
              fontSize: 33,
              fontWeight: FontWeight.bold,
            ),
        ),
        backgroundColor: Colors.lightBlueAccent,
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
                          Colors.grey[400],
                          Colors.grey[500],
                          Colors.grey[600],
                          Colors.grey[700],
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
                            color: Colors.orange
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
                        style: GoogleFonts.sunflower(fontSize: 30, color: Colors.white),
                    ),
                  ),
                ),
              ),
              onTap: () {
                  _pickVideoFromCamera();
              },
          )
        ],
      ),
    );
  }
}
//------------------------------------------------------ Lola

/*{
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => _pickVideoFromCamera()),
                );
              }),*/

/*                      TweenAnimationBuilder(
                          tween: ColorTween(begin: Colors.white, end: Colors.green),
                          duration: const Duration(seconds: 3),
                          builder: (_, Color color, __){
                            return ColorFiltered(
                              child: Container(
                                alignment: Alignment.topCenter,
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.0),
                                  color: Colors.red,
                                ),
                              ),
                              colorFilter: ColorFilter.mode(Colors.red, BlendMode.modulate),
                            );
                          }
                        ),*/