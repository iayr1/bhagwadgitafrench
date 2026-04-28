import 'package:flutter/material.dart';

import '../../../core/widgets/banner_ad_widget.dart';
import '../../bookmarks/presentation/bookmarks_page.dart';
import '../../chapters/presentation/pages/chapters_page.dart';
import '../../daily_verse/presentation/daily_verse_page.dart';
import '../../favorites/presentation/favorites_page.dart';
import 'widgets/bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const String _homeBannerAdUnitId =
      'ca-app-pub-1429137343095963/9314032241';

  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    ChaptersPage(),
    DailyVersePage(),
    FavoritesPage(),
    BookmarksPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A0A00),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const BannerAdWidget(adUnitId: _homeBannerAdUnitId),
          HomeBottomNav(
            currentIndex: _selectedIndex,
            onTap: (i) => setState(() => _selectedIndex = i),
          ),
        ],
      ),
    );
  }
}
