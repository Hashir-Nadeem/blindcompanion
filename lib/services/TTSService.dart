import 'dart:async';

import 'package:flutter_tts/flutter_tts.dart';

class TTSService {
  FlutterTts flutterTts = FlutterTts();
  bool isSpeaking = true;

  Future<void> speak(String text) async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.3);

    await flutterTts.speak(text);
  }

  Future<void> stop() async {
    await flutterTts.stop();
  }

  Future<List<dynamic>> getAvailableLanguages() async {
    return await flutterTts.getLanguages;
  }

  Future<List<dynamic>> getAvailableVoices() async {
    return await flutterTts.getVoices;
  }
}
