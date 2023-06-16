import 'dart:async';
import 'dart:ui';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:translator/translator.dart';

class TTSService {
  FlutterTts flutterTts = FlutterTts();
  bool isSpeaking = true;
  GoogleTranslator translator = GoogleTranslator();

  Future<void> speak(String text) async {
    Locale? locale = Get.locale;
    String languageCode = locale!.languageCode;
    String? countryCode = locale!.countryCode;
    String language = '$languageCode-$countryCode';

    if (languageCode == 'ur' && countryCode == 'PK') {
      // Translate to Urdu
      Translation translation =
          await translator.translate(text, from: 'en', to: 'ur');
      String translatedText = translation.text;

      await flutterTts.setLanguage('ur');
      await flutterTts.setPitch(1.0);
      await flutterTts.setSpeechRate(0.3);

      await flutterTts.speak(translatedText);
    } else if (languageCode == 'en' && countryCode == 'US') {
      // Speak in English
      await flutterTts.setLanguage('en-US');
      await flutterTts.setPitch(1.0);
      await flutterTts.setSpeechRate(0.3);

      await flutterTts.speak(text);
    } else {
      // Default: Speak in English
      await flutterTts.setLanguage('en-US');
      await flutterTts.setPitch(1.0);
      await flutterTts.setSpeechRate(0.3);

      await flutterTts.speak(text);
    }
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
