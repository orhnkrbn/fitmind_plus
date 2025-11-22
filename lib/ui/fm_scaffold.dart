import 'package:flutter/material.dart';
import '../app/theme.dart';

class FmScaffold extends StatelessWidget {
  const FmScaffold({
    super.key,
    this.body,
    this.floatingAction,
    this.extendBody = false,
    this.title,
    this.subtitle,
    this.bottom,
  });

  final Widget? body;
  final Widget? floatingAction;
  final bool extendBody;
  final String? title;
  final String? subtitle;
  final Widget? bottom;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final theme = Theme.of(context);

    // Premium gradient background
    final scaffold = Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: extendBody,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF050816), // AppColors.darkBg
              Color(0xFF080C1F), // Slightly lighter variant
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Custom header with title and subtitle
              if (title != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    AppSpacing.sm,
                    AppSpacing.md,
                    AppSpacing.md,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title!,
                        style: theme.textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: cs.onSurface,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          subtitle!,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: cs.onSurface.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              
              // Main content
              Expanded(
                child: body ?? const SizedBox.shrink(),
              ),
              
              // Bottom widget (e.g., action buttons)
              if (bottom != null) bottom!,
            ],
          ),
        ),
      ),
      floatingActionButton: floatingAction,
    );

    return scaffold;
  }
}
