import 'package:flutter/material.dart';
import 'dart:math' as math;

// ignore: camel_case_types
class paintShape extends StatefulWidget {
  const paintShape({Key? key,}) : super(key: key);
  @override
  State<paintShape> createState() => paintShapeState();
}

// ignore: camel_case_types
class paintShapeState extends State<paintShape> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Expanded(
        child: CustomPaint(
      painter: polygonPainter(8),
        )),
      ),
    );
  }
}

// ignore: camel_case_types
class polygonPainter extends CustomPainter {
  final int numberOfSides;
  polygonPainter(this.numberOfSides);
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final paint = Paint()
      ..strokeWidth = 10
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    var Size = 100,
        Xcenter = center.dx,
        Ycenter = center.dy;



    for (var i = 0; i <= numberOfSides;i += 1) {
      if(i==0){
        path.moveTo(Xcenter + Size * math.cos(i * 2 * math.pi / numberOfSides), Ycenter + Size * math.sin(i * 2 * math.pi / numberOfSides));
      }else{
        path.lineTo (Xcenter + Size * math.cos(i * 2 * math.pi / numberOfSides),
            Ycenter + Size * math.sin(i * 2 * math.pi / numberOfSides));
      }
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
