import 'package:bhagwadgita/features/chapters/data/models/chapter_model.dart';
import 'package:flutter/material.dart';
import '../../../core/services/audio_service.dart';
import '../../../core/services/favorites_service.dart';
import '../../verse/presentation/pages/verse_detail_page.dart';

class DailyVersePage extends StatefulWidget {
  const DailyVersePage({super.key});

  @override
  State<DailyVersePage> createState() => _DailyVersePageState();
}

class _DailyVersePageState extends State<DailyVersePage> {
  final FavoritesService _favoritesService = FavoritesService.instance;
  final AudioService _audioService = AudioService.instance;

  @override
  Widget build(BuildContext context) {
    final dailyVerseData = ChapterModel.verseForDate(DateTime.now());
    final chapterNum = dailyVerseData['chapterNum'] as int;
    final verseNum = dailyVerseData['verseNum'] as int;
    final verse = dailyVerseData['verse'] as Map<String, String>;
    final color = ChapterModel.chapterColors[(chapterNum - 1) % ChapterModel.chapterColors.length];

    return Scaffold(
      backgroundColor: const Color(0xFF1A0A00),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2D1200),
        title: const Text('आजचो श्लोक', style: TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold)),
      ),
      body: AnimatedBuilder(
        animation: _favoritesService,
        builder: (_, __) {
          final isFavorite = _favoritesService.isFavorite(chapterNum: chapterNum, verseNum: verseNum);

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFF2D1200),
                  border: Border.all(color: color.withOpacity(0.45)),
                ),
                child: Column(
                  children: [
                    Text(
                      'अध्याय $chapterNum • श्लोक $verseNum',
                      style: TextStyle(color: color, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      verse['sanskrit'] ?? '',
                      style: const TextStyle(color: Color(0xFFFFD700), fontSize: 20, height: 1.7),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(verse['ahirani'] ?? '', style: const TextStyle(color: Color(0xFFDDC08A), height: 1.6)),
              const SizedBox(height: 12),
              Text(verse['meaning'] ?? '', style: const TextStyle(color: Color(0xFFBFA06A), height: 1.6)),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _audioService.speakSanskritVerse(verse['sanskrit'] ?? ''),
                      icon: const Icon(Icons.play_circle_outline),
                      label: const Text('ऐका'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        _favoritesService.toggleFavorite(
                          chapterNum: chapterNum,
                          verseNum: verseNum,
                          verse: verse,
                        );
                      },
                      icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                      label: Text(isFavorite ? 'आवडतेमध्ये आहे' : 'आवडते करा'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => VerseDetailPage(
                        verse: verse,
                        chapterNum: chapterNum,
                        verseNum: verseNum,
                        color: color,
                      ),
                    ),
                  );
                },
                child: const Text('सविस्तर वाचा'),
              ),
            ],
          );
        },
      ),
    );
  }
}
