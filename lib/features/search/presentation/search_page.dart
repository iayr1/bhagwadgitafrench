import 'package:flutter/material.dart';

import '../../chapters/data/models/chapter_model.dart';
import '../../verse/presentation/pages/verse_detail_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = TextEditingController();
  String _query = '';

  List<Map<String, dynamic>> get _results {
    if (_query.trim().isEmpty) {
      return const [];
    }

    final query = _query.trim().toLowerCase();
    return ChapterModel.allSampleVersesWithReference().where((item) {
      final chapterNum = (item['chapterNum'] as int).toString();
      final verseNum = (item['verseNum'] as int).toString();
      final verse = item['verse'] as Map<String, String>;
      final searchableText = [
        chapterNum,
        verseNum,
        verse['sanskrit'] ?? '',
        verse['ahirani'] ?? '',
        verse['meaning'] ?? '',
      ].join(' ').toLowerCase();
      return searchableText.contains(query);
    }).toList();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final results = _results;

    return Scaffold(
      backgroundColor: const Color(0xFF1A0A00),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2D1200),
        title: const Text('शोधा', style: TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          TextField(
            controller: _controller,
            onChanged: (v) => setState(() => _query = v),
            style: const TextStyle(color: Color(0xFFDDC08A)),
            decoration: const InputDecoration(hintText: 'श्लोक, अध्याय, शब्द शोधा...'),
          ),
          const SizedBox(height: 16),
          if (_query.trim().isNotEmpty)
            Expanded(
              child: results.isEmpty
                  ? const Center(
                      child: Text(
                        'काहीही निकाल सापडले नाहीत.',
                        style: TextStyle(color: Color(0xFFFFAA55)),
                      ),
                    )
                  : ListView.separated(
                      itemCount: results.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final item = results[index];
                        final chapterNum = item['chapterNum'] as int;
                        final verseNum = item['verseNum'] as int;
                        final verse = item['verse'] as Map<String, String>;
                        final color = ChapterModel.chapterColors[(chapterNum - 1) % ChapterModel.chapterColors.length];

                        return Card(
                          color: const Color(0xFF2D1200),
                          child: ListTile(
                            onTap: () {
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
                            title: Text(
                              'अध्याय $chapterNum • श्लोक $verseNum',
                              style: const TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(
                                verse['sanskrit'] ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Color(0xFFDDC08A)),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            )
          else
            const Text('लोकप्रिय श्लोक: कर्मयोग, भक्ती, ज्ञान', style: TextStyle(color: Color(0xFFFFAA55))),
        ]),
      ),
    );
  }
}
