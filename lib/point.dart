import 'dart:math';

class Point {
  double x;
  double y;

  Point(double dx, double dy) {
    this.x = dx;
    this.y = dy;
  }


static List<Point> genData(int strokes) {
    List<Point> points = [];
    var rng = Random();
    for (var i = 0; i < strokes; i++)
      points.add(Point(i.toDouble(), rng.nextDouble() * strokes));
    return points;
  }
}
