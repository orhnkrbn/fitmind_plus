import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/router.dart';
import 'app/theme.dart';
import 'features/settings/presentation/theme_controller.dart';
import 'core/firebase/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.init();
  runApp(const ProviderScope(child: FitMindUltraApp()));
}

class FitMindUltraApp extends ConsumerWidget {
  const FitMindUltraApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final dark = ref.watch(darkModeProvider);
    final lightTheme = buildLightTheme();
    final darkTheme = buildDarkTheme();

    return MaterialApp.router(
      title: 'FitMind+',
      debugShowCheckedModeBanner: false,
      themeMode: dark ? ThemeMode.dark : ThemeMode.light,
      theme: lightTheme.copyWith(
        textTheme: GoogleFonts.interTextTheme(lightTheme.textTheme),
      ),
      darkTheme: darkTheme.copyWith(
        textTheme: GoogleFonts.interTextTheme(darkTheme.textTheme),
      ),
      routerConfig: router,
      supportedLocales: const [Locale('en'), Locale('tr')],
    );
  }
}
