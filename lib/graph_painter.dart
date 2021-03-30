import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math';
import 'point.dart';

class GraphPainter extends CustomPainter {
  List<Point> _points;
  double left, top, width, height, len;
  double value;
  Point pos;
  int _index;
  Point _start, _end;
  GraphPainter(List<Point> points, int index, Point start, Point end) {
    _points = points;
    this._index = index;
    this._start = start;
    this._end = end;
  }
  void _drawCurve(List<Point> points, Canvas canvas, Size size) {
    final double left = size.width * .1;
    final double top = 0;
    final double width = size.width * .9;
    final double height = size.height * .9;
    final double len = points.length.toDouble();
    Paint paint = Paint();
    paint.color = Colors.black;
    for (var i = 0; i <= _index; i++) {

      if ((i + 1) > _index) break;
      Offset p1 = Offset(
          left + i / len * width, top + (len - points[i].y) / len * height);
      Offset p2 = Offset(left + (i + 1) / len * width,
          top + (len - points[i + 1].y) / len * height);
      canvas.drawLine(p1, p2, paint);
    }
    Offset p1 = Offset(
        left + _start.x / len * width, top + (len - _start.y) / len * height);
    Offset p2 = Offset(
        left + _end.x / len * width, top + (len - _end.y) / len * height);
    canvas.drawLine(p1, p2, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final double left = size.width * .1;
    final double top = 0;
    final double width = size.width * .9;
    final double height = size.height * .9;
    Paint paint = Paint();
    paint.color = Colors.white;
    paint.style = PaintingStyle.fill;
    Rect r = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
    canvas.drawRect(r, paint);
    paint.color = Colors.black;
    paint.strokeWidth = 2.5;
    //draw the axes
    canvas.drawLine(Offset(left, top), Offset(left, height), paint);
    canvas.drawLine(Offset(left, height), Offset(size.width, height), paint);
    //draw the marks on the axes
    int strokes = 19;
    final double offset = 5;
    for (int i = 0; i < strokes; i++) {
      double leftOffset = left + width / strokes * i;
      Offset p1 = Offset(leftOffset, height - offset);
      Offset p2 = Offset(leftOffset, height + offset);
      canvas.drawLine(p1, p2, paint);
      double topOffset = top + height / strokes * (i + 1);
      p1 = Offset(left - offset, topOffset);
      p2 = Offset(left + offset, topOffset);
      canvas.drawLine(p1, p2, paint);
    }

    //draw the numbers on the axes

    for (int i = 0; i < strokes; i++) {
      ParagraphStyle ps =
          ParagraphStyle(textAlign: TextAlign.center, fontSize: 10);
      ParagraphBuilder pb = ParagraphBuilder(ps);
      pb.addText("$i");
      ParagraphConstraints pc = ParagraphConstraints(width: 300);
      Paragraph par = pb.build();
      par.layout(pc);
      double leftOffset = left + width / strokes * i - par.width / 2;
      Offset off = Offset(leftOffset, height + offset);
      canvas.drawParagraph(par, off);

      ps = ParagraphStyle(textAlign: TextAlign.right, fontSize: 10);
      pb = ParagraphBuilder(ps);
      pb.addText("${strokes - i - 1}");
      pc = ParagraphConstraints(width: 100);
      par = pb.build();
      par.layout(pc);
      double topOffset = top + height / strokes * (i + 1) - par.height / 2;
      off = Offset(left - offset - par.width, topOffset);
      canvas.drawParagraph(par, off);
    }
    _drawCurve(_points, canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return true;
  }
}
