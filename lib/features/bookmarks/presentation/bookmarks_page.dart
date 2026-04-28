import 'package:flutter/material.dart';

import '../../../core/services/audio_service.dart';
import '../../../core/services/bookmarks_service.dart';
import '../../chapters/data/models/chapter_model.dart';
import '../../chapters/presentation/pages/chapter_detail_page.dart';
import '../../verse/presentation/pages/verse_detail_page.dart';

class BookmarksPage extends StatelessWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bookmarksService = BookmarksService.instance;
    final audioService = AudioService.instance;

    return Scaffold(
      backgroundColor: const Color(0xFF1A0A00),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2D1200),
        title: const Text(
          'Bookmarks',
          style: TextStyle(
            color: Color(0xFFFFD700),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: AnimatedBuilder(
        animation: bookmarksService,
        builder: (context, _) {
          final bookmarks = bookmarksService.bookmarks;

          if (bookmarks.isEmpty) {
            return const Center(
              child: Text(
                'No bookmarks yet.',
                style: TextStyle(
                  color: Color(0xFFAA8855),
                  fontSize: 14,
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: bookmarks.length,
            itemBuilder: (context, index) {
              final item = bookmarks[index];
              final color = ChapterModel.chapterColors[
                  (item.chapterNum - 1) %
                      ChapterModel.chapterColors.length];

              final isChapterBookmark = item.verseNum == 0;

              return Card(
                color: const Color(0xFF2D1200),
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  onTap: () {
                    if (isChapterBookmark) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChapterDetailPage(
                            chapterNum: item.chapterNum,
                            chapter: item.verse,
                            color: color,
                          ),
                        ),
                      );
                      return;
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VerseDetailPage(
                          verse: item.verse,
                          chapterNum: item.chapterNum,
                          verseNum: item.verseNum,
                          color: color,
                        ),
                      ),
                    );
                  },
                  title: Text(
                    isChapterBookmark
                        ? 'Chapter ${item.chapterNum} • Full Chapter'
                        : 'Chapter ${item.chapterNum} • Verse ${item.verseNum}',
                    style: const TextStyle(
                      color: Color(0xFFFFD700),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      isChapterBookmark
                          ? (item.verse['summary'] ?? '')
                          : (item.verse['sanskrit'] ?? ''),
                      style: const TextStyle(
                        color: Color(0xFFDDC08A),
                        height: 1.4,
                      ),
                      maxLines: isChapterBookmark ? 3 : 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (!isChapterBookmark)
                        IconButton(
                          icon: const Icon(
                            Icons.play_circle_outline,
                            color: Color(0xFFFFD700),
                          ),
                          onPressed: () => audioService
                              .speakSanskritVerse(
                                  item.verse['sanskrit'] ?? ''),
                        ),
                      IconButton(
                        icon: const Icon(
                          Icons.bookmark,
                          color: Color(0xFFFFD700),
                        ),
                        onPressed: () {
                          bookmarksService.toggleBookmark(
                            chapterNum: item.chapterNum,
                            verseNum: item.verseNum,
                            verse: item.verse,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}