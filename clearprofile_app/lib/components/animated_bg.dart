import 'package:flutter/material.dart';
import '../theme.dart';

class AnimatedTechBackground extends StatefulWidget {
  const AnimatedTechBackground({super.key});

  @override
  State<AnimatedTechBackground> createState() => _AnimatedTechBackgroundState();
}

class _AnimatedTechBackgroundState extends State<AnimatedTechBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _TechGridPainter(_controller),
      child: Container(),
    );
  }
}

class _TechGridPainter extends CustomPainter {
  final Animation<double> animation;

  _TechGridPainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.accent.withOpacity(0.2) // VISIBLE Grid (was 0.05)
      ..strokeWidth = 1;

    final double gridSize = 40;
    
    // Draw Grid (Restored logic from previous context assumption)
    for (double x = 0; x < size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += gridSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    // Draw Scouting Line
    final scanPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.transparent,
          AppColors.accent.withOpacity(0.5), // BRIGHTER SCANNER (was 0.2)
          AppColors.accent.withOpacity(0.0),
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    double scanY = animation.value * size.height;
    
    canvas.drawRect(
      Rect.fromLTWH(0, scanY - 50, size.width, 100),
      scanPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
