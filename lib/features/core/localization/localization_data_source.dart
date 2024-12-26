import 'dart:convert';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'localization_config.dart';

class LocalizationDataSource {
  Future<Map<String, Map<String, String>>> loadLocalization(
      Locale locale) async {
    final String jsonString = await rootBundle.loadString(
      '${LocalizationConfig.defaultPathForLocales}/${locale.toString()}.json',
    );
    final Map<String, dynamic> jsonResponse = jsonDecode(jsonString);

    return {
      locale.toString(): jsonResponse.map<String, String>(
        (key, value) => MapEntry<String, String>(key, value.toString()),
      ),
    };
  }
}
