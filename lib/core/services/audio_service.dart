import 'package:flutter_tts/flutter_tts.dart';

class AudioService {
  AudioService._();

  static final AudioService instance = AudioService._();

  final FlutterTts _flutterTts = FlutterTts();
  bool _initialized = false;

  Future<void> _ensureInitialized() async {
    if (_initialized) return;

    await _flutterTts.setLanguage('hi-IN');
    await _flutterTts.setPitch(1.0);
    await _flutterTts.setSpeechRate(0.3);
    _initialized = true;
  }

  Future<void> speakSanskritVerse(String verseText) async {
    await _ensureInitialized();
    await _flutterTts.stop();
    await _flutterTts.speak(verseText);
  }

  Future<void> stop() async {
    await _flutterTts.stop();
  }
}
