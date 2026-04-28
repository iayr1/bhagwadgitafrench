import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/services/audio_service.dart';
import '../../../../core/services/bookmarks_service.dart';
import '../../../../core/services/favorites_service.dart';

class VerseDetailPage extends StatefulWidget {
  final Map<String, String> verse;
  final int chapterNum;
  final int verseNum;
  final Color color;

  const VerseDetailPage({
    super.key,
    required this.verse,
    required this.chapterNum,
    required this.verseNum,
    required this.color,
  });

  @override
  State<VerseDetailPage> createState() => _VerseDetailPageState();
}

class _VerseDetailPageState extends State<VerseDetailPage> {
  bool _showFrench = true;
  bool _showMeaning = true;

  final FavoritesService _favoritesService = FavoritesService.instance;
  final BookmarksService _bookmarksService = BookmarksService.instance;
  final AudioService _audioService = AudioService.instance;

  @override
  Widget build(BuildContext context) {
    final isFavorite = _favoritesService.isFavorite(
      chapterNum: widget.chapterNum,
      verseNum: widget.verseNum,
    );

    final isBookmarked = _bookmarksService.isBookmarked(
      chapterNum: widget.chapterNum,
      verseNum: widget.verseNum,
    );

    return Scaffold(
      backgroundColor: const Color(0xFF1A0A00),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2D1200),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFFFFD700)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Chapter ${widget.chapterNum} • Verse ${widget.verseNum}',
          style: const TextStyle(color: Color(0xFFFFD700), fontSize: 16),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.play_circle_outline,
              color: Color(0xFFFFD700),
            ),
            onPressed: () => _audioService.speakSanskritVerse(
              widget.verse['sanskrit'] ?? '',
            ),
          ),
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : const Color(0xFFFFD700),
            ),
            onPressed: () {
              final isNowFavorite = _favoritesService.toggleFavorite(
                chapterNum: widget.chapterNum,
                verseNum: widget.verseNum,
                verse: widget.verse,
              );
              setState(() {});
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isNowFavorite
                        ? 'Added to favorites'
                        : 'Removed from favorites',
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: const Color(0xFFFFD700),
            ),
            onPressed: () {
              final isNowBookmarked = _bookmarksService.toggleBookmark(
                chapterNum: widget.chapterNum,
                verseNum: widget.verseNum,
                verse: widget.verse,
              );
              setState(() {});
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isNowBookmarked
                        ? 'Added to bookmarks'
                        : 'Removed from bookmarks',
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Color(0xFFFFD700)),
            onPressed: _shareVerse,
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            /// Sanskrit Card
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
                    style: TextStyle(fontSize: 32, color: widget.color),
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

            /// French Translation
            _buildSection(
              title: 'French Translation',
              icon: '🗣️',
              content: widget.verse['French']!,
              color: widget.color,
              isActive: _showFrench,
              onToggle: () => setState(() => _showFrench = !_showFrench),
            ),

            const SizedBox(height: 16),

            /// English Meaning
            _buildSection(
              title: 'Meaning (English)',
              icon: '📖',
              content: widget.verse['meaning']!,
              color: const Color(0xFF00C9A7),
              isActive: _showMeaning,
              onToggle: () => setState(() => _showMeaning = !_showMeaning),
            ),
          ],
        ),
      ),
    );
  }

  /// Share Function
  void _shareVerse() {
    final text =
'''
Bhagavad Gita - Chapter ${widget.chapterNum}, Verse ${widget.verseNum}

${widget.verse['sanskrit'] ?? ''}

French: ${widget.verse['French'] ?? ''}

Meaning: ${widget.verse['meaning'] ?? ''}
''';

    SharePlus.instance.share(ShareParams(text: text.trim()));
  }

  /// Reusable Section Widget
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