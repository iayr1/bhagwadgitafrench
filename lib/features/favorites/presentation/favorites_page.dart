import 'package:flutter/material.dart';

import '../../../core/services/audio_service.dart';
import '../../../core/services/favorites_service.dart';
import '../../chapters/data/models/chapter_model.dart';
import '../../verse/presentation/pages/verse_detail_page.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesService = FavoritesService.instance;
    final audioService = AudioService.instance;

    return Scaffold(
      backgroundColor: const Color(0xFF1A0A00),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2D1200),
        title: const Text('आवडते श्लोक', style: TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold)),
      ),
      body: AnimatedBuilder(
        animation: favoritesService,
        builder: (context, _) {
          final favorites = favoritesService.favorites;

          if (favorites.isEmpty) {
            return const Center(
              child: Text(
                'अजून कुठलाही श्लोक आवडता केलेला नाही.',
                style: TextStyle(color: Color(0xFFAA8855), fontSize: 14),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final item = favorites[index];
              return Card(
                color: const Color(0xFF2D1200),
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  onTap: () {
                    final color = ChapterModel.chapterColors[(item.chapterNum - 1) % ChapterModel.chapterColors.length];
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
                    'अध्याय ${item.chapterNum} • श्लोक ${item.verseNum}',
                    style: const TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      item.verse['sanskrit'] ?? '',
                      style: const TextStyle(color: Color(0xFFDDC08A), height: 1.4),
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.play_circle_outline, color: Color(0xFFFFD700)),
                        onPressed: () => audioService.speakSanskritVerse(item.verse['sanskrit'] ?? ''),
                      ),
                      IconButton(
                        icon: const Icon(Icons.favorite, color: Colors.redAccent),
                        onPressed: () {
                          favoritesService.toggleFavorite(
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
