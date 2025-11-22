// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import '../app/theme.dart';

/// Reusable animated FitMind+ logo widget
/// Can be used in splash, onboarding, or any other screen
class FitMindLogo extends StatelessWidget {
  final double size;
  final bool showText;
  final bool animated;
  final Animation<double>? shimmerAnimation;

  const FitMindLogo({
    super.key,
    this.size = 80,
    this.showText = true,
    this.animated = false,
    this.shimmerAnimation,
  });

  @override
  Widget build(BuildContext context) {
    final logoWidget = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Icon with optional glow effect
        if (animated && shimmerAnimation != null)
          AnimatedBuilder(
            animation: shimmerAnimation!,
            builder: (context, child) {
              return Container(
                padding: EdgeInsets.all(size * 0.4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryGold.withValues(
                        alpha: 0.3 + (shimmerAnimation!.value * 0.4),
                      ),
                      blurRadius: (size * 0.5) + (shimmerAnimation!.value * (size * 0.25)),
                      spreadRadius: (size * 0.0625) + (shimmerAnimation!.value * (size * 0.125)),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.fitness_center_rounded,
                  size: size,
                  color: AppColors.primaryGold,
                ),
              );
            },
          )
        else
          Icon(
            Icons.fitness_center_rounded,
            size: size,
            color: AppColors.primaryGold,
          ),

        if (showText) ...[
          SizedBox(height: size * 0.425),
          
          // App name with gradient
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [
                AppColors.primaryGold,
                AppColors.secondaryGold,
                AppColors.primaryGold,
              ],
            ).createShader(bounds),
            child: Text(
              'FitMind+',
              style: TextStyle(
                fontSize: size * 0.6,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2,
              ),
            ),
          ),
          
          SizedBox(height: size * 0.1),
          
          // Tagline with optional pulse
          if (animated && shimmerAnimation != null)
            AnimatedBuilder(
              animation: shimmerAnimation!,
              builder: (context, child) {
                return Opacity(
                  opacity: 0.6 + (shimmerAnimation!.value * 0.3),
                  child: Text(
                    'Sağlıklı Yaşam, Güçlü Zihin',
                    style: TextStyle(
                      fontSize: size * 0.2,
                      color: Colors.white70,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                );
              },
            )
          else
            const Text(
              'Sağlıklı Yaşam, Güçlü Zihin',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
                letterSpacing: 1,
                fontWeight: FontWeight.w300,
              ),
            ),
        ],
      ],
    );

    return logoWidget;
  }
}

/// Static version without animations - for simple use cases
class SimpleFitMindLogo extends StatelessWidget {
  final double size;
  final bool showText;

  const SimpleFitMindLogo({
    super.key,
    this.size = 60,
    this.showText = false,
  });

  @override
  Widget build(BuildContext context) {
    return FitMindLogo(
      size: size,
      showText: showText,
      animated: false,
    );
  }
}
