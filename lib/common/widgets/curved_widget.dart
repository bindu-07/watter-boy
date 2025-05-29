import 'package:flutter/cupertino.dart';

class TCustomCurvedEdge extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);

    final firstCurve = Offset(0, size.height - 20);
    final lastCurve = Offset(30, size.height - 20);
    path.quadraticBezierTo(
        firstCurve.dx, firstCurve.dy, lastCurve.dx, lastCurve.dy);

    final firstCurve1 = Offset(0, size.height - 20);
    final lastCurve1 = Offset(size.width - 30, size.height - 20);
    path.quadraticBezierTo(
        firstCurve1.dx, firstCurve1.dy, lastCurve1.dx, lastCurve1.dy);

    final firstCurve2 = Offset(size.width, size.height - 20);
    final lastCurve2 = Offset(size.width, size.height);
    path.quadraticBezierTo(
        firstCurve2.dx, firstCurve2.dy, lastCurve2.dx, lastCurve2.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
