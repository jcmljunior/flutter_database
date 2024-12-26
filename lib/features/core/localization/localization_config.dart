import 'dart:ui';

class LocalizationConfig {
  static const String defaultPathForLocales = 'assets/localization';
  static const List<Locale> defaultAvailableLocales = [
    Locale.fromSubtags(
      languageCode: 'pt',
      countryCode: 'BR',
    ),
    Locale.fromSubtags(
      languageCode: 'en',
      countryCode: 'US',
    ),
    Locale.fromSubtags(
      languageCode: 'es',
      countryCode: 'ES',
    ),
  ];
  static final Locale defaultLocale = defaultAvailableLocales.first;
  static const Map<String, Map<String, String>> defaultLocalizedStrings = {};
}
