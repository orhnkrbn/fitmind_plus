import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitmind_plus_ultra_22/features/motivation/repositories/motivation_repository.dart';

class MotivationPage extends ConsumerStatefulWidget {
  const MotivationPage({super.key});

  @override
  ConsumerState<MotivationPage> createState() => _MotivationPageState();
}

class _MotivationPageState extends ConsumerState<MotivationPage> {
  final MotivationRepository _repo = MockMotivationRepository();
  List<String> _suggestions = [];
  String? _dailyGoal;

  @override
  void initState() {
    super.initState();
    _loadSuggestions();
  }

  Future<void> _loadSuggestions() async {
    final s = await _repo.fetchSuggestions();
    if (mounted) setState(() => _suggestions = s);
  }

  Future<void> _setDailyGoal() async {
    final ctrl = TextEditingController(text: _dailyGoal ?? '');
    final res = await showDialog<String?>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Günlük mini hedef belirle'),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Örn: 10 dakika meditasyon',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(null),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(ctrl.text.trim()),
            child: const Text('Kaydet'),
          ),
        ],
      ),
    );

    if (res != null && mounted) {
      setState(() => _dailyGoal = res);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Günlük hedef kaydedildi: $res')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Motivasyon')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Öneriler',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 12),

              Expanded(
                child: ListView.separated(
                  itemCount: _suggestions.isNotEmpty ? _suggestions.length : 3,
                  separatorBuilder: (context, index) => const SizedBox(height: 8),
                  itemBuilder: (ctx, i) {
                    final text = _suggestions.isNotEmpty
                        ? _suggestions[i]
                        : 'Yükleniyor...';
                    return Card(
                      key: ValueKey('motivation_card_$i'),
                      child: ListTile(
                        leading: const Icon(Icons.lightbulb_outline),
                        title: Text(text),
                        subtitle: const Text('Motivasyon önerisi'),
                        onTap: () {},
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 12),
              if (_dailyGoal != null)
                Text(
                  'Günlük hedef: $_dailyGoal',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  key: const Key('set_daily_goal_btn'),
                  icon: const Icon(Icons.flag),
                  label: const Text('Günlük mini hedef belirle'),
                  onPressed: _setDailyGoal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
