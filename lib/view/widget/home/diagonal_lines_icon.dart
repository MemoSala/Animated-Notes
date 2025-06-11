import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiagonalLinesIcon extends StatelessWidget {
  const DiagonalLinesIcon({super.key, this.size = 20, this.color});
  final double size;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _DiagonalLinesPainter(color: color),
    );
  }
}

class _DiagonalLinesPainter extends CustomPainter {
  const _DiagonalLinesPainter({required this.color});
  final Color? color;
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paintBack = Paint()
      ..color = color ?? Get.theme.colorScheme.primary.withAlpha(127)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width, -size.height * .1);
    path.lineTo(-size.width * .1, size.height);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paintBack);

    final Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = size.width / 11
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(size.height - size.height * .10, size.width * .25),
      Offset(size.height * 0.25, size.width - size.width * .10),
      paint,
    );
    canvas.drawLine(
      Offset(size.height - size.height * .10, size.width * .5),
      Offset(size.height * .5, size.width - size.width * .10),
      paint,
    );
    canvas.drawLine(
      Offset(size.height - size.height * .10, size.width * .75),
      Offset(size.height * .75, size.width - size.width * .10),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
