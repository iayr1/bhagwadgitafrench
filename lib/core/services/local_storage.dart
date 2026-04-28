import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../features/favorites/domain/favorite_verse.dart';

class LocalStorageService {
  LocalStorageService._();

  static final LocalStorageService instance = LocalStorageService._();
  static const _favoritesKey = 'favorites';
  static const _bookmarksKey = 'bookmarks';

  final List<FavoriteVerse> _favorites = <FavoriteVerse>[];
  final List<FavoriteVerse> _bookmarks = <FavoriteVerse>[];
  SharedPreferences? _prefs;

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    _favorites
      ..clear()
      ..addAll(_readList(_favoritesKey));
    _bookmarks
      ..clear()
      ..addAll(_readList(_bookmarksKey));
  }

  List<FavoriteVerse> getFavorites() => List<FavoriteVerse>.unmodifiable(_favorites);

  void saveFavorites(List<FavoriteVerse> favorites) {
    _favorites
      ..clear()
      ..addAll(favorites);
    _writeList(_favoritesKey, _favorites);
  }

  List<FavoriteVerse> getBookmarks() => List<FavoriteVerse>.unmodifiable(_bookmarks);

  void saveBookmarks(List<FavoriteVerse> bookmarks) {
    _bookmarks
      ..clear()
      ..addAll(bookmarks);
    _writeList(_bookmarksKey, _bookmarks);
  }

  List<FavoriteVerse> _readList(String key) {
    final raw = _prefs?.getStringList(key) ?? const <String>[];
    return raw
        .map((item) => FavoriteVerse.fromJson(jsonDecode(item) as Map<String, dynamic>))
        .toList();
  }

  void _writeList(String key, List<FavoriteVerse> items) {
    final payload = items.map((item) => jsonEncode(item.toJson())).toList();
    _prefs?.setStringList(key, payload);
  }
}
