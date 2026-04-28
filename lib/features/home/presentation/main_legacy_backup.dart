import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
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
      title: 'भगवद्गीता - अहिराणी',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF6B00),
          brightness: Brightness.dark,
        ),
        fontFamily: 'serif',
      ),
      home: const SplashScreen(),
    );
  }
}

// ─────────────────────────────────────────────
// SPLASH SCREEN
// ─────────────────────────────────────────────
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _scaleAnim = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const HomeScreen(),
            transitionsBuilder: (_, anim, __, child) =>
                FadeTransition(opacity: anim, child: child),
            transitionDuration: const Duration(milliseconds: 800),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A0A00),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.2,
            colors: [
              Color(0xFF3D1500),
              Color(0xFF1A0A00),
            ],
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnim,
            child: ScaleTransition(
              scale: _scaleAnim,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // OM symbol
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const RadialGradient(
                        colors: [Color(0xFFFFD700), Color(0xFFFF6B00)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF6B00).withOpacity(0.6),
                          blurRadius: 40,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'ॐ',
                        style: TextStyle(
                          fontSize: 64,
                          color: Color(0xFF1A0A00),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'भगवद्गीता',
                    style: TextStyle(
                      fontSize: 36,
                      color: Color(0xFFFFD700),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'अहिराणी भाषेत',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFFFFAA55),
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 48),
                  SizedBox(
                    width: 160,
                    child: LinearProgressIndicator(
                      backgroundColor: const Color(0xFF3D1500),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        const Color(0xFFFFD700).withOpacity(0.8),
                      ),
                      minHeight: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// HOME SCREEN
// ─────────────────────────────────────────────
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    ChaptersPage(),
    DailyVersePage(),
    FavoritesPage(),
    SearchPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A0A00),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF2D1200),
          border: Border(
            top: BorderSide(
              color: const Color(0xFFFF6B00).withOpacity(0.3),
              width: 1,
            ),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (i) => setState(() => _selectedIndex = i),
          backgroundColor: Colors.transparent,
          selectedItemColor: const Color(0xFFFFD700),
          unselectedItemColor: const Color(0xFF8B5E3C),
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_rounded),
              label: 'अध्याय',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.wb_sunny_rounded),
              label: 'आजचा श्लोक',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_rounded),
              label: 'आवडते',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_rounded),
              label: 'शोधा',
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// CHAPTERS PAGE
// ─────────────────────────────────────────────
class ChaptersPage extends StatelessWidget {
  const ChaptersPage({super.key});

