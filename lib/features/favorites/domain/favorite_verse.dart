class FavoriteVerse {
  final int chapterNum;
  final int verseNum;
  final Map<String, String> verse;

  const FavoriteVerse({
    required this.chapterNum,
    required this.verseNum,
    required this.verse,
  });

  String get id => '$chapterNum-$verseNum';

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'chapterNum': chapterNum,
      'verseNum': verseNum,
      'verse': verse,
    };
  }

  factory FavoriteVerse.fromJson(Map<String, dynamic> json) {
    final verseData = json['verse'];
    final verseMap = <String, String>{};
    if (verseData is Map) {
      for (final entry in verseData.entries) {
        verseMap[entry.key.toString()] = entry.value.toString();
      }
    }

    return FavoriteVerse(
      chapterNum: json['chapterNum'] as int? ?? 0,
      verseNum: json['verseNum'] as int? ?? 0,
      verse: verseMap,
    );
  }
}
