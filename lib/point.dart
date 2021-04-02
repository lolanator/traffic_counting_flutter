import 'dart:math';

import 'package:flutter/painting.dart';

class Point {
  
static List<Offset> genData(int strokes) {
    List<Offset> points = [];
    var rng = Random();
    for (var i = 0; i < strokes; i++)
      points.add(Offset(i.toDouble(), rng.nextDouble() * strokes));
    return points;
  }
}
