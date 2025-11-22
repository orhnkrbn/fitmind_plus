// ignore_for_file: public_member_api_docs
import 'package:flutter/material.dart';
import '../app/theme.dart';

class FmCard extends StatelessWidget {
  const FmCard({
    super.key,
    this.title,
    this.subtitle,
    this.icon,
    this.child,
    this.onTap,
    this.height,
    this.padding,
  });

  final String? title;
  final String? subtitle;
  final IconData? icon;
  final Widget? child;
  final VoidCallback? onTap;
  final double? height;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = AppTextStyles.textTheme(cs);

    final content = <Widget>[];
    if (title != null) {
      content.add(Text(title!, style: textTheme.titleLarge));
    }
    if (subtitle != null) {
      content.add(const SizedBox(height: AppSpacing.xs));
      // Avoid withOpacity (deprecated); use withAlpha equivalent (0.7 -> 179)
      content.add(Text(subtitle!, style: textTheme.bodyMedium?.copyWith(color: cs.onSurface.withAlpha(179))));
    }
    if (child != null) {
      if (content.isNotEmpty) content.add(const SizedBox(height: AppSpacing.sm));
      content.add(child!);
    }

    final card = Container(
      height: height,
      padding: padding ?? const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(AppRadius.cardRadius),
        boxShadow: [
          BoxShadow(color: AppColors.shadowColor(cs.brightness == Brightness.dark), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (icon != null)
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.md),
            child: Icon(icon, size: 28, color: cs.primary),
          ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: content,
          ),
        ),
        if (onTap != null)
          const Padding(
            padding: EdgeInsets.only(left: AppSpacing.sm),
            child: Icon(Icons.chevron_right),
          ),
      ]),
    );

    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.cardRadius),
          onTap: onTap,
          child: card,
        ),
      );
    }

    return card;
  }
}
