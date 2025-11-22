// ignore_for_file: public_member_api_docs
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme.dart';

// Animation constants
const _kPageTransitionDuration = Duration(milliseconds: 400);
const _kIconAnimationDuration = Duration(milliseconds: 500);
const _kTextAnimationDuration = Duration(milliseconds: 400);
const _kDotAnimationDuration = Duration(milliseconds: 300);
const _kSlideAnimationDuration = Duration(milliseconds: 350);

// Spacing constants
const _kTopBarPadding = EdgeInsets.symmetric(horizontal: 32, vertical: 24);
const _kContentPadding = EdgeInsets.symmetric(horizontal: 40);
const _kButtonRowPadding = EdgeInsets.symmetric(horizontal: 40, vertical: 16);

// Size constants
const _kLogoSize = 36.0;
const _kIconContainerSize = 140.0;
const _kIconSize = 64.0;
const _kDotActiveWidth = 32.0;
const _kDotInactiveWidth = 8.0;
const _kDotHeight = 8.0;

// Background gradient colors (kept for gradient consistency)
const _kDarkNavy = Color(0xFF0A0E27);
const _kLighterNavy = Color(0xFF1A1F3A);
const _kPurpleNavy = Color(0xFF0F1129);

/// Data model for onboarding slides
class _OnboardingSlide {
  const _OnboardingSlide({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;
}

/// Premium onboarding screen with Apple Fitness quality animations
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _iconAnimController;
  late AnimationController _slideAnimController;
  int _currentPage = 0;

  // Onboarding slides data
  static const _slides = [
    _OnboardingSlide(
      icon: Icons.fitness_center_rounded,
      title: 'Akıllı Fitness Koçu',
      description: 'Hedefine ve seviyene göre kişisel antrenman rehberi.',
    ),
    _OnboardingSlide(
      icon: Icons.psychology_rounded,
      title: 'Zihin & Motivasyon',
      description:
          'Disiplin, odaklanma ve alışkanlık kazanman için günlük görevler.',
    ),
    _OnboardingSlide(
      icon: Icons.timeline_rounded,
      title: 'Kişisel Yol Haritan',
      description:
          'Verilerine göre kalori, antrenman ve beslenme planı.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _iconAnimController = AnimationController(
      vsync: this,
      duration: _kIconAnimationDuration,
    );
    _slideAnimController = AnimationController(
      vsync: this,
      duration: _kSlideAnimationDuration,
    );
    _iconAnimController.forward();
    _slideAnimController.forward();
  }

  @override
  void dispose() {
    // Dispose all controllers to prevent memory leaks
    _pageController.dispose();
    _iconAnimController.dispose();
    _slideAnimController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() => _currentPage = page);
    _iconAnimController
      ..reset()
      ..forward();
    _slideAnimController
      ..reset()
      ..forward();
  }