  static const List<Map<String, String>> chapters = [
    {
      'num': '१',
      'title': 'अर्जुन विषाद योग',
      'ahirani': 'अर्जुनाचो दुःख',
      'verses': '४७ श्लोक',
      'summary': 'कुरुक्षेत्राच्या रणांगणावर अर्जुनाचो मोह आणि विषाद',
    },
    {
      'num': '२',
      'title': 'सांख्य योग',
      'ahirani': 'ज्ञानाचो मार्ग',
      'verses': '७२ श्लोक',
      'summary': 'आत्म्याचो अमरत्व आणि कर्तव्याचो ज्ञान',
    },
    {
      'num': '३',
      'title': 'कर्म योग',
      'ahirani': 'कामाचो मार्ग',
      'verses': '४३ श्लोक',
      'summary': 'निष्काम कर्माचो महत्त्व आणि यज्ञाचो भावना',
    },
    {
      'num': '४',
      'title': 'ज्ञान योग',
      'ahirani': 'समजणाचो मार्ग',
      'verses': '४२ श्लोक',
      'summary': 'दिव्य ज्ञानाचो प्रकटीकरण आणि गुरुचो महत्त्व',
    },
    {
      'num': '५',
      'title': 'कर्म संन्यास योग',
      'ahirani': 'त्यागाचो मार्ग',
      'verses': '२९ श्लोक',
      'summary': 'कर्मसंन्यास आणि कर्मयोग यांचो तुलना',
    },
    {
      'num': '६',
      'title': 'ध्यान योग',
      'ahirani': 'मनाचो शांती',
      'verses': '४७ श्लोक',
      'summary': 'ध्यान साधना आणि मनाचो नियंत्रण',
    },
    {
      'num': '७',
      'title': 'ज्ञान विज्ञान योग',
      'ahirani': 'परमेश्वराचो ओळख',
      'verses': '३० श्लोक',
      'summary': 'भगवंताचो स्वरूप आणि माया',
    },
    {
      'num': '८',
      'title': 'अक्षर ब्रह्म योग',
      'ahirani': 'अनंताचो ज्ञान',
      'verses': '२८ श्लोक',
      'summary': 'परमब्रह्म आणि मृत्यूनंतरचो गती',
    },
    {
      'num': '९',
      'title': 'राज विद्या योग',
      'ahirani': 'राजविद्या',
      'verses': '३४ श्लोक',
      'summary': 'परम गुह्य ज्ञान आणि भक्तीचो महत्त्व',
    },
    {
      'num': '१०',
      'title': 'विभूति योग',
      'ahirani': 'परमेश्वराची शक्ती',
      'verses': '४२ श्लोक',
      'summary': 'भगवंताची दिव्य विभूती आणि वैभव',
    },
    {
      'num': '११',
      'title': 'विश्वरूप दर्शन योग',
      'ahirani': 'विश्वाचो रूप',
      'verses': '५५ श्लोक',
      'summary': 'अर्जुनाला विश्वरूपाचो दर्शन',
    },
    {
      'num': '१२',
      'title': 'भक्ति योग',
      'ahirani': 'प्रेमाचो मार्ग',
      'verses': '२० श्लोक',
      'summary': 'भक्तीचो श्रेष्ठता आणि भक्ताची लक्षणे',
    },
    {
      'num': '१३',
      'title': 'क्षेत्र क्षेत्रज्ञ विभाग योग',
      'ahirani': 'शरीर आणि आत्मा',
      'verses': '३५ श्लोक',
      'summary': 'शरीर, आत्मा आणि परमात्म्याचो ज्ञान',
    },
    {
      'num': '१४',
      'title': 'गुणत्रय विभाग योग',
      'ahirani': 'तीन गुण',
      'verses': '२७ श्लोक',
      'summary': 'सत्त्व, रज आणि तम गुणांचो विवेचन',
    },
    {
      'num': '१५',
      'title': 'पुरुषोत्तम योग',
      'ahirani': 'सर्वश्रेष्ठ पुरुष',
      'verses': '२० श्लोक',
      'summary': 'अश्वत्थाचो उदाहरण आणि परमपुरुष',
    },
    {
      'num': '१६',
      'title': 'दैवासुर संपद विभाग योग',
      'ahirani': 'देवी आणि आसुरी गुण',
      'verses': '२४ श्लोक',
      'summary': 'दैवी आणि आसुरी संपदेचो भेद',
    },
    {
      'num': '१७',
      'title': 'श्रद्धात्रय विभाग योग',
      'ahirani': 'श्रद्धेचे तीन प्रकार',
      'verses': '२८ श्लोक',
      'summary': 'तीन प्रकारची श्रद्धा, आहार आणि यज्ञ',
    },
    {
      'num': '१८',
      'title': 'मोक्ष संन्यास योग',
      'ahirani': 'मुक्तीचो मार्ग',
      'verses': '७८ श्लोक',
      'summary': 'संन्यास, मोक्ष आणि भगवद्गीतेचो सार',
    },
  ];

