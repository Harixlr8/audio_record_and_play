
import 'dart:math';
import 'package:flutter/material.dart';

class WaveEffect extends StatelessWidget {
  final Animation<double> animation;
  final Color color;

  const WaveEffect({super.key, required this.animation, required this.color});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return CustomPaint(
          painter: WavePainter(progress: animation.value, color: color),
          size: Size(200, 200),
        );
      },
    );
  }
}

class WavePainter extends CustomPainter {
  final double progress;
  final Color color;

  WavePainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width / 2;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;

    for (int i = 0; i < 3; i++) {
      final radius = maxRadius * (progress + i * 0.2);
      final opacity = 1.0 - (progress + i * 0.2);

      if (radius <= maxRadius) {
        paint.color = color.withOpacity(opacity.clamp(0.0, 1.0));

        final path = Path();
        for (double angle = 0; angle <= 360; angle += 5) {
          final radians = angle * (3.14 / 180);
          final x = center.dx + radius * cos(radians);
          final y = center.dy + radius * sin(radians) * (1 + 0.2 * sin(radians * 4 + progress * 2 * 3.14));
          if (angle == 0) {
            path.moveTo(x, y);
          } else {
            path.lineTo(x, y);
          }
        }
        path.close();
        canvas.drawPath(path, paint);
      }
    }
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}