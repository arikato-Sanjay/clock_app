import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class ClockDesign extends StatefulWidget {
  final double size;
  const ClockDesign({Key key, this.size}) : super(key: key);

  @override
  _ClockDesignState createState() => _ClockDesignState();
}

class _ClockDesignState extends State<ClockDesign> {

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if(!mounted) return;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size ,
      child: Transform.rotate(
        angle: - pi/2,
        child: CustomPaint(
          painter: ClockPainting(),
        ),
      ),
    );
  }
}

class ClockPainting extends CustomPainter {
  var dateTime = DateTime.now();

  //60 sec = 360 deg, 1 sec = 6 deg
  //

  @override
  void paint(Canvas canvas, Size size) {
      var centerX = size.width / 2;
      var centerY = size.height / 2;
      var center = Offset(centerX, centerY);
      var radius = min(centerX,centerY);

      var brushing = Paint()
      ..color = Color(0xFF9FA4C4);

      var outlineBrushing = Paint()
      ..color = Colors.white
      ..strokeWidth = size.width / 20
      ..style = PaintingStyle.stroke;

      var innerBrushing = Paint()
        ..color = Colors.white;

      var secHand = Paint()
        ..color = Colors.orange
        ..strokeWidth = size.width / 60
        ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

      var minHand = Paint()
        ..color = Colors.green
        ..strokeWidth = size.width / 30
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

      var hourHand = Paint()
        ..color = Colors.red
        ..strokeWidth = size.width / 24
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

      canvas.drawCircle(center, radius*0.75, brushing);
      canvas.drawCircle(center, radius*0.75, outlineBrushing);

      var secHandX = centerX + radius*0.6 * cos(dateTime.second * 6 * pi/180);
      var secHandY = centerX + radius*0.6 * sin(dateTime.second * 6 * pi/180);
      canvas.drawLine(center, Offset(secHandX,secHandY), secHand);

      var minHandX = centerX + radius*0.6 * cos(dateTime.minute * 6 * pi/180);
      var minHandY = centerX + radius*0.6 * sin(dateTime.minute * 6 * pi/180);
      canvas.drawLine(center, Offset(minHandX,minHandY), minHand);

      var hourHandX = centerX + radius*0.4 * cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi/180);
      var hourHandY = centerX + radius*0.4 * sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi/180);
      canvas.drawLine(center, Offset(hourHandX,hourHandY), hourHand);

      canvas.drawCircle(center, radius*0.12, innerBrushing);

      var dashBrush = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

      var outerCircle = radius - 8 ;
      var innerCircle = radius - 15;
      for(double i=0; i<360; i+=6){
        var x1 = centerX + outerCircle * cos(i * pi/180);
        var y1 = centerX + outerCircle * sin(i * pi/180);

        var x2 = centerX + innerCircle * cos(i * pi/180);
        var y2 = centerX + innerCircle * sin(i * pi/180);
        canvas.drawLine(Offset(x1,y1), Offset(x2,y2), dashBrush);
      }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}
