import 'package:flutter/material.dart';
import '../app/theme.dart';

class FmSectionTitle extends StatelessWidget {
  const FmSectionTitle({super.key, required this.title, this.action});

  final String title;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = AppTextStyles.textTheme(cs);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm, horizontal: AppSpacing.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: textTheme.titleLarge),
          if (action != null) action!,
        ],
      ),
    );
  }
}
