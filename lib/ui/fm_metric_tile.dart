import 'package:flutter/material.dart';
import '../app/theme.dart';

enum MetricTone { normal, success, warning, danger }

class FmMetricTile extends StatelessWidget {
  const FmMetricTile({super.key, required this.label, required this.value, this.unit, this.tone = MetricTone.normal});

  final String label;
  final String value;
  final String? unit;
  final MetricTone tone;

  Color _toneColor(ColorScheme cs) {
    switch (tone) {
      case MetricTone.success:
        return Colors.green;
      case MetricTone.warning:
        return Colors.orange;
      case MetricTone.danger:
        return Colors.red;
      case MetricTone.normal:
        return cs.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = AppTextStyles.textTheme(cs);
    final toneColor = _toneColor(cs);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(AppRadius.cardRadius),
        boxShadow: [BoxShadow(color: AppColors.shadowColor(cs.brightness == Brightness.dark), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: textTheme.bodySmall),
          const SizedBox(height: AppSpacing.xs),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(value, style: textTheme.titleLarge?.copyWith(color: toneColor)),
              if (unit != null) ...[
                const SizedBox(width: AppSpacing.xs),
                Text(unit!, style: textTheme.bodySmall),
              ]
            ],
          )
        ],
      ),
    );
  }
}
