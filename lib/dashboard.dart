import 'dart:ui';
import 'package:flutter/rendering.dart';

import 'graph_painter.dart';
import 'package:flutter/material.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'point.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard>
    with SingleTickerProviderStateMixin {
  BuildContext _context;
  Animation<double> _animation;
  AnimationController _controller;
  List<Point> points;
  Point start;
  Point end;
  int _index = 0;
  int strokes = 20;
  @override
  void initState() {
    super.initState();
    points = Point.genData(strokes);
    _controller =
        AnimationController(duration: Duration(milliseconds: 100), vsync: this);
    start = points[_index];
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
        ++_index;
        if (_index >= strokes - 1) {
          _controller.stop();
          _index = strokes - 1;
        } else {
          start = points[_index];
          end = start;
        }
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {
          double x = points[_index].x +
              (points[_index + 1].x - points[_index].x) * _animation.value;
          double y = points[_index].y +
              (points[_index + 1].y - points[_index].y) * _animation.value;
          end = Point(x, y);
        });
      });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Container(
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
          child: Column(
            children: <Widget>[
              Flexible(
                  
                  child: CustomScrollView(
                    anchor: 0.0,
                    shrinkWrap: false,
                    physics: ClampingScrollPhysics(),
                    slivers: <Widget>[
                      _buildHeader(),
                      _buildRegionTabBar(),
                      // _buildStatsTabBar(),
                    ],
                  )),
                  Container(
                    alignment: Alignment.center,
                    height: vh(.8),
                    width: vw(.8),
                    child: CustomPaint(
                      painter: GraphPainter(points, _index, start, end, strokes),
                      size: Size(vw(.9), vh(.8)),
                    ),
                  ),
            ],
          )),
    );
  }

  double vw(double ratio) {
    return MediaQuery.of(_context).size.width * ratio;
  }

  double vh(double ratio) {
    return MediaQuery.of(_context).size.height * ratio;
  }

  SliverPadding _buildHeader() {
    return SliverPadding(
      padding: const EdgeInsets.all(20.0),
      sliver: SliverToBoxAdapter(
        child: Center(
          child: Text(
            'Detected Traffic',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void setColor(Container c, int colo) {}
  SliverToBoxAdapter _buildRegionTabBar() {
    return SliverToBoxAdapter(
      child: DefaultTabController(
        length: 4,
        child: Container(
          height: 50.0,
          decoration: BoxDecoration(
            color: Color(0xFF4563DB),
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: TabBar(
            indicator: BubbleTabIndicator(
                tabBarIndicatorSize: TabBarIndicatorSize.tab,
                indicatorHeight: 40.0,
                indicatorColor: Colors.white),
            labelColor: Colors.black,
            unselectedLabelColor: Colors.white,
            tabs: <Widget>[
              Text('Cars'),
              Text('Buses'),
              Text('Trucks'),
              Text('Bicycles'),
            ],
            onTap: (index) {
              setState(() {});
            },
          ),
        ),
      ),
    );

    // SliverPadding _buildStatsTabBar() {
    //   return SliverPadding();
    // }
  }

  // ------------------------------------------------------Michael
}
