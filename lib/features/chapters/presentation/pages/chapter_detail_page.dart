import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/services/audio_service.dart';
import '../../../../core/services/bookmarks_service.dart';
import '../../../../core/services/favorites_service.dart';
import '../../../verse/presentation/pages/verse_detail_page.dart';
import '../../../verse/presentation/widgets/verse_card.dart';
import '../../data/models/chapter_model.dart';

class ChapterDetailPage extends StatefulWidget {
  final int chapterNum;
  final Map<String, String> chapter;
  final Color color;

  const ChapterDetailPage({
    super.key,
    required this.chapterNum,
    required this.chapter,
    required this.color,
  });

  @override
  State<ChapterDetailPage> createState() => _ChapterDetailPageState();
}

class _ChapterDetailPageState extends State<ChapterDetailPage> {
  final FavoritesService _favoritesService = FavoritesService.instance;
  final BookmarksService _bookmarksService = BookmarksService.instance;
  final AudioService _audioService = AudioService.instance;

  @override
  Widget build(BuildContext context) {
    final verses = ChapterModel.sampleVersesForChapter(widget.chapterNum);
    final chapterInfo = <String, String>{
      'num': widget.chapter['num'] ?? widget.chapterNum.toString(),
      'title': widget.chapter['title'] ?? '',
      'French': widget.chapter['French'] ?? '',
      'summary': widget.chapter['summary'] ?? '',
      'sanskrit': widget.chapter['title'] ?? '',
      'meaning': widget.chapter['summary'] ?? '',
    };
    final isBookmarked = _bookmarksService.isBookmarked(
      chapterNum: widget.chapterNum,
      verseNum: 0,
    );

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
                icon: Icon(
                  isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: const Color(0xFFFFD700),
                ),
                onPressed: () {
                  final isNowBookmarked = _bookmarksService.toggleBookmark(
                    chapterNum: widget.chapterNum,
                    verseNum: 0,
                    verse: chapterInfo,
                  );
                  setState(() {});
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isNowBookmarked
                            ? 'Chapter bookmarked'
                            : 'Chapter bookmark removed',
                      ),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.share_outlined,
                  color: Color(0xFFFFD700),
                ),
                onPressed: () {
                  final text =
                      '''
भगवद्गीता - अध्याय ${widget.chapterNum}

${widget.chapter['title'] ?? ''}
${widget.chapter['French'] ?? ''}

सारांश:
${widget.chapter['summary'] ?? ''}
''';
                  SharePlus.instance.share(ShareParams(text: text.trim()));
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      widget.color.withOpacity(0.4),
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
                          'अध्याय ${widget.chapter['num']}',
                          style: TextStyle(
                            color: widget.color,
                            fontSize: 16,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          widget.chapter['title']!,
                          style: const TextStyle(
                            color: Color(0xFFFFD700),
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.chapter['French']!,
                          style: TextStyle(
                            color: widget.color.withOpacity(0.9),
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
                  color: widget.color.withOpacity(0.1),
                  border: Border.all(color: widget.color.withOpacity(0.3)),
                ),
                child: Text(
                  widget.chapter['summary']!,
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
              delegate: SliverChildBuilderDelegate((context, index) {
                final verseNum = index + 1;
                final verse = verses[index];
                return AnimatedBuilder(
                  animation: _favoritesService,
                  builder: (_, __) => VerseCard(
                    verse: verse,
                    color: widget.color,
                    isFavorite: _favoritesService.isFavorite(
                      chapterNum: widget.chapterNum,
                      verseNum: verseNum,
                    ),
                    onPlay: () => _audioService.speakSanskritVerse(
                      verse['sanskrit'] ?? '',
                    ),
                    onLike: () {
                      _favoritesService.toggleFavorite(
                        chapterNum: widget.chapterNum,
                        verseNum: verseNum,
                        verse: verse,
                      );
                    },
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => VerseDetailPage(
                            verse: verse,
                            chapterNum: widget.chapterNum,
                            verseNum: verseNum,
                            color: widget.color,
                          ),
                        ),
                      );
                    },
                  ),
                );
              }, childCount: verses.length),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }
}
