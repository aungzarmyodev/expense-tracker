import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LanguageService extends ChangeNotifier {
  Locale _locale = const Locale('en');
  Map<String, dynamic> _strings = {};

  Locale get locale => _locale;

  String text(String key) => _strings[key] ?? key;

  Future<void> loadLanguage(String code) async {
    _locale = Locale(code);

    final jsonString =
        await rootBundle.loadString('assets/lang/$code.json');

    _strings = json.decode(jsonString);

    notifyListeners();
  }
}