import 'dart:math';

class Point {
  double x;
  double y;

  Point(this.x, this.y);

static List<Point> genData(int strokes) {
    List<Point> points = [];
    var rng = Random();
    for (var i = 0; i < strokes; i++)
      points.add(Point(i.toDouble(), rng.nextDouble() * strokes));
    return points;
  }
}
