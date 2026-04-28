import 'package:flutter/foundation.dart';

import '../../features/favorites/domain/favorite_verse.dart';
import 'local_storage.dart';

class FavoritesService extends ChangeNotifier {
  FavoritesService._() {
    _favorites = List<FavoriteVerse>.of(LocalStorageService.instance.getFavorites());
  }

  static final FavoritesService instance = FavoritesService._();

  List<FavoriteVerse> _favorites = <FavoriteVerse>[];

  List<FavoriteVerse> get favorites => List<FavoriteVerse>.unmodifiable(_favorites);

  bool isFavorite({required int chapterNum, required int verseNum}) {
    return _favorites.any((item) => item.chapterNum == chapterNum && item.verseNum == verseNum);
  }

  bool toggleFavorite({
    required int chapterNum,
    required int verseNum,
    required Map<String, String> verse,
  }) {
    final index = _favorites.indexWhere((item) => item.chapterNum == chapterNum && item.verseNum == verseNum);

    if (index >= 0) {
      _favorites.removeAt(index);
      LocalStorageService.instance.saveFavorites(_favorites);
      notifyListeners();
      return false;
    }

    _favorites.insert(
      0,
      FavoriteVerse(chapterNum: chapterNum, verseNum: verseNum, verse: verse),
    );
    LocalStorageService.instance.saveFavorites(_favorites);
    notifyListeners();
    return true;
  }
}
