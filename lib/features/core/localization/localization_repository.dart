import 'dart:ui';
import 'localization_config.dart';
import 'localization_data_source.dart';

class LocalizationRepository {
  final LocalizationDataSource _dataSource;

  LocalizationRepository(this._dataSource);

  List<Locale> getSupportedLocalesOrderedByDeviceLocale(
      List<Locale> supportedLocales, Locale deviceLocale) {
    if (deviceLocale == LocalizationConfig.defaultLocale) {
      return supportedLocales;
    }

    final List<Locale> orderedLocales = List.from(supportedLocales);
    orderedLocales.remove(deviceLocale);
    orderedLocales.insert(0, deviceLocale);

    return orderedLocales;
  }

  Map<String, Map<String, String>> mergeLocalizedStrings(
      Map<String, Map<String, String>> primaryLocalizedStrings,
      Map<String, Map<String, String>> secondaryLocalizedStrings) {
    final Map<String, Map<String, String>> mergedLocalizedStrings = {
      ...primaryLocalizedStrings,
      ...secondaryLocalizedStrings,
    };

    return mergedLocalizedStrings;
  }

  Map<String, Map<String, String>> cleanLocalizedStrings(
      Map<String, Map<String, String>> localizedStrings, Locale locale) {
    final Map<String, Map<String, String>> cleanedLocalizedStrings =
        localizedStrings;

    cleanedLocalizedStrings.removeWhere((key, value) =>
        key != locale.toString() &&
        key != LocalizationConfig.defaultLocale.toString());

    return cleanedLocalizedStrings;
  }

  String fetchLocalizedStrings(String message, [List<String>? replacements]) {
    if (replacements != null && message.contains('%s')) {
      for (final String word in replacements) {
        message = message.replaceFirst(
          RegExp(r'%s'),
          word,
        );
      }
    }

    return message;
  }

  getLocalizedStrings(Locale locale) async =>
      await _dataSource.loadLocalization(locale);
}
