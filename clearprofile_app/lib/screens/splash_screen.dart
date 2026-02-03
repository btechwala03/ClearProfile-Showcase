import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme.dart';
import '../components/glass_card.dart';
import '../components/animated_bg.dart'; // NEW

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () { // Extended slightly for animation
      if (mounted) {
        context.go('/landing');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          // 1. Tech Background for Depth
          const Positioned.fill(child: AnimatedTechBackground()),

          // 2. Main Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // GLASS LOGO CONTAINER
                GlassCard(
                  padding: const EdgeInsets.all(24),
                  child: Image.asset(
                    'assets/images/logo.png', // Original Logo
                    width: 100,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                )
                .animate()
                .scale(
                  begin: const Offset(0.5, 0.5),
                  end: const Offset(1.0, 1.0),
                  duration: 1200.ms,
                  curve: Curves.elasticOut, // Bouncy "Pop" entrance
                )
                .fadeIn(duration: 800.ms)
                .shimmer(delay: 1000.ms, duration: 1500.ms, color: Colors.white.withOpacity(0.2)), // Extra initial shine

                const SizedBox(height: 40),

                Text(
                  'ClearProfile',
                  style: context.textStyles.displaySmall?.semiBold.withColor(Colors.white),
                ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.5, end: 0, curve: Curves.easeOutQuad),

                const SizedBox(height: 16),

                Container(
                  width: 120,
                  height: 2, // Slightly thicker
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(1),
                    boxShadow: [
                      BoxShadow(color: AppColors.accent.withOpacity(0.5), blurRadius: 8) // Glowing line
                    ]
                  ),
                )
                .animate()
                .scaleX(begin: 0, end: 1, duration: 800.ms, delay: 800.ms, curve: Curves.easeInOut),

                const SizedBox(height: 16),

                Text(
                  'AI-powered digital footprint auditing.',
                  style: context.textStyles.bodyMedium?.withColor(AppColors.onSurfaceVariant),
                ).animate().fadeIn(delay: 1000.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
