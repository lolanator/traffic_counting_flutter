import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:math';
import 'point.dart';

class GraphPainter extends CustomPainter {
  List<Point> _points;
  double _left, _top, _width, _height, _len;
  double value;
  Point pos;
  int _index;
  Point _start, _end;
  int _strokes;
  GraphPainter(
      this._points, this._index, this._start, this._end, this._strokes);

  Offset _getBezier(Offset p0, Offset p1, Offset p2, Offset p3, double t) {
    double u = 1 - t;
    double uu = u * u;
    double uuu = u * u * u;
    double tt = t * t;
    double ttt = t * t * t;
    return (p0 * uuu) + (p1 * 3 * uu * t) + (p2 * 3 * u * tt) + (p3 * ttt);
  }

  void _drawCurve(List<Point> points, Canvas canvas, Size size, Paint paint) {
    _len = points.length.toDouble();
    Color prevColor = paint.color;
    double prevStrokeWidth = paint.strokeWidth;
    paint.color = Colors.white;
    paint.strokeWidth = 3;
    for (var i = 0; i <= _index; i++) {
      if ((i + 1) > _index) break;
      Offset p1 = Offset(_left + i / _len * _width,
          _top + (_len - points[i].y) / _len * _height);
      Offset p2 = Offset(_left + (i + 1) / _len * _width,
          _top + (_len - points[i + 1].y) / _len * _height);
      canvas.drawLine(p1, p2, paint);
    }
    Offset p1 = Offset(_left + _start.x / _len * _width,
        _top + (_len - _start.y) / _len * _height);
    Offset p2 = Offset(_left + _end.x / _len * _width,
        _top + (_len - _end.y) / _len * _height);
    canvas.drawLine(p1, p2, paint);
    paint.color = prevColor;
    paint.strokeWidth = prevStrokeWidth;
  }

  void _drawGuidingLines(Canvas canvas, Size size, Paint paint) {
    Color prevColor = paint.color;
    paint.color = Color(0x22FFFFFF);
    final double lineWidth = _width * .9;
    for (int i = 0; i < _strokes; i += 1) {
      double top = _top + _height / _strokes * (i + 1);
      Offset p1 = Offset(_left + (_width - lineWidth) / 2, top);
      Offset p2 = Offset(_left + (_width - lineWidth) / 2 + lineWidth, top);
      canvas.drawLine(p1, p2, paint);
    }
    paint.color = prevColor;
  }

  void _drawLabel(String label, Size size, Canvas canvas, Paint paint) {
    final double fontSize = 23;
    ui.ParagraphStyle ps =
        ui.ParagraphStyle(textAlign: TextAlign.center, fontSize: fontSize);
    ui.ParagraphBuilder pb = ui.ParagraphBuilder(ps);
    pb.pushStyle(ui.TextStyle(color: Colors.white));
    pb.addText(label);
    ui.ParagraphConstraints pc = ui.ParagraphConstraints(width: 300);
    ui.Paragraph par = pb.build();
    par.layout(pc);

    double left = size.width / 2 - par.width / 2;
    double top = size.height * 0;
    canvas.drawParagraph(par, Offset(left, top));

    final double lineWidth = size.width * .1;
    left = size.width / 2 - lineWidth / 2;
    top = size.height * 0 + par.height;
    Color prevColor = paint.color;
    double stroke = paint.strokeWidth;
    paint.color = Colors.white;
    paint.strokeWidth = 3;
    canvas.drawLine(Offset(left, top), Offset(left + lineWidth, top), paint);
    paint.color = prevColor;
    paint.strokeWidth = stroke;
  }

  void _drawAxes(Canvas canvas, Paint paint) {
    Color prevColor = paint.color;
    double prevStrokeWidth = paint.strokeWidth;
    paint.color = Colors.white;
    paint.strokeWidth = 2.5;
    canvas.drawLine(Offset(_left, _top), Offset(_left, _top + _height), paint);
    canvas.drawLine(Offset(_left, _top + _height),
        Offset(_left + _width, _top + _height), paint);
    paint.color = prevColor;
    paint.strokeWidth = prevStrokeWidth;
  }

  void _drawNumbers(Canvas canvas, Paint paint, double offset) {
    final double fontSize = 23;
    ui.ParagraphBuilder pb;
    ui.ParagraphStyle ps;
    ui.ParagraphConstraints pc;
    ui.Paragraph par;
    Offset off;
    for (int i = 0; i < _strokes; i += 2) {
      //draw the horizontal numbers
      ps = ui.ParagraphStyle(textAlign: TextAlign.center, fontSize: fontSize);
      pb = ui.ParagraphBuilder(ps);
      pb.pushStyle(ui.TextStyle(color: Colors.white));
      pb.addText("$i");
      pc = ui.ParagraphConstraints(width: 300);
      par = pb.build();
      par.layout(pc);
      double leftOffset = _left + _width / _strokes * i - par.width / 2;
      off = Offset(leftOffset, _top + _height + offset);
      canvas.drawParagraph(par, off);

      //draw the vertical numbers
      ps = ui.ParagraphStyle(textAlign: TextAlign.right, fontSize: fontSize);
      pb = ui.ParagraphBuilder(ps);
      pb.pushStyle(ui.TextStyle(color: Colors.white));
      pb.addText("${_strokes - i - 1}");
      pc = ui.ParagraphConstraints(width: 100);
      par = pb.build();
      par.layout(pc);
      double topOffset = _top + _height / _strokes * (i + 1) - par.height / 2;
      off = Offset(_left - offset - par.width, topOffset);
      canvas.drawParagraph(par, off);
    }
  }

  _drawAxesMarks(Canvas canvas, Paint paint, double offset) {
    for (int i = 0; i < _strokes; i++) {
      double leftOffset = _left + _width / _strokes * i;
      Offset p1 = Offset(leftOffset, _height - offset);
      Offset p2 = Offset(leftOffset, _height + offset);
      canvas.drawLine(p1, p2, paint);
      double topOffset = _top + _height / _strokes * (i + 1);
      p1 = Offset(_left - offset, topOffset);
      p2 = Offset(_left + offset, topOffset);
      canvas.drawLine(p1, p2, paint);
    }
  }

  _drawBackground(Canvas canvas, Size size, Paint paint) {
    Color prevColor = paint.color;
    PaintingStyle prevStyle = paint.style;
    paint.color = Colors.white;
    paint.style = PaintingStyle.fill;
    Rect r = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
    canvas.drawRect(r, paint);
    paint.style = prevStyle;
    paint.color = prevColor;
  }


  @override
  void paint(Canvas canvas, Size size) {
    _left = size.width * .1;
    _top = size.height * .1;
    _width = size.width * .9;
    _height = size.height * .8;
    Paint paint = Paint();
    // draw the background
    // _drawBackground(canvas, size, paint);

    //draw the axes
    _drawAxes(canvas, paint);
    //draw the marks on the axes
    final double offset = 15;

    //draw the marks on the axes
    // _drawAxesMarks(canvas, paint, offset);

    //draw the numbers on the axes
    _drawNumbers(canvas, paint, offset);

    //draw the guiding lines on the graph
    _drawGuidingLines(canvas, size, paint);

    //draw the graph curve
    _drawCurve(_points, canvas, size, paint);

    //draw the label on the graph
    _drawLabel("CAR TRAFFIC", size, canvas, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return true;
  }
}