  static const List<Color> chapterColors = [
    Color(0xFFFF6B00),
    Color(0xFFFFD700),
    Color(0xFFE84393),
    Color(0xFF00C9A7),
    Color(0xFF845EC2),
    Color(0xFFFF9671),
    Color(0xFF0081CF),
    Color(0xFFFF6F91),
    Color(0xFFD65DB1),
    Color(0xFF00C9A7),
    Color(0xFFFF6B00),
    Color(0xFFFFD700),
    Color(0xFF845EC2),
    Color(0xFFE84393),
    Color(0xFF0081CF),
    Color(0xFFFF9671),
    Color(0xFF00C9A7),
    Color(0xFFFF6B00),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 200,
          pinned: true,
          backgroundColor: const Color(0xFF2D1200),
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF3D1500),
                    Color(0xFF1A0A00),
                  ],
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Decorative circles
                  Positioned(
                    right: -30,
                    top: -30,
                    child: Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFFF6B00).withOpacity(0.15),
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFFFD700).withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      const Text(
                        'ॐ',
                        style: TextStyle(
                          fontSize: 40,
                          color: Color(0xFFFFD700),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'भगवद्गीता',
                        style: TextStyle(
                          fontSize: 28,
                          color: Color(0xFFFFD700),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'अहिराणी भाषेत • १८ अध्याय • ७०० श्लोक',
                        style: TextStyle(
                          fontSize: 13,
                          color: const Color(0xFFFFAA55).withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          title: const Text(
            'भगवद्गीता',
            style: TextStyle(
              color: Color(0xFFFFD700),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final chapter = chapters[index];
                final color = chapterColors[index % chapterColors.length];
                return _ChapterCard(
                  chapter: chapter,
                  color: color,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChapterDetailScreen(
                          chapterNum: index + 1,
                          chapter: chapter,
                          color: color,
                        ),
                      ),
                    );
                  },
                );
              },
              childCount: chapters.length,
            ),
          ),
        ),
      ],
    );
  }
}

class _ChapterCard extends StatelessWidget {
  final Map<String, String> chapter;
  final Color color;
  final VoidCallback onTap;

