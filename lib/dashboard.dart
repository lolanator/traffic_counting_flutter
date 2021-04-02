import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'bezier.dart';
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
  List<Offset> points;
  List<Bezier> _bezierpoints;
  int _index = 1;
  int strokes = 20;
  Offset _prev, _curr, _next;
  double _dx1 = 0, _dy1 = 0, _dx2, _dy2, _m;
  static final double _f0 = .3, _f1 = .6;
  double _t = 0;
  @override
  void initState() {
    super.initState();

    points = Point.genData(strokes);
    _bezierpoints = [];
    _addBezierCurve();
    _controller =
        AnimationController(duration: Duration(milliseconds: 100), vsync: this);
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
        ++_index;
      
        if (_index >= strokes - 1) {
          _controller.stop();
          _index = strokes - 1;
        } else {
          _addBezierCurve();
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
          _t = _animation.value;
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
                  painter: GraphPainter(points, strokes, _t, _bezierpoints),
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
  //
  double _gradient(Offset a, Offset b) {
    Offset c = b - a;
    return c.dy / c.dx;
  }

  void _addBezierCurve() {
    _prev = points.length > 0 ? points[_index - 1] : null;
    _curr = points.length > 1 ? points[_index] : null;
    _next = points.length > 2 ? points[_index + 1] : null;

    if (_next != null) {
      _m = _gradient(_prev, _next);
      _dx2 = (_next - _prev).dx * -_f0;
      _dy2 = _dx2 * _m * _f1;
    } else {
      _dx2 = _dy2 = 0;
    }
    _bezierpoints.add(Bezier(
        _prev, _prev - Offset(_dx1, _dy1), _curr + Offset(_dx2, _dy2), _curr));
    _dx1 = _dx2;
    _dy1 = _dy2;
  }
}
