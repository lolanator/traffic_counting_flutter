import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:math';

class GraphPainter extends CustomPainter {
  List<int> _points;
  List<ui.Image> _images;
  List<Color> _gradients = <Color>[
    Colors.red,
    Color(0xFFFF0000),
    Colors.orange,
    Color(0xFFFF4500),
    Colors.green,
    Color(0xFF00FF00),
    Colors.blue,
    Color(0xFF0000FF)
  ];
  double _left,
      _top,
      _width,
      _height,
      _outerRadius,
      _innerRadius,
      _barWidth,
      _t;
  int _strokes;
  Vehicle _vehicle;
  int _vehicleNo;
  List<String> _titles = <String>["Cars", "Bicycles", "Buses", "Trucks"];

  GraphPainter.drawBarChart(this._points, this._strokes, this._t, this._vehicle,
      this._images, this._vehicleNo);

  void _drawGuidingLines(Canvas canvas, Size size, Paint paint) {
    paint.color = Color(0x22FFFFFF);
    final double lineWidth = _width * .9;
    for (int i = 0; i < _strokes; i += 1) {
      double top = _top + _height / _strokes * (i + 1);
      Offset p1 = Offset(_left + (_width - lineWidth) / 2, top);
      Offset p2 = Offset(_left + (_width - lineWidth) / 2 + lineWidth, top);
      canvas.drawLine(p1, p2, paint);
    }
  }

  void _drawBorder(Canvas canvas, Paint paint) {
    paint.color = Colors.white;
    paint.strokeWidth = 2.5;
    paint.style = PaintingStyle.stroke;
    final double diameter = 2 * _outerRadius;
    Path path = Path();
    path.moveTo(_left + _outerRadius, _top);
    path.lineTo(_left + _width - _outerRadius, _top);
    path.arcTo(
        Rect.fromLTWH(_left + _width - diameter, _top, diameter, diameter),
        1.5 * pi,
        .5 * pi,
        false);
    path.lineTo(_left + _width, _top + _height - _outerRadius);
    path.arcTo(
        Rect.fromLTWH(_left + _width - diameter, _top + _height - diameter,
            diameter, diameter),
        0,
        .5 * pi,
        false);
    path.lineTo(_left + _outerRadius, _top + _height);
    path.arcTo(
        Rect.fromLTWH(_left, _top + _height - diameter, diameter, diameter),
        .5 * pi,
        .5 * pi,
        false);
    path.lineTo(_left, _top + _outerRadius);
    path.arcTo(
        Rect.fromLTWH(_left, _top, diameter, diameter), pi, .5 * pi, false);
    canvas.drawPath(path, paint);
  }

  bool _areImagesLoaded() {
    for (int i = 0; i < _images.length; i++)
      if (_images[i] == null) return false;
    return true;
  }

  void _drawXAxisLabel(int vehicleNo, Canvas canvas) {
    Paint paint = Paint();
    Offset c = Offset(_left + _width / (_titles.length + 1) * (vehicleNo + 1),
        _top + _height);
    paint.color = Colors.white;
    canvas.drawCircle(c, _outerRadius, paint);
    paint.color = Color(0xFF444444);
    canvas.drawCircle(c, _innerRadius, paint);
    if (_areImagesLoaded()) {
      final Size imageSize = Size(_images[vehicleNo].width.toDouble(),
          _images[vehicleNo].height.toDouble());
      final FittedSizes sizes =
          applyBoxFit(BoxFit.fill, imageSize, Size(_innerRadius, _innerRadius));
      final Rect inputSubrect =
          Alignment.center.inscribe(sizes.source, Offset.zero & imageSize);
      Rect r = Rect.fromLTWH(c.dx - (_innerRadius),
          _top + _height - _innerRadius, _innerRadius * 2, _innerRadius * 2);
      final Rect outputSubrect =
          Alignment.center.inscribe(sizes.destination, r);
      canvas.drawImageRect(
          _images[vehicleNo], inputSubrect, outputSubrect, paint);
    }
  }

