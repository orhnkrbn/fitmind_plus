import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fitmind_plus_ultra_22/features/home/providers/daily_quote_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);
    // start after a short delay for a pleasant effect
    Future.delayed(const Duration(milliseconds: 120), () => _ctrl.forward());
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Widget _shortcutCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    String? semanticsLabel,
    Key? key,
  }) {
    return Card(
      key: key,
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, semanticLabel: semanticsLabel),
        title: Text(label),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final quote = ref.watch(dailyQuoteProvider(null));
    final mq = MediaQuery.of(context);
    final isSmall = mq.size.width < 380;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isSmall ? 12 : 20,
            vertical: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Semantics(
                label: 'Hoş geldin başlığı',
                header: true,
                child: Text(
                  'Hedeflerine hoş geldin!',
                  key: const Key('home_greeting'),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              FadeTransition(
                opacity: _fade,
                child: Semantics(
                  label: 'Günün motivasyon cümlesi',
                  child: Card(
                    key: const Key('daily_quote_card'),
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        quote,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // Shortcuts
              Semantics(
                container: true,
                child: Column(
                  children: [
                    _shortcutCard(
                      key: const Key('shortcut_workouts'),
                      icon: Icons.fitness_center_outlined,
                      label: 'Antrenman',
                      semanticsLabel: 'Antrenman sekmesine git',
                      onTap: () => context.go('/workouts'),
                    ),
                    _shortcutCard(
                      key: const Key('shortcut_progress'),
                      icon: Icons.insights_outlined,
                      label: 'İlerleme',
                      semanticsLabel: 'İlerlemene git',
                      onTap: () => context.go('/progress'),
                    ),
                    _shortcutCard(
                      key: const Key('shortcut_nutrition'),
                      icon: Icons.restaurant_outlined,
                      label: 'Beslenme',
                      semanticsLabel: 'Beslenme sekmesine git',
                      onTap: () => context.go('/nutrition'),
                    ),
                    _shortcutCard(
                      key: const Key('shortcut_motivation'),
                      icon: Icons.headphones,
                      label: 'Motivasyon',
                      semanticsLabel: 'Motivasyon içeriklerine git',
                      onTap: () => context.go('/motivation'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Small note for accessibility / small devices
              if (isSmall)
                Text(
                  'İpucu: Kartlara dokunarak ilgili bölümlere hızlıca erişebilirsin.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
