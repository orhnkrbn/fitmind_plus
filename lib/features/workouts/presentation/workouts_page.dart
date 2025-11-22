// ignore_for_file: public_member_api_docs
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fitmind_plus_ultra_22/core/services/ai/ai_service_mock.dart';
import '../../../app/theme.dart';
import 'package:go_router/go_router.dart';
import 'package:fitmind_plus_ultra_22/ui/fm_card.dart';
import 'package:fitmind_plus_ultra_22/ui/fm_section_title.dart';
import 'package:fitmind_plus_ultra_22/ui/fm_primary_button.dart';
import 'package:fitmind_plus_ultra_22/ui/fm_scaffold.dart';
import '../../workouts/data/workouts_repository.dart';

class WorkoutsPage extends ConsumerStatefulWidget {
  const WorkoutsPage({super.key});

  @override
  ConsumerState<WorkoutsPage> createState() => _WorkoutsPageState();
}

class _WorkoutsPageState extends ConsumerState<WorkoutsPage> {
  String? _suggestion;
  bool _loading = false;

  Future<void> _getSuggestion() async {
    setState(() {
      _loading = true;
      _suggestion = null;
    });
    const svc = MockAIService();
    final res = await svc.suggestPlan(goal: 'fatloss', weeklyDays: 3, experienceLevel: 1);
    setState(() {
      _suggestion = res;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final planAsync = ref.watch(weeklyWorkoutPlanProvider('fatloss'));

    
    return FmScaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const FmSectionTitle(title: 'Antrenman Planı'),
          const SizedBox(height: AppSpacing.sm),

          // Today's plan & AI suggestion
          Row(children: [
            Expanded(child: FmPrimaryButton(label: 'AI Önerisi Al', onPressed: _loading ? null : _getSuggestion, icon: Icons.smart_toy)),
            const SizedBox(width: AppSpacing.sm),
            if (_loading) const SizedBox(width: 40, height: 40, child: Center(child: CircularProgressIndicator())),
          ]),
          const SizedBox(height: AppSpacing.md),
          if (_suggestion != null) FmCard(title: 'AI Önerisi', child: Padding(padding: const EdgeInsets.only(top: AppSpacing.sm), child: Text(_suggestion!))),

          const SizedBox(height: AppSpacing.md),

          // Weekly plan
          Expanded(
            child: planAsync.when(
              data: (days) {
                if (days.isEmpty) return const Center(child: Text('Plan bulunamadı.'));
                return ListView.separated(
                  itemCount: days.length,
                  separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (context, i) {
                    final wd = days[i];
                    return FmCard(
                      title: wd.day,
                      subtitle: '${wd.exercises.length} egzersiz • ${wd.exercises.map((e) => e.name).take(2).join(', ')}',
                      onTap: () => context.go('/workouts'),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Center(child: FmCard(child: Column(children: [const Text('Hata yüklenirken'), const SizedBox(height: AppSpacing.sm), FmPrimaryButton(label: 'Tekrar Dene', onPressed: () => ref.refresh(weeklyWorkoutPlanProvider('fatloss')))]))),
            ),
          ),
        ]),
      ),
    );
  }
}

