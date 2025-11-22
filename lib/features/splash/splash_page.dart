import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Animation durations
const _kAnimationDuration = Duration(milliseconds: 2800);
const _kLogoSize = 140.0;
const _kSlideDistance = 30.0;

// Color scheme
const _kDarkNavy = Color(0xFF0A0E27);
const _kLighterNavy = Color(0xFF1A1F3A);
const _kPurpleNavy = Color(0xFF0F1129);
const _kGolden = Color(0xFFFFC857);
const _kAmber = Color(0xFFFFB347);

/// Premium animated splash screen with smooth transitions
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoFadeAnimation;
  late Animation<double> _textSlideAnimation;
  late Animation<double> _textFadeAnimation;
  late Animation<double> _taglineSlideAnimation;
  late Animation<double> _taglineFadeAnimation;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimationSequence();
  }

  void _initializeAnimations() {
    _controller = AnimationController(vsync: this, duration: _kAnimationDuration);

    const curve = Curves.easeOut;

    // Logo animations (0-40%)
    _logoScaleAnimation = _createTween(0.5, 1.0, 0.0, 0.4, curve);
    _logoFadeAnimation = _createTween(0.0, 1.0, 0.0, 0.4, curve);

    // Title animations (20-50%)
    _textSlideAnimation = _createTween(_kSlideDistance, 0.0, 0.2, 0.5, curve);
    _textFadeAnimation = _createTween(0.0, 1.0, 0.2, 0.5, curve);

    // Tagline animations (30-60%)
    _taglineSlideAnimation = _createTween(_kSlideDistance, 0.0, 0.3, 0.6, curve);
    _taglineFadeAnimation = _createTween(0.0, 1.0, 0.3, 0.6, curve);

    // Progress bar (0-100%)
    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  Animation<double> _createTween(
    double begin,
    double end,
    double startInterval,
    double endInterval,
    Curve curve,
  ) {
    return Tween<double>(begin: begin, end: end).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(startInterval, endInterval, curve: curve),
      ),
    );
  }

  void _startAnimationSequence() {
    _controller.forward();
    Future.delayed(_kAnimationDuration, () {
      if (mounted) context.go('/onboarding');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _SplashLogo(
                      scaleAnimation: _logoScaleAnimation,
                      fadeAnimation: _logoFadeAnimation,
                    ),
                    const SizedBox(height: 32),
                    _AnimatedText(
                      text: 'FitMind+',
                      slideAnimation: _textSlideAnimation,
                      fadeAnimation: _textFadeAnimation,
                      style: theme.textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _AnimatedText(
                      text: 'Zihninle Vücudunu Dönüştür',
                      slideAnimation: _taglineSlideAnimation,
                      fadeAnimation: _taglineFadeAnimation,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.white70,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              _ProgressIndicator(progressAnimation: _progressAnimation),
            ],
          ),
        ),
      ),
    );
  }
}

/// Animated logo widget
class _SplashLogo extends StatelessWidget {
  const _SplashLogo({
    required this.scaleAnimation,
    required this.fadeAnimation,
  });

  final Animation<double> scaleAnimation;
  final Animation<double> fadeAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: scaleAnimation.value,
          child: Opacity(
            opacity: fadeAnimation.value,
            child: Container(
              width: _kLogoSize,
              height: _kLogoSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [_kGolden, _kAmber],
                ),
                boxShadow: [
                  BoxShadow(
                    color: _kGolden.withValues(alpha: 0.5),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 20,
                    right: 20,
                    child: Icon(
                      Icons.psychology_outlined,
                      size: 40,
                      color: _kDarkNavy.withValues(alpha: 0.15),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Icon(
                      Icons.fitness_center,
                      size: 40,
                      color: _kDarkNavy.withValues(alpha: 0.15),
                    ),
                  ),
                  const Center(
                    child: Text(
                      'FM+',
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: _kDarkNavy,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Animated text widget with slide and fade
class _AnimatedText extends StatelessWidget {
  const _AnimatedText({
    required this.text,
    required this.slideAnimation,
    required this.fadeAnimation,
    this.style,
  });

  final String text;
  final Animation<double> slideAnimation;
  final Animation<double> fadeAnimation;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: slideAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, slideAnimation.value),
          child: Opacity(
            opacity: fadeAnimation.value,
            child: Text(text, style: style, textAlign: TextAlign.center),
          ),
        );
      },
    );
  }
}

/// Progress indicator at bottom
class _ProgressIndicator extends StatelessWidget {
  const _ProgressIndicator({required this.progressAnimation});

  final Animation<double> progressAnimation;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 40,
      child: Column(
        children: [
          AnimatedBuilder(
            animation: progressAnimation,
            builder: (context, child) {
              return Opacity(
                opacity: progressAnimation.value,
                child: const Text(
                  'Hazırlanıyor...',
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 12,
                    letterSpacing: 1,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: AnimatedBuilder(
              animation: progressAnimation,
              builder: (context, child) {
                return LinearProgressIndicator(
                  value: progressAnimation.value,
                  backgroundColor: Colors.white12,
                  valueColor: const AlwaysStoppedAnimation(_kGolden),
                  minHeight: 3,
                  borderRadius: BorderRadius.circular(2),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