  void _nextPage() {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(
        duration: _kPageTransitionDuration,
        curve: Curves.easeOut,
      );
    } else {
      _navigateToHome();
    }
  }

  void _skipToEnd() {
    _navigateToHome();
  }

  void _navigateToHome() {
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [_kDarkNavy, _kLighterNavy, _kPurpleNavy],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildTopBar(context),
              const SizedBox(height: 8),
              Expanded(
                child: _buildPageView(),
              ),
              const SizedBox(height: 24),
              _buildDotIndicator(),
              const SizedBox(height: 32),
              _buildBottomBar(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: _kTopBarPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Small elegant logo
          Container(
            width: _kLogoSize,
            height: _kLogoSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.primary,
              boxShadow: [
                BoxShadow(
                  color: colorScheme.primary.withValues(alpha: 0.3),
                  blurRadius: 12,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Center(
              child: Text(
                'FM',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: colorScheme.onPrimary,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'FitMind+',
            style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageView() {
    return PageView.builder(
      controller: _pageController,
      onPageChanged: _onPageChanged,
      itemCount: _slides.length,
      itemBuilder: (context, index) {
        return _buildSlide(_slides[index], index);
      },
    );
  }

  Widget _buildSlide(_OnboardingSlide slide, int index) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: _kContentPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated Icon Container
          _AnimatedIconContainer(
            iconAnimController: _iconAnimController,
            icon: slide.icon,
            accentColor: colorScheme.primary,
          ),
          const SizedBox(height: 56),
          // Title with slide animation
          _AnimatedSlideText(
            slideAnimController: _slideAnimController,
            child: Text(
              slide.title,
              key: ValueKey('title_$index'),
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    height: 1.1,
                    letterSpacing: -0.5,
                  ),
            ),
          ),
          const SizedBox(height: 20),
          // Description with delayed slide animation
          _AnimatedSlideText(
            slideAnimController: _slideAnimController,
            delay: const Duration(milliseconds: 100),
            child: Text(
              slide.description,
              key: ValueKey('desc_$index'),
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.7),
                    height: 1.6,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.2,
                  ),
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDotIndicator() {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _slides.length,
        (index) {
          final isActive = index == _currentPage;
          return AnimatedContainer(
            duration: _kDotAnimationDuration,
            curve: Curves.easeOut,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            width: isActive ? _kDotActiveWidth : _kDotInactiveWidth,
            height: _kDotHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.chip), // Full pill
              color: isActive
                  ? colorScheme.primary
                  : Colors.white.withValues(alpha: 0.25),
              boxShadow: isActive
                  ? [
                      BoxShadow(
                        color: colorScheme.primary.withValues(alpha: 0.4),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ]
                  : null,
            ),
          );
        },
      ),
    );
  }

  Widget _buildBottomBar() {
    final isLastPage = _currentPage == _slides.length - 1;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: _kButtonRowPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Skip button
          TextButton(
            onPressed: _skipToEnd,
            style: TextButton.styleFrom(
              foregroundColor: Colors.white.withValues(alpha: 0.6),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            ),
            child: const Text(
              'Atla',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
            ),
          ),
          // Next / Start button
          AnimatedContainer(
            duration: _kTextAnimationDuration,
            curve: Curves.easeOut,
            child: ElevatedButton(
              onPressed: _nextPage,
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.button),
                ),
                elevation: 8,
                shadowColor: colorScheme.primary.withValues(alpha: 0.5),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isLastPage ? 'Başla' : 'İleri',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
                    ),
                  ),
                  if (!isLastPage) ...[
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward_rounded, size: 20),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Animated icon container with scale and glow effects
class _AnimatedIconContainer extends StatelessWidget {
  const _AnimatedIconContainer({
    required this.iconAnimController,
    required this.icon,
    required this.accentColor,
  });

  final AnimationController iconAnimController;
  final IconData icon;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final scaleAnimation = CurvedAnimation(
      parent: iconAnimController,
      curve: Curves.easeOutBack,
    );
    final fadeAnimation = CurvedAnimation(
      parent: iconAnimController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    );

    return ScaleTransition(
      scale: Tween<double>(begin: 0.8, end: 1.0).animate(scaleAnimation),
      child: FadeTransition(
        opacity: fadeAnimation,
        child: Container(
          width: _kIconContainerSize,
          height: _kIconContainerSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                accentColor.withValues(alpha: 0.25),
                accentColor.withValues(alpha: 0.08),
                Colors.transparent,
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
            boxShadow: [
              BoxShadow(
                color: accentColor.withValues(alpha: 0.3),
                blurRadius: 40,
                spreadRadius: 10,
              ),
            ],
          ),
          child: Center(
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: accentColor.withValues(alpha: 0.15),
                border: Border.all(
                  color: accentColor.withValues(alpha: 0.4),
                  width: 2,
                ),
              ),
              child: Icon(
                icon,
                size: _kIconSize,
                color: accentColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Animated text with slide up and fade effect
class _AnimatedSlideText extends StatelessWidget {
  const _AnimatedSlideText({
    required this.slideAnimController,
    required this.child,
    this.delay = Duration.zero,
  });

  final AnimationController slideAnimController;
  final Widget child;
  final Duration delay;

  @override
  Widget build(BuildContext context) {
    final delayedAnimation = CurvedAnimation(
      parent: slideAnimController,
      curve: Interval(
        delay.inMilliseconds / _kSlideAnimationDuration.inMilliseconds,
        1.0,
        curve: Curves.easeOut,
      ),
    );

    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.3),
        end: Offset.zero,
      ).animate(delayedAnimation),
      child: FadeTransition(
        opacity: delayedAnimation,
        child: child,
      ),
    );
  }
}
