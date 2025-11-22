import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme.dart';

class OnboardingData {
  final IconData icon;
  final String title;
  final String description;
  final Color accentColor;

  const OnboardingData({
    required this.icon,
    required this.title,
    required this.description,
    required this.accentColor,
  });
}

class PremiumOnboardingScreen extends StatefulWidget {
  const PremiumOnboardingScreen({super.key});

  @override
  State<PremiumOnboardingScreen> createState() =>
      _PremiumOnboardingScreenState();
}

class _PremiumOnboardingScreenState extends State<PremiumOnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _pages = const [
    OnboardingData(
      icon: Icons.psychology_rounded,
      title: 'AI Fitness Koçunuz',
      description:
          'Yapay zeka destekli kişisel koçunuz, antrenman ve beslenme sorularınızı anında yanıtlar.',
      accentColor: Color(0xFFFFC857),
    ),
    OnboardingData(
      icon: Icons.fitness_center_rounded,
      title: 'Kişisel Antrenman Planı',
      description:
          'Hedefinize ve seviyenize özel hazırlanmış detaylı antrenman programları.',
      accentColor: Color(0xFFFFB347),
    ),
    OnboardingData(
      icon: Icons.trending_up_rounded,
      title: 'İlerleme Takibi',
      description:
          'Kalorilerinizi, egzersizlerinizi takip edin. Motivasyonunuzu yüksek tutun.',
      accentColor: Color(0xFFFF9A00),
    ),
  ];

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      context.go('/dashboard');
    }
  }

  void _skipToEnd() {
    context.go('/dashboard');
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF050816),
              Color(0xFF0D1326),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Skip button
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextButton(
                    onPressed: _skipToEnd,
                    child: Text(
                      'Atla',
                      style: TextStyle(
                        color: AppColors.primaryGold.withValues(alpha: 0.8),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),

              // PageView
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    return _OnboardingPageContent(
                      data: _pages[index],
                      pageIndex: index,
                      currentPage: _currentPage,
                    );
                  },
                ),
              ),

              // Page indicators
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _pages.length,
                    (index) => _PageIndicator(
                      isActive: index == _currentPage,
                      accentColor: _pages[index].accentColor,
                    ),
                  ),
                ),
              ),

              // Next/Start button
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _nextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryGold,
                      foregroundColor: Colors.black87,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.button),
                      ),
                      elevation: 8,
                      shadowColor: AppColors.primaryGold.withValues(alpha: 0.5),
                    ),
                    child: Text(
                      _currentPage == _pages.length - 1
                          ? 'Başlayalım'
                          : 'Devam',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingPageContent extends StatelessWidget {
  final OnboardingData data;
  final int pageIndex;
  final int currentPage;

  const _OnboardingPageContent({
    required this.data,
    required this.pageIndex,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = pageIndex == currentPage;
    final offset = (pageIndex - currentPage).toDouble();

    return AnimatedOpacity(
      opacity: isActive ? 1.0 : 0.3,
      duration: const Duration(milliseconds: 300),
      child: Transform.translate(
        offset: Offset(offset * 50, 0),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon with glow effect
              Container(
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      data.accentColor.withValues(alpha: 0.3),
                      Colors.transparent,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: data.accentColor.withValues(alpha: 0.4),
                      blurRadius: 60,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: Icon(
                  data.icon,
                  size: 100,
                  color: data.accentColor,
                ),
              ),

              const SizedBox(height: AppSpacing.xxl),

              // Title
              Text(
                data.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.5,
                  height: 1.2,
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              // Description
              Text(
                data.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withValues(alpha: 0.7),
                  height: 1.6,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  final bool isActive;
  final Color accentColor;

  const _PageIndicator({
    required this.isActive,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
      width: isActive ? 32 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? accentColor : Colors.white24,
        borderRadius: BorderRadius.circular(4),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: accentColor.withValues(alpha: 0.5),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
    );
  }
}
