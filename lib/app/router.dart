import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../features/splash/splash_page.dart';
import '../features/onboarding/presentation/onboarding_page.dart';
import '../src/home_shell.dart';
import '../features/dashboard/presentation/dashboard_page.dart';
import '../features/workouts/presentation/workouts_page.dart';
import '../features/nutrition/presentation/nutrition_page.dart';
import '../features/motivation/presentation/motivation_page.dart';
import '../features/scanner/presentation/scanner_placeholder_page.dart';
import '../features/ai_chat/views/ai_chat_view.dart';
import '../pages/ai_chat_page.dart';
import '../features/workout/workout_page.dart';
import '../features/workout/workout_detail_page.dart';
import '../features/nutrition/nutrition_page_new.dart';

final router = GoRouter(
  initialLocation: '/splash',
  routes: [
    // Entry flow: Splash → Onboarding → Home
    GoRoute(path: '/splash', builder: (ctx, st) => const SplashPage()),
    GoRoute(
      path: '/onboarding',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const OnboardingPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const curve = Curves.easeOut;
            var fadeTween = Tween(begin: 0.0, end: 1.0).chain(
              CurveTween(curve: curve),
            );
            return FadeTransition(
              opacity: animation.drive(fadeTween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 600),
        );
      },
    ),
    GoRoute(
      path: '/home',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const HomeShell(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const curve = Curves.easeOut;
            var fadeTween = Tween(begin: 0.0, end: 1.0).chain(
              CurveTween(curve: curve),
            );
            var slideTween = Tween<Offset>(
              begin: const Offset(0.03, 0.0),
              end: Offset.zero,
            ).chain(CurveTween(curve: curve));

            return FadeTransition(
              opacity: animation.drive(fadeTween),
              child: SlideTransition(
                position: animation.drive(slideTween),
                child: child,
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 700),
        );
      },
    ),
    
    // Main app routes
    GoRoute(path: '/dashboard', builder: (ctx, st) => const DashboardPage()),
    GoRoute(path: '/workouts', builder: (ctx, st) => const WorkoutsPage()),
    GoRoute(path: '/nutrition', builder: (ctx, st) => const NutritionPage()),
    GoRoute(path: '/motivation', builder: (ctx, st) => const MotivationPage()),
    GoRoute(path: '/scanner', builder: (ctx, st) => const ScannerPlaceholderPage()),
    
    // AI Chat - Premium UI (default)
    GoRoute(path: '/ai-chat', builder: (ctx, st) => const AiChatPage()),
    
    // AI Chat - Feature-based (Provider pattern)
    GoRoute(path: '/ai-feature', builder: (ctx, st) => const AiChatView()),
    
    // New Workout & Nutrition pages
    GoRoute(path: '/workout', builder: (ctx, st) => const WorkoutPage()),
    GoRoute(
      path: '/workout-detail',
      builder: (ctx, st) => WorkoutDetailPage(
        workoutDay: st.extra as dynamic,
      ),
    ),
    GoRoute(path: '/nutrition-new', builder: (ctx, st) => const NutritionPageNew()),
  ],
);
