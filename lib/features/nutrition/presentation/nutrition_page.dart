// ignore_for_file: public_member_api_docs, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fitmind_plus_ultra_22/app/theme.dart';
import 'package:fitmind_plus_ultra_22/ui/fm_card.dart';
import 'package:fitmind_plus_ultra_22/ui/fm_section_title.dart';
import 'package:fitmind_plus_ultra_22/ui/fm_metric_tile.dart';
import 'package:fitmind_plus_ultra_22/ui/fm_primary_button.dart';
import 'package:fitmind_plus_ultra_22/ui/fm_scaffold.dart';
import '../data/nutrition_repository.dart';

class NutritionPage extends ConsumerStatefulWidget {
  const NutritionPage({super.key});

  @override
  ConsumerState<NutritionPage> createState() => _NutritionPageState();
}

class _NutritionPageState extends ConsumerState<NutritionPage> {
  final _ctrl = TextEditingController();
  final List<String> _items = [];

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _add() {
    final text = _ctrl.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _items.insert(0, text);
      _ctrl.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final planAsync = ref.watch(weeklyMealPlanProvider('fatloss'));

    return FmScaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const FmSectionTitle(title: 'Beslenme Planı'),
          const SizedBox(height: AppSpacing.sm),

          // Quick add
          Row(children: [
            Expanded(child: TextField(controller: _ctrl, decoration: const InputDecoration(hintText: 'Besin / Not'))),
            const SizedBox(width: AppSpacing.sm),
            FmPrimaryButton(label: 'Ekle', onPressed: _add, icon: Icons.add),
          ]),

          const SizedBox(height: AppSpacing.md),

          // Meals and weekly summary
          planAsync.when(
            data: (plan) {
              if (plan.days.isEmpty) return const Expanded(child: Center(child: Text('Plan bulunamadı')));

              final idx = (DateTime.now().weekday - 1) % plan.days.length;
              final today = plan.days[idx];
              final totals = today.dailyTotals();

              return Expanded(
                child: ListView(children: [
                  // Today's meals
                  FmCard(
                    title: 'Bugün',
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      ListTile(leading: const Icon(Icons.breakfast_dining), title: Text('Kahvaltı'), subtitle: Text('${today.breakfast.kcal} kcal')),
                      ListTile(leading: const Icon(Icons.lunch_dining), title: Text('Öğle'), subtitle: Text('${today.lunch.kcal} kcal')),
                      ListTile(leading: const Icon(Icons.dinner_dining), title: Text('Akşam'), subtitle: Text('${today.dinner.kcal} kcal')),
                      if (today.snacks.isNotEmpty) const Divider(),
                      if (today.snacks.isNotEmpty) ...today.snacks.map((s) => ListTile(leading: const Icon(Icons.fastfood), title: Text(s.name), subtitle: Text('${s.kcal} kcal'))),
                      const SizedBox(height: AppSpacing.sm),
                      Text('Toplam: ${totals['kcal']?.toStringAsFixed(0)} kcal'),
                    ]),
                  ),

                  const SizedBox(height: AppSpacing.md),

                  // Weekly summary using metric tiles
                  const FmSectionTitle(title: 'Haftalık Özet'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Expanded(child: FmMetricTile(label: 'Toplam Kcal', value: (plan.days.fold<double>(0, (p, e) => p + (e.dailyTotals()['kcal'] ?? 0))).toStringAsFixed(0), unit: 'kcal')),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(child: FmMetricTile(label: 'Ortalama Protein', value: (plan.days.fold<double>(0, (p, e) => p + (e.dailyTotals()['p'] ?? 0)) / plan.days.length).toStringAsFixed(0), unit: 'g')),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(child: FmMetricTile(label: 'Ortalama Karb', value: (plan.days.fold<double>(0, (p, e) => p + (e.dailyTotals()['c'] ?? 0)) / plan.days.length).toStringAsFixed(0), unit: 'g')),
                    ]),
                  ),

                  const SizedBox(height: AppSpacing.md),

                  // Notes / manual items
                  FmCard(
                    title: 'Notlarım',
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      const SizedBox(height: AppSpacing.xs),
                      ..._items.map((it) => ListTile(title: Text(it))),
                      if (_items.isEmpty) const Padding(padding: EdgeInsets.all(AppSpacing.sm), child: Text('Henüz not eklemediniz')),
                    ]),
                  ),
                ]),
              );
            },
            loading: () => const Expanded(child: Center(child: CircularProgressIndicator())),
            error: (e, st) => Expanded(child: Center(child: FmCard(child: Column(mainAxisSize: MainAxisSize.min, children: [const Text('Hata'), const SizedBox(height: AppSpacing.sm), FmPrimaryButton(label: 'Tekrar Dene', onPressed: () => ref.refresh(weeklyMealPlanProvider('fatloss')))])))),
          ),
        ]),
      ),
    );
  }
}

