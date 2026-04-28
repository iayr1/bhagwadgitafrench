import 'package:flutter/material.dart';

import '../../features/home/presentation/home_screen.dart';

class AppRoutes {
  static const String home = '/home';

  static final Map<String, WidgetBuilder> routes = {
    home: (_) => const HomeScreen(),
  };

  const AppRoutes._();
}
