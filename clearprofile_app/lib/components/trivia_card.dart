import 'package:flutter/material.dart';
import '../theme.dart';

class TriviaCard extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;

  const TriviaCard({
    super.key,
    required this.title,
    required this.content,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground.withOpacity(0.8),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: AppColors.accent),
              const SizedBox(width: 8),
              Text(
                title,
                style: context.textStyles.labelSmall?.bold.withColor(AppColors.onSurface),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: context.textStyles.bodySmall?.withColor(AppColors.onSurfaceVariant),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