  void _drawXAxisLabels(Canvas canvas) {
    if (_vehicle == Vehicle.ALL)
      for (int i = 0; i < _titles.length; i++) _drawXAxisLabel(i, canvas);
    else
      _drawXAxisLabel(_vehicleNo, canvas);
  }

  void _drawBar(int vehicleNo, Canvas canvas) {
    Paint paint = Paint();
    double left =
        _left + _width / (_points.length + 1) * (vehicleNo + 1) - _barWidth / 2;
    double height = (_height * _points[vehicleNo] / _strokes) * _t;
    double top = _top + _height - max(height - _outerRadius, 0.0);

    // Rect outerRect =
    //     Rect.fromLTWH(left, top, _barWidth, max(height - _outerRadius, 0));
    // paint.color = Colors.white;
    // canvas.drawRect(outerRect, paint);

    // draw outer circle
    // Offset c = Offset(left + _outerRadius, top);
    // canvas.drawCircle(c, _outerRadius, paint);
    // double innerBarWidth = _innerRadius * 2;
    // Rect innerRect = Rect.fromLTWH(left + (_barWidth - innerBarWidth) / 2, top,
    //     innerBarWidth, max(height - _innerRadius, 0));
    paint.color = _gradients[vehicleNo * 2];
    paint.shader = ui.Gradient.linear(
        Offset(left, top),
        Offset(left + _barWidth, top + height),
        [_gradients[vehicleNo * 2], _gradients[vehicleNo * 2 + 1]]);
    // canvas.drawRect(innerRect, paint);
    //draw Inner circle
    // canvas.drawCircle(c, _innerRadius, paint);

    Path path = Path();
    double portion = 1;
    path.moveTo(left - _outerRadius * portion, _top + _height);
    path.cubicTo(left + _outerRadius, _top + _height, left,
        _top + _height - height, left + _outerRadius, _top + _height - height);
    path.cubicTo(
        left + _outerRadius * 2,
        _top + _height - height,
        left + _outerRadius,
        _top + _height,
        left + _outerRadius * (2 + portion),
        _top + _height);
    paint.style = PaintingStyle.fill;
    path.lineTo(left - _outerRadius, _top + _height);
    canvas.drawPath(path, paint);

    paint = Paint();
    paint.color = Colors.white;
    paint.strokeWidth = 1.5;
    paint.style = PaintingStyle.stroke;
    canvas.drawPath(path, paint);

    // draw the magnitude of the bar on top of the bar.
    final double fontSize = min(_width, _height) / 4 * .2;
    ui.ParagraphBuilder pb;
    ui.ParagraphStyle ps;
    ui.ParagraphConstraints pc;
    ui.Paragraph par;
    paint = Paint();
    paint.color = Colors.white;

    ps = ui.ParagraphStyle(textAlign: TextAlign.center, fontSize: fontSize);
    pb = ui.ParagraphBuilder(ps);
    pb.pushStyle(ui.TextStyle(color: Colors.white));
    pb.addText("${(_points[vehicleNo] * _t).ceil()}");
    pc = ui.ParagraphConstraints(width: 100);
    par = pb.build();
    par.layout(pc);
    canvas.drawParagraph(par,
        Offset(left - (par.width - _barWidth) / 2, top - _outerRadius * 2));
  }

  _drawBarChart(Canvas canvas, Size size) {
    if (_vehicle == Vehicle.ALL)
      for (int i = 0; i < _titles.length; i++) _drawBar(i, canvas);
    else
      _drawBar(_vehicleNo, canvas);
  }

  @override
  void paint(Canvas canvas, Size size) {
    _left = size.width * 0;
    _top = size.height * 0;
    _width = size.width * 1;
    _height = size.height * 1;
    _outerRadius = min(size.width, size.height) * .066;
    _innerRadius = _outerRadius - 1.5;
    _barWidth = _outerRadius * 2;
    Paint paint = Paint();

    //draw the axes
    _drawBorder(canvas, paint);
    //draw the guiding lines on the graph
    _drawGuidingLines(canvas, size, paint);
    // draw the bar chart
    _drawBarChart(canvas, size);

    _drawXAxisLabels(canvas);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return true;
  }
}

enum Vehicle { CAR, BICYCLE, BUS, TRUCK, ALL }
