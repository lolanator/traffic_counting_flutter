import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:math';

class GraphPainter extends CustomPainter {
  List<Offset> _points;
  List<ui.Image> _images;
  List<Color> _vehicleColors = <Color>[Colors.red, Colors.orange, Colors.green];
  double _left,
      _top,
      _width,
      _height,
      _outerRadius,
      _innerRadius,
      _barWidth,
      _t;
  int _strokes;
  Vehicle _vehicleNo;
  List<String> _titles = <String>["Cars", "Bicycles", "Buses"];

  GraphPainter.drawBarChart(
      this._points, this._strokes, this._t, this._vehicleNo, this._images);

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

  void _drawAxes(Canvas canvas, Paint paint) {
    paint.color = Colors.white;
    paint.strokeWidth = 2.5;
    canvas.drawLine(Offset(_left, _top), Offset(_left, _top + _height), paint);
    canvas.drawLine(Offset(_left, _top + _height),
        Offset(_left + _width, _top + _height), paint);
  }

  void _drawNumbers(Canvas canvas, Paint paint, double offset) {
    final double fontSize = _width / 4 * .2;
    ui.ParagraphBuilder pb;
    ui.ParagraphStyle ps;
    ui.ParagraphConstraints pc;
    ui.Paragraph par;
    Offset off;
    paint.color = Colors.white;
    //draw the vertical numbers
    for (int i = 0; i < _strokes; i += 2) {
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

    var drawXAxisLabels = (int vehicleNo) {
      Offset c = Offset(_left + _width / (_titles.length + 1) * (vehicleNo + 1),
          _top + _height);
      canvas.drawCircle(c, _outerRadius, paint);
      paint.color = Color(0xFF444444);
      canvas.drawCircle(c, _innerRadius, paint);
      paint.color = Colors.white;
      if (_images.length > 0) {
        final Size imageSize = Size(_images[vehicleNo].width.toDouble(),
            _images[vehicleNo].height.toDouble());
        BoxFit fit = BoxFit.fill;
        final FittedSizes sizes =
            applyBoxFit(fit, imageSize, Size(_innerRadius, _innerRadius));
        final Rect inputSubrect =
            Alignment.center.inscribe(sizes.source, Offset.zero & imageSize);
        Rect r = Rect.fromLTWH(c.dx - (_innerRadius),
            _top + _height - _innerRadius, _innerRadius * 2, _innerRadius * 2);
        final Rect outputSubrect =
            Alignment.center.inscribe(sizes.destination, r);
        canvas.drawImageRect(
            _images[vehicleNo], inputSubrect, outputSubrect, paint);
      }
    };
    int vehicleNo;
    switch (_vehicleNo) {
      case Vehicle.CAR:
        vehicleNo = 0;
        break;
      case Vehicle.BICYCLE:
        vehicleNo = 1;
        break;
      case Vehicle.BUS:
        vehicleNo = 2;
        break;
      case Vehicle.ALL:
        for (int i = 0; i < _titles.length; i++) drawXAxisLabels(i);
        return;
    }
    drawXAxisLabels(vehicleNo);
  }

  _drawBarChart(Canvas canvas, Size size, Paint paint) {
    paint.color = Colors.white;
    int vehicleNo;

    var drawBar = (int vehicleNo) {
      double left = _left +
          _width / (_points.length + 1) * (vehicleNo + 1) -
          _barWidth / 2;
      double height = (_height * _points[vehicleNo].dy / _strokes) * _t;
      double top = _top + _height - max(height - _outerRadius, 0.0);

      Rect outerRect =
          Rect.fromLTWH(left, top, _barWidth, max(height - _outerRadius, 0));
      paint.color = Colors.white;
      canvas.drawRect(outerRect, paint);

      Offset c = Offset(left + _outerRadius, top);
      paint.color = Colors.white;
      canvas.drawCircle(c, _outerRadius, paint);

      double innerBarWidth = _innerRadius * 2;
      Rect innerRect = Rect.fromLTWH(left + (_barWidth - innerBarWidth) / 2,
          top, innerBarWidth, max(height - _innerRadius, 0));
      paint.color = _vehicleColors[vehicleNo];
      canvas.drawRect(innerRect, paint);

      canvas.drawCircle(c, _innerRadius, paint);
    };
    switch (_vehicleNo) {
      case Vehicle.CAR:
        vehicleNo = 0;
        break;
      case Vehicle.BICYCLE:
        vehicleNo = 1;
        break;
      case Vehicle.BUS:
        vehicleNo = 2;
        break;
      case Vehicle.ALL:
        for (int i = 0; i < _points.length; i++) drawBar(i);
        return;
    }
    drawBar(vehicleNo);
  }

  @override
  void paint(Canvas canvas, Size size) {
    _left = size.width * .1;
    _top = size.height * .1;
    _width = size.width * .9;
    _height = size.height * .8;
    _outerRadius = size.width * .075;
    _innerRadius = _outerRadius - 1;
    _barWidth = _outerRadius * 2;
    Paint paint = Paint();

    //draw the axes
    _drawAxes(canvas, paint);

    //draw the numbers on the axes

    //draw the guiding lines on the graph
    _drawGuidingLines(canvas, size, paint);

    // draw the bar chart
    _drawBarChart(canvas, size, paint);

    // draw the numbers and x-axis labels on the chart
    final double offset = 15;
    _drawNumbers(canvas, paint, offset);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return true;
  }
}

enum Vehicle { CAR, BICYCLE, BUS, ALL }
