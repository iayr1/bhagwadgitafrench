import 'package:flutter/foundation.dart';

import '../../features/favorites/domain/favorite_verse.dart';
import 'local_storage.dart';

class BookmarksService extends ChangeNotifier {
  BookmarksService._() {
    _bookmarks = List<FavoriteVerse>.of(LocalStorageService.instance.getBookmarks());
  }

  static final BookmarksService instance = BookmarksService._();

  List<FavoriteVerse> _bookmarks = <FavoriteVerse>[];

  List<FavoriteVerse> get bookmarks => List<FavoriteVerse>.unmodifiable(_bookmarks);

  bool isBookmarked({required int chapterNum, required int verseNum}) {
    return _bookmarks.any(
      (item) => item.chapterNum == chapterNum && item.verseNum == verseNum,
    );
  }

  bool toggleBookmark({
    required int chapterNum,
    required int verseNum,
    required Map<String, String> verse,
  }) {
    final index = _bookmarks.indexWhere(
      (item) => item.chapterNum == chapterNum && item.verseNum == verseNum,
    );

    if (index >= 0) {
      _bookmarks.removeAt(index);
      LocalStorageService.instance.saveBookmarks(_bookmarks);
      notifyListeners();
      return false;
    }

    _bookmarks.insert(
      0,
      FavoriteVerse(chapterNum: chapterNum, verseNum: verseNum, verse: verse),
    );
    LocalStorageService.instance.saveBookmarks(_bookmarks);
    notifyListeners();
    return true;
  }
}
