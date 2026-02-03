import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20), // Stronger "Frost" Blur
        child: Container(
          padding: padding ?? EdgeInsets.zero,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.12), // INCREASED VISIBILITY (from 0.08)
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: Colors.white.withOpacity(0.3), width: 2), // THICKER BORDER (from 1.5)
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.25), // STRONGER SHINE (from 0.15)
                Colors.white.withOpacity(0.05),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 15,
                spreadRadius: -2,
              )
            ],
          ),
          child: child,
        ),
      ).animate(onPlay: (controller) => controller.repeat(period: 4.seconds))
       .shimmer(duration: 2.seconds, color: Colors.white.withOpacity(0.1), angle: 0.5), // LIQUID SHIMMER
    );
  }
}
