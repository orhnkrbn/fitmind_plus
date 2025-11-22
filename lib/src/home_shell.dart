// ignore_for_file: public_member_api_docs
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../app/theme.dart';
import 'tabs/workouts_page.dart';
import 'tabs/nutrition_page.dart';
import 'tabs/progress_page.dart';
import 'tabs/settings_page.dart';

/// Ana menü shell - AI Koç ve diğer özelliklerle zenginleştirilmiş
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  final _pages = const [
    _DashboardTab(),
    WorkoutsPage(),
    NutritionPage(),
    ProgressPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Anasayfa',
          ),
          NavigationDestination(
            icon: Icon(Icons.fitness_center_outlined),
            selectedIcon: Icon(Icons.fitness_center),
            label: 'Antrenman',
          ),
          NavigationDestination(
            icon: Icon(Icons.restaurant_outlined),
            selectedIcon: Icon(Icons.restaurant),
            label: 'Beslenme',
          ),
          NavigationDestination(
            icon: Icon(Icons.insights_outlined),
            selectedIcon: Icon(Icons.insights),
            label: 'İlerleme',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Ayarlar',
          ),
        ],
      ),
    );
  }
}

/// Dashboard tab - AI Koç ve diğer özelliklere hızlı erişim
class _DashboardTab extends StatelessWidget {
  const _DashboardTab();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text('FitMind+'),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {
                  // TODO: Bildirimler
                },
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(AppSpacing.md),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Hoş geldin mesajı
                _WelcomeCard(),
                const SizedBox(height: AppSpacing.lg),

                // AI Koç - Öne çıkan büyük kart
                _AiCoachFeatureCard(),
                const SizedBox(height: AppSpacing.xl),

                // Hızlı erişim başlığı
                Text(
                  'Hızlı Erişim',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                // Özellik grid'i
                const _FeatureGrid(),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

/// Hoş geldin kartı
class _WelcomeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primary.withValues(alpha: 0.15),
            colorScheme.primary.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(
          color: colorScheme.primary.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.primary,
            ),
            child: Icon(
              Icons.waving_hand_rounded,
              color: colorScheme.onPrimary,
              size: 28,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hoş Geldin!',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Bugün kendini nasıl hissediyorsun?',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// AI Koç öne çıkan kart - Premium görünüm
class _AiCoachFeatureCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primary,
            colorScheme.primary.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(AppRadius.cardLarge),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.4),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.cardLarge),
          onTap: () => context.go('/ai-chat'),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Row(
              children: [
                // AI Icon
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorScheme.onPrimary.withValues(alpha: 0.2),
                    border: Border.all(
                      color: colorScheme.onPrimary.withValues(alpha: 0.3),
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    Icons.smart_toy_rounded,
                    size: 36,
                    color: colorScheme.onPrimary,
                  ),
                ),
                const SizedBox(width: AppSpacing.lg),
                // Text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'FitMind+ AI Koç',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: colorScheme.onPrimary,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.md,
                              vertical: AppSpacing.xs,
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.onPrimary.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(AppRadius.chip), // Full pill badge
                            ),
                            child: Text(
                              'YENİ',
                              style: theme.textTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: colorScheme.onPrimary,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        'Spor, beslenme ve motivasyon sorularını sor',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onPrimary.withValues(alpha: 0.9),
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Row(
                        children: [
                          Text(
                            'Sohbete Başla',
                            style: theme.textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: colorScheme.onPrimary,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Icon(
                            Icons.arrow_forward_rounded,
                            size: 18,
                            color: colorScheme.onPrimary,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Özellik grid'i - Antrenman, Beslenme, Motivasyon
class _FeatureGrid extends StatelessWidget {
  const _FeatureGrid();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _FeatureCard(
                icon: Icons.fitness_center_rounded,
                title: 'Antrenman',
                subtitle: 'Programını gör',
                onTap: () {
                  // Antrenman sayfasına git - TODO: Route eklenecek
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Antrenman sayfası yakında!')),
                  );
                },
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _FeatureCard(
                icon: Icons.restaurant_rounded,
                title: 'Beslenme',
                subtitle: 'Kalori takibi',
                onTap: () {
                  // Beslenme sayfasına git - TODO: Route eklenecek
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Beslenme sayfası yakında!')),
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: _FeatureCard(
                icon: Icons.psychology_rounded,
                title: 'Zihin',
                subtitle: 'Motivasyon',
                onTap: () {
                  // Motivasyon sayfasına git
                  context.go('/motivation');
                },
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _FeatureCard(
                icon: Icons.qr_code_scanner_rounded,
                title: 'Tarayıcı',
                subtitle: 'Barkod tara',
                onTap: () {
                  // Scanner sayfasına git
                  context.go('/scanner');
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Tek bir özellik kartı
class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.card),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(AppRadius.button),
                  ),
                  child: Icon(
                    icon,
                    size: 28,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}