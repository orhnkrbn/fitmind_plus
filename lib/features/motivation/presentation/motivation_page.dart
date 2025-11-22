// ignore_for_file: public_member_api_docs
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fitmind_plus_ultra_22/core/services/ai/ai_service_mock.dart';
import 'package:fitmind_plus_ultra_22/app/theme.dart';
import 'package:fitmind_plus_ultra_22/ui/fm_card.dart';
import 'package:fitmind_plus_ultra_22/ui/fm_section_title.dart';
import 'package:fitmind_plus_ultra_22/ui/fm_primary_button.dart';
import 'package:fitmind_plus_ultra_22/ui/fm_scaffold.dart';
import '../data/motivation_repository.dart';

class MotivationPage extends ConsumerStatefulWidget {
  const MotivationPage({super.key});

  @override
  ConsumerState<MotivationPage> createState() => _MotivationPageState();
}

class _MotivationPageState extends ConsumerState<MotivationPage> {
  String _mood = 'neutral';
  String? _message;
  bool _loading = false;

  Future<void> _gen() async {
    setState(() {
      _loading = true;
      _message = null;
    });
    const svc = MockAIService();
    final res = await svc.dailyMotivation(mood: _mood);
    setState(() {
      _message = res;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final quoteAsync = ref.watch(randomQuoteProvider(_mood));
    const goal = 'fatloss';
    const focus = goal == 'fatloss' ? 'NEAT artır' : (goal == 'muscle' ? 'Protein hedefi yüksek tut' : 'Hedefe odaklan');

    return FmScaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const FmSectionTitle(title: 'Motivasyon'),
          const SizedBox(height: AppSpacing.sm),

          const FmSectionTitle(title: 'Modunu Seç'),
          DropdownButtonFormField<String>(
            initialValue: _mood,
            decoration: const InputDecoration(labelText: 'Mod'),
            items: const [
              DropdownMenuItem(value: 'low', child: Text('Low')),
              DropdownMenuItem(value: 'neutral', child: Text('Neutral')),
              DropdownMenuItem(value: 'high', child: Text('High')),
            ],
            onChanged: (v) => setState(() => _mood = v ?? 'neutral'),
          ),

          const SizedBox(height: AppSpacing.md),
          FmPrimaryButton(label: 'AI Motivasyon Mesajı', onPressed: _loading ? null : _gen, icon: Icons.auto_awesome),
          const SizedBox(height: AppSpacing.sm),
          if (_loading) const Center(child: CircularProgressIndicator()),
          if (_message != null) Padding(padding: const EdgeInsets.only(top: AppSpacing.sm), child: FmCard(title: 'Senin Mesajn', child: Padding(padding: const EdgeInsets.all(AppSpacing.sm), child: Text(_message!)))),

          const SizedBox(height: AppSpacing.md),
          const FmSectionTitle(title: 'Ek İlham'),
          quoteAsync.when(
            data: (q) => Padding(padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md), child: FmCard(child: Padding(padding: const EdgeInsets.all(AppSpacing.sm), child: Text(q)))),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, st) => Center(child: FmCard(child: Column(mainAxisSize: MainAxisSize.min, children: [const Text('Hata alındı'), const SizedBox(height: AppSpacing.sm), FmPrimaryButton(label: 'Tekrar Dene', onPressed: () => ref.refresh(randomQuoteProvider(_mood)))]))),
          ),

          const SizedBox(height: AppSpacing.md),
          const Padding(padding: EdgeInsets.symmetric(horizontal: AppSpacing.md), child: Text('Bugünün odağı: $focus')),
        ]),
      ),
    );
  }
}