  const _ChapterCard({
    required this.chapter,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  color.withOpacity(0.15),
                  const Color(0xFF2D1200),
                ],
              ),
              border: Border.all(
                color: color.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                // Chapter number circle
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        color.withOpacity(0.9),
                        color.withOpacity(0.4),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.4),
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      chapter['num']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chapter['title']!,
                        style: const TextStyle(
                          color: Color(0xFFFFD700),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        chapter['ahirani']!,
                        style: TextStyle(
                          color: color,
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        chapter['summary']!,
                        style: const TextStyle(
                          color: Color(0xFFAA7755),
                          fontSize: 11,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text(
                      chapter['verses']!,
                      style: TextStyle(
                        color: color.withOpacity(0.8),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: color.withOpacity(0.7),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// CHAPTER DETAIL SCREEN
// ─────────────────────────────────────────────
class ChapterDetailScreen extends StatelessWidget {
  final int chapterNum;
  final Map<String, String> chapter;
  final Color color;

  const ChapterDetailScreen({
    super.key,
    required this.chapterNum,
    required this.chapter,
    required this.color,
  });

  static const List<Map<String, String>> sampleVerses = [
    {
      'num': '१',
      'sanskrit': 'धृतराष्ट्र उवाच | धर्मक्षेत्रे कुरुक्षेत्रे समवेता युयुत्सवः |',
      'ahirani': 'धृतराष्ट्र म्हनना: धर्माच्या कुरुक्षेत्रात एकट्या आलेल्या माझ्या आणि पांडूच्या पोरास्नी काय केलं?',
      'meaning': 'धर्मभूमी कुरुक्षेत्रावर जमलेल्या माझ्या आणि पांडूच्या पुत्रांनी काय केले?',
    },
    {
      'num': '२',
      'sanskrit': 'सञ्जय उवाच | दृष्ट्वा तु पाण्डवानीकं व्यूढं दुर्योधनस्तदा |',
      'ahirani': 'संजय म्हनना: त्या वेळी दुर्योधनान पांडवांची सेना व्यूहबद्ध दिसली...',
      'meaning': 'संजय म्हणाला: त्यावेळी दुर्योधनाने पांडवांची सेना व्यूहाकाराने उभी असलेली पाहिली.',
    },
    {
      'num': '३',
      'sanskrit': 'पश्यैतां पाण्डुपुत्राणामाचार्य महतीं चमूम् |',
      'ahirani': 'आचार्य, पांडूच्या पोरांची ही मोठी सेना बघा जी द्रुपदाच्या हुशार पोरान सजवली हे।',
      'meaning': 'हे आचार्य! पांडुपुत्रांची ही महान सेना पाहा, जी द्रुपदाच्या बुद्धिमान पुत्राने सजवली आहे.',
    },
    {
      'num': '४',
      'sanskrit': 'अत्र शूरा महेष्वासा भीमार्जुनसमा युधि |',
      'ahirani': 'इथे मोठे वीर आहेत, महान धनुर्धर आहेत जे युद्धात भीम-अर्जुनाजोगे हाय।',
      'meaning': 'येथे महान धनुर्धारी शूरवीर आहेत जे युद्धात भीम आणि अर्जुनाशी समान आहेत.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A0A00),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            backgroundColor: const Color(0xFF2D1200),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Color(0xFFFFD700)),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.bookmark_border, color: Color(0xFFFFD700)),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.share_outlined, color: Color(0xFFFFD700)),
                onPressed: () {},
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      color.withOpacity(0.4),
                      const Color(0xFF1A0A00),
                    ],
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'अध्याय ${chapter['num']}',
                          style: TextStyle(
                            color: color,
                            fontSize: 16,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          chapter['title']!,
                          style: const TextStyle(
                            color: Color(0xFFFFD700),
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          chapter['ahirani']!,
                          style: TextStyle(
                            color: color.withOpacity(0.9),
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: color.withOpacity(0.1),
                  border: Border.all(color: color.withOpacity(0.3)),
                ),
                child: Text(
                  chapter['summary']!,
                  style: const TextStyle(
                    color: Color(0xFFDDC08A),
                    fontSize: 14,
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _VerseCard(
                  verse: sampleVerses[index % sampleVerses.length],
                  color: color,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VerseDetailScreen(
                          verse: sampleVerses[index % sampleVerses.length],
                          chapterNum: chapterNum,
                          verseNum: index + 1,
                          color: color,
                        ),
                      ),
                    );
                  },
                ),
                childCount: 8,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }
}

class _VerseCard extends StatelessWidget {
  final Map<String, String> verse;
  final Color color;
  final VoidCallback onTap;

  const _VerseCard({
    required this.verse,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: const Color(0xFF2D1200),
            border: Border.all(
              color: color.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: color.withOpacity(0.5)),
                    ),
                    child: Text(
                      'श्लोक ${verse['num']}',
                      style: TextStyle(
                        color: color,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Icon(Icons.play_circle_outline, color: color, size: 20),
                  const SizedBox(width: 8),
                  Icon(Icons.favorite_border, color: color.withOpacity(0.6), size: 20),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                verse['sanskrit']!,
                style: const TextStyle(
                  color: Color(0xFFFFD700),
                  fontSize: 14,
                  height: 1.6,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 10),
              const Divider(color: Color(0xFF3D1500)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3D1500),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'अहिराणी',
                      style: TextStyle(
                        color: Color(0xFFFF9966),
                        fontSize: 10,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      verse['ahirani']!,
                      style: const TextStyle(
                        color: Color(0xFFDDC08A),
                        fontSize: 13,
                        height: 1.5,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// VERSE DETAIL SCREEN
// ─────────────────────────────────────────────
class VerseDetailScreen extends StatefulWidget {
  final Map<String, String> verse;
  final int chapterNum;
  final int verseNum;
  final Color color;

  const VerseDetailScreen({
    super.key,
    required this.verse,
    required this.chapterNum,
    required this.verseNum,
    required this.color,
  });

  @override
  State<VerseDetailScreen> createState() => _VerseDetailScreenState();
}

class _VerseDetailScreenState extends State<VerseDetailScreen> {
  bool _isFavorite = false;
  bool _showTransliteration = true;
  bool _showMeaning = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A0A00),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2D1200),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFFFFD700)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'अध्याय ${widget.chapterNum} • श्लोक ${widget.verseNum}',
          style: const TextStyle(
            color: Color(0xFFFFD700),
            fontSize: 16,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? Colors.red : const Color(0xFFFFD700),
            ),
            onPressed: () => setState(() => _isFavorite = !_isFavorite),
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Color(0xFFFFD700)),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Sanskrit verse
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: RadialGradient(
                  center: Alignment.topLeft,
                  radius: 2,
                  colors: [
                    widget.color.withOpacity(0.2),
                    const Color(0xFF2D1200),
                  ],
                ),
                border: Border.all(
                  color: widget.color.withOpacity(0.4),
                  width: 1.5,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'ॐ',
                    style: TextStyle(
                      fontSize: 32,
                      color: widget.color,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.verse['sanskrit']!,
                    style: const TextStyle(
                      color: Color(0xFFFFD700),
                      fontSize: 18,
                      height: 1.8,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Audio player
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color(0xFF2D1200),
                border: Border.all(
                  color: widget.color.withOpacity(0.3),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.skip_previous, color: widget.color, size: 28),
                  const SizedBox(width: 20),
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          widget.color,
                          widget.color.withOpacity(0.6),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: widget.color.withOpacity(0.5),
                          blurRadius: 16,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Icon(Icons.skip_next, color: widget.color, size: 28),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Ahirani translation
            _buildSection(
              title: 'अहिराणी अनुवाद',
              icon: '🗣️',
              content: widget.verse['ahirani']!,
              color: widget.color,
              isActive: _showTransliteration,
              onToggle: () =>
                  setState(() => _showTransliteration = !_showTransliteration),
            ),
            const SizedBox(height: 16),

            // Meaning
            _buildSection(
              title: 'अर्थ (मराठी)',
              icon: '📖',
              content: widget.verse['meaning']!,
              color: const Color(0xFF00C9A7),
              isActive: _showMeaning,
              onToggle: () => setState(() => _showMeaning = !_showMeaning),
            ),
            const SizedBox(height: 16),

            // Commentary teaser
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: const Color(0xFF2D1200),
                border: Border.all(
                  color: const Color(0xFFFFD700).withOpacity(0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Text('💡', style: TextStyle(fontSize: 18)),
                      SizedBox(width: 8),
                      Text(
                        'स्पष्टीकरण',
                        style: TextStyle(
                          color: Color(0xFFFFD700),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'या श्लोकात भगवान श्रीकृष्ण अर्जुनास...',
                    style: TextStyle(
                      color: const Color(0xFFDDC08A).withOpacity(0.7),
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'पूर्ण वाचा →',
                      style: TextStyle(color: Color(0xFFFFD700)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String icon,
    required String content,
    required Color color,
    required bool isActive,
    required VoidCallback onToggle,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: const Color(0xFF2D1200),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: onToggle,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Text(icon, style: const TextStyle(fontSize: 18)),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: TextStyle(
                      color: color,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    isActive
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: color,
                  ),
                ],
              ),
            ),
          ),
          if (isActive)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                children: [
                  const Divider(color: Color(0xFF3D2010)),
                  const SizedBox(height: 10),
                  Text(
                    content,
                    style: const TextStyle(
                      color: Color(0xFFDDC08A),
                      fontSize: 15,
                      height: 1.7,
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

// ─────────────────────────────────────────────
// DAILY VERSE PAGE
// ─────────────────────────────────────────────
class DailyVersePage extends StatelessWidget {
  const DailyVersePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A0A00),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: const Color(0xFF2D1200),
            title: const Text(
              'आजचो श्लोक',
              style: TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined, color: Color(0xFFFFD700)),
                onPressed: () {},
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Date header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xFF3D1500),
                          border: Border.all(color: const Color(0xFFFF6B00).withOpacity(0.4)),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.wb_sunny_rounded, color: Color(0xFFFFD700), size: 16),
                            SizedBox(width: 6),
                            Text(
                              'आज, सोमवार',
                              style: TextStyle(color: Color(0xFFFFD700), fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Main daily verse card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF3D1500),
                          Color(0xFF2D1200),
                          Color(0xFF1A0A00),
                        ],
                      ),
                      border: Border.all(
                        color: const Color(0xFFFFD700).withOpacity(0.3),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF6B00).withOpacity(0.15),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text(
                          '✦ आजचो श्लोक ✦',
                          style: TextStyle(
                            color: Color(0xFFFF6B00),
                            fontSize: 13,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'अध्याय २ • श्लोक ४७',
                          style: TextStyle(
                            color: Color(0xFFFFAA55),
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'कर्मण्येवाधिकारस्ते\nमा फलेषु कदाचन।\nमा कर्मफलहेतुर्भूर्मा\nते सङ्गोऽस्त्वकर्मणि॥',
                          style: TextStyle(
                            color: Color(0xFFFFD700),
                            fontSize: 18,
                            height: 1.8,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 1,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                const Color(0xFFFF6B00).withOpacity(0.6),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'तू फक्त कामच कर, त्याचो फळाचो विचार करू नको।\nकामाच्या फळाचो कारण होऊ नको,\nआणि काम न करण्यात आसक्त होऊ नको।',
                          style: TextStyle(
                            color: Color(0xFFDDC08A),
                            fontSize: 14,
                            height: 1.7,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF6B00).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFFF6B00).withOpacity(0.3)),
                          ),
                          child: const Text(
                            '🗣️ अहिराणी अनुवाद',
                            style: TextStyle(color: Color(0xFFFF9966), fontSize: 11),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Action buttons
                  Row(
                    children: [
                      _ActionBtn(
                        icon: Icons.play_circle_filled_rounded,
                        label: 'ऐकाना',
                        color: const Color(0xFFFF6B00),
                        onTap: () {},
                      ),
                      const SizedBox(width: 12),
                      _ActionBtn(
                        icon: Icons.share_rounded,
                        label: 'शेअर करा',
                        color: const Color(0xFF00C9A7),
                        onTap: () {},
                      ),
                      const SizedBox(width: 12),
                      _ActionBtn(
                        icon: Icons.favorite_rounded,
                        label: 'जतन करा',
                        color: const Color(0xFFE84393),
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),

                  // Streak tracker
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color(0xFF2D1200),
                      border: Border.all(
                        color: const Color(0xFFFFD700).withOpacity(0.2),
                      ),
                    ),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Text('🔥', style: TextStyle(fontSize: 20)),
                            SizedBox(width: 8),
                            Text(
                              '७ दिवसांची सलग साधना',
                              style: TextStyle(
                                color: Color(0xFFFFD700),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: ['सो', 'मं', 'बु', 'गु', 'शु', 'श', 'र']
                              .asMap()
                              .entries
                              .map(
                                (e) => Column(
                                  children: [
                                    Container(
                                      width: 36,
                                      height: 36,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: e.key < 5
                                            ? const Color(0xFFFF6B00)
                                            : const Color(0xFF3D1500),
                                        border: e.key == 4
                                            ? Border.all(
                                                color: const Color(0xFFFFD700),
                                                width: 2,
                                              )
                                            : null,
                                      ),
                                      child: Icon(
                                        e.key < 5 ? Icons.check : Icons.circle_outlined,
                                        size: 16,
                                        color: e.key < 5
                                            ? Colors.white
                                            : const Color(0xFF8B5E3C),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      e.value,
                                      style: TextStyle(
                                        color: e.key < 5
                                            ? const Color(0xFFFFD700)
                                            : const Color(0xFF8B5E3C),
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionBtn({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: color.withOpacity(0.15),
            border: Border.all(color: color.withOpacity(0.4)),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// FAVORITES PAGE
// ─────────────────────────────────────────────
class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A0A00),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2D1200),
        title: const Text(
          'आवडते श्लोक',
          style: TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort_rounded, color: Color(0xFFFFD700)),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        itemBuilder: (context, index) {
          final colors = [
            const Color(0xFFFF6B00),
            const Color(0xFFFFD700),
            const Color(0xFFE84393),
            const Color(0xFF00C9A7),
            const Color(0xFF845EC2),
          ];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: const Color(0xFF2D1200),
                border: Border.all(
                  color: colors[index].withOpacity(0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: colors[index].withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: colors[index].withOpacity(0.4)),
                        ),
                        child: Text(
                          'अध्याय ${index + 2} • श्लोक ${index * 3 + 1}',
                          style: TextStyle(color: colors[index], fontSize: 11),
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.favorite, color: Colors.red, size: 18),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _sampleSanskritVerses[index % _sampleSanskritVerses.length],
                    style: const TextStyle(
                      color: Color(0xFFFFD700),
                      fontSize: 13,
                      height: 1.6,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _sampleAhiraniVerses[index % _sampleAhiraniVerses.length],
                    style: const TextStyle(
                      color: Color(0xFFAA8855),
                      fontSize: 12,
                      height: 1.5,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  static const List<String> _sampleSanskritVerses = [
    'कर्मण्येवाधिकारस्ते मा फलेषु कदाचन।',
    'यदा यदा हि धर्मस्य ग्लानिर्भवति भारत।',
    'श्रद्धावान् लभते ज्ञानं तत्परः संयतेन्द्रियः।',
    'असक्तो ह्याचरन्कर्म परमाप्नोति पूरुषः।',
    'मनुष्याणां सहस्रेषु कश्चिद्यतति सिद्धये।',
  ];

  static const List<String> _sampleAhiraniVerses = [
    'तू फक्त काम कर, फळाचो विचार करू नको।',
    'जव जव धर्माचो ऱ्हास होतो तव तव मी अवतार घेतो।',
    'श्रद्धा असणाऱ्याला ज्ञान मिळते।',
    'आसक्ती न ठेवता काम केल्यान माणूस परमात्म्याला पावतो।',
    'हजारो माणसांत एखादोच सिद्धी मिळवण्यासाठी प्रयत्न करतो।',
  ];
}

// ─────────────────────────────────────────────
// SEARCH PAGE
// ─────────────────────────────────────────────
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = TextEditingController();
  bool _hasQuery = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A0A00),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2D1200),
        title: const Text(
          'शोधा',
          style: TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Search field
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: const Color(0xFF2D1200),
                border: Border.all(
                  color: const Color(0xFFFF6B00).withOpacity(0.4),
                ),
              ),
              child: TextField(
                controller: _controller,
                onChanged: (v) => setState(() => _hasQuery = v.isNotEmpty),
                style: const TextStyle(color: Color(0xFFDDC08A)),
                decoration: InputDecoration(
                  hintText: 'श्लोक, अध्याय, शब्द शोधा...',
                  hintStyle: const TextStyle(color: Color(0xFF8B5E3C)),
                  prefixIcon: const Icon(Icons.search, color: Color(0xFFFF6B00)),
                  suffixIcon: _hasQuery
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Color(0xFF8B5E3C)),
                          onPressed: () {
                            _controller.clear();
                            setState(() => _hasQuery = false);
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 24),

            if (!_hasQuery) ...[
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'लोकप्रिय श्लोक',
                  style: TextStyle(
                    color: Color(0xFFFFD700),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  'कर्मयोग',
                  'भक्ती',
                  'ज्ञान',
                  'मोक्ष',
                  'धर्म',
                  'आत्मा',
                  'ध्यान',
                  'योग',
                ].map(
                  (tag) => GestureDetector(
                    onTap: () {
                      _controller.text = tag;
                      setState(() => _hasQuery = true);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xFF3D1500),
                        border: Border.all(
                          color: const Color(0xFFFF6B00).withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        tag,
                        style: const TextStyle(
                          color: Color(0xFFFFAA55),
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ).toList(),
              ),
            ] else ...[
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'शोधाचे निकाल',
                  style: TextStyle(
                    color: Color(0xFFFFD700),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xFF2D1200),
                        border: Border.all(
                          color: const Color(0xFFFF6B00).withOpacity(0.2),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'अध्याय ${index + 2} • श्लोक ${index + 1}',
                            style: const TextStyle(
                              color: Color(0xFFFF6B00),
                              fontSize: 11,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'कर्मण्येवाधिकारस्ते मा फलेषु कदाचन...',
                            style: const TextStyle(
                              color: Color(0xFFDDC08A),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}