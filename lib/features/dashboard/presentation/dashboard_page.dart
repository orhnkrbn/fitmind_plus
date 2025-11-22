// ignore_for_file: public_member_api_docs
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../app/theme.dart';
import '../../../../ui/fm_card.dart';
import '../../../../ui/fm_section_title.dart';
import '../../../../ui/fm_metric_tile.dart';
import '../../../../ui/fm_primary_button.dart';
import '../../../../ui/fm_scaffold.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  final List<bool> _metricsVisible = List.filled(3, false);
  final List<bool> _quickVisible = List.filled(3, false);
  final List<bool> _gridVisible = List.filled(4, false);

  @override
  void initState() {
    super.initState();
    // Staggered reveal
    for (var i = 0; i < _metricsVisible.length; i++) {
      Future.delayed(Duration(milliseconds: 100 * i), () {
        if (!mounted) return;
        setState(() => _metricsVisible[i] = true);
      });
    }
    for (var i = 0; i < _quickVisible.length; i++) {
      Future.delayed(Duration(milliseconds: 300 + 120 * i), () {
        if (!mounted) return;
        setState(() => _quickVisible[i] = true);
      });
    }
    for (var i = 0; i < _gridVisible.length; i++) {
      Future.delayed(Duration(milliseconds: 700 + 80 * i), () {
        if (!mounted) return;
        setState(() => _gridVisible[i] = true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FmScaffold(
      title: 'FitMind+',
      subtitle: 'Sağlıklı yaşam yolculuğunuz',
      body: _DashboardBody(),
    );
  }
}

class _DashboardBody extends ConsumerStatefulWidget {
  // use default constructor

  @override
  ConsumerState<_DashboardBody> createState() => _DashboardBodyState();
}

class _DashboardBodyState extends ConsumerState<_DashboardBody> {
  final List<bool> _metricsVisible = List.filled(3, false);
  final List<bool> _quickVisible = List.filled(3, false);
  final List<bool> _gridVisible = List.filled(4, false);

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < _metricsVisible.length; i++) {
      Future.delayed(Duration(milliseconds: 80 * i), () {
        if (!mounted) return;
        setState(() => _metricsVisible[i] = true);
      });
    }
    for (var i = 0; i < _quickVisible.length; i++) {
      Future.delayed(Duration(milliseconds: 260 + 100 * i), () {
        if (!mounted) return;
        setState(() => _quickVisible[i] = true);
      });
    }
    for (var i = 0; i < _gridVisible.length; i++) {
      Future.delayed(Duration(milliseconds: 520 + 90 * i), () {
        if (!mounted) return;
        setState(() => _gridVisible[i] = true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = AppTextStyles.textTheme(cs);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Merhaba,', style: textTheme.bodySmall),
                      const SizedBox(height: AppSpacing.xs),
                      Text('Orhan', style: textTheme.titleLarge),
                    ],
                  ),
                  const CircleAvatar(
                    radius: 20,
                    child: Text('O'),
                  )
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.sm),

            // Today's summary
            const FmSectionTitle(title: 'Bugünün Özeti'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(3, (i) {
                  final labels = ['Kalori', 'Adım', 'Antrenman'];
                  final values = ['1850', '7.500', 'Planlı'];
                  final units = ['kcal', 'adım', ''];
                  final tones = [MetricTone.success, MetricTone.normal, MetricTone.normal];
                  return Expanded(
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: _metricsVisible[i] ? 1 : 0,
                      child: AnimatedSlide(
                        offset: _metricsVisible[i] ? Offset.zero : const Offset(0, 0.03),
                        duration: const Duration(milliseconds: 300),
                        child: Padding(
                          padding: EdgeInsets.only(left: i == 0 ? 0 : AppSpacing.sm),
                          child: FmMetricTile(label: labels[i], value: values[i], unit: units[i], tone: tones[i]),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            // Quick actions
            const FmSectionTitle(title: 'Hızlı Eylemler'),
            SizedBox(
              height: 120,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...List.generate(3, (i) {
                      final titles = ['Bugünün Antrenmanı', 'Günlük Beslenme', 'Motivasyon Mesajı'];
                      final icons = [Icons.fitness_center, Icons.restaurant, Icons.emoji_emotions];
                      return Padding(
                        padding: const EdgeInsets.only(right: AppSpacing.sm),
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 320),
                          opacity: _quickVisible[i] ? 1 : 0,
                          child: AnimatedSlide(
                            offset: _quickVisible[i] ? Offset.zero : const Offset(0, 0.02),
                            duration: const Duration(milliseconds: 320),
                            child: SizedBox(
                              width: 220,
                              child: FmCard(
                                title: titles[i],
                                icon: icons[i],
                                onTap: () {
                                  final routes = ['/workouts', '/nutrition', '/motivation'];
                                  context.go(routes[i]);
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                    // AI Koç butonu
                    Padding(
                      padding: const EdgeInsets.only(right: AppSpacing.sm),
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 320),
                        opacity: _quickVisible.length > 2 ? (_quickVisible[2] ? 1 : 0) : 1,
                        child: AnimatedSlide(
                          offset: _quickVisible.length > 2 ? (_quickVisible[2] ? Offset.zero : const Offset(0, 0.02)) : Offset.zero,
                          duration: const Duration(milliseconds: 320),
                          child: SizedBox(
                            width: 220,
                            child: FmCard(
                              title: 'AI Koç',
                              subtitle: 'Yapay zeka destekli sohbet',
                              icon: Icons.smart_toy,
                              onTap: () {
                                context.go('/ai-chat');
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            // Modules grid
            const FmSectionTitle(title: 'Modüller'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
              child: LayoutBuilder(builder: (context, constraints) {
                final crossCount = constraints.maxWidth > 600 ? 4 : 2;
                return GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: crossCount,
                  crossAxisSpacing: AppSpacing.sm,
                  mainAxisSpacing: AppSpacing.sm,
                  children: List.generate(4, (i) {
                    final titles = ['Antrenman Planı', 'Beslenme Planı', 'Motivasyon', 'Kalori Tarayıcı'];
                    final icons = [Icons.fitness_center, Icons.restaurant, Icons.emoji_events, Icons.qr_code_scanner];
                    return AnimatedOpacity(
                      duration: const Duration(milliseconds: 340),
                      opacity: _gridVisible[i] ? 1 : 0,
                      child: AnimatedSlide(
                        offset: _gridVisible[i] ? Offset.zero : const Offset(0, 0.03),
                        duration: const Duration(milliseconds: 340),
                        child: FmCard(
                          title: titles[i],
                          icon: icons[i],
                          onTap: () {
                            final routes = ['/workout', '/nutrition-new', '/motivation', '/scanner'];
                            context.go(routes[i]);
                          },
                        ),
                      ),
                    );
                  }),
                );
              }),
            ),

            const SizedBox(height: AppSpacing.lg),

            // CTA
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: FmPrimaryButton(label: 'Hedefini Güncelle', icon: Icons.edit, onPressed: () => context.go('/profile')),
            ),

            const SizedBox(height: AppSpacing.lg),
          ],
        ),
      ),
    );
  }
}

