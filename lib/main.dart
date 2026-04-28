import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'core/config/routes.dart';
import 'core/config/theme.dart';
import 'core/services/local_storage.dart';
import 'features/splash/presentation/splash_screen.dart';

Future<void> main() async {
  // Ensures plugin services (including ads) are initialized before app start.
  WidgetsFlutterBinding.ensureInitialized();

  // Initializes the Google Mobile Ads SDK at app startup.
  await MobileAds.instance.initialize();
  await LocalStorageService.instance.initialize();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const BhagwadGitaApp());
}

class BhagwadGitaApp extends StatelessWidget {
  const BhagwadGitaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'भगवद्गीता - French',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routes: AppRoutes.routes,
      home: const SplashScreen(),
    );
  }
}
