import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_database/features/core/localization/localization_config.dart';
import 'package:flutter_database/features/core/localization/localization_state.dart';
import 'package:flutter_database/features/core/localization/localization_store.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late LocalizationStore localizationStore;

  setUp(() async {
    localizationStore = LocalizationStore(LocalizationStateData());
  });

  group('LocalizationStore', () {
    test('should have initial values', () {
      expect(localizationStore.isLoading, false);
      expect(localizationStore.locale, LocalizationConfig.defaultLocale);
      expect(localizationStore.currentLocale, LocalizationConfig.defaultLocale);
      expect(localizationStore.localizedStrings,
          LocalizationConfig.defaultLocalizedStrings);
    });

    test('should set isLoading', () {
      localizationStore.isLoading = true;
      expect(localizationStore.isLoading, true);
    });

    test('should set locale', () {
      localizationStore.locale = const Locale('en_US');
      expect(localizationStore.locale, const Locale('en_US'));
    });

    test('should set localizedStrings', () {
      localizationStore.localizedStrings = {
        'en_US': {
          'key': 'value',
        },
      };
      expect(localizationStore.localizedStrings, {
        'en_US': {
          'key': 'value',
        },
      });
    });

    test('should update locale and localized strings correctly', () async {
      localizationStore.localizedStrings = {
        'pt_BR': {
          'key': 'value',
        },
      };

      await localizationStore.updateLocaleHandler(const Locale('es_ES'));
      await localizationStore.updateLocaleHandler(const Locale('en_US'));

      expect(localizationStore.locale, const Locale('en_US'));
      expect(localizationStore.localizedStrings.containsKey('en_US'), isTrue);
      expect(
          localizationStore.localizedStrings
              .containsKey(LocalizationConfig.defaultLocale.toString()),
          isTrue);
      expect(localizationStore.localizedStrings.length, equals(2));
    });

    test('should not update locale if already loading', () async {
      localizationStore.isLoading = true;

      await localizationStore.updateLocaleHandler(const Locale('es_ES'));

      expect(localizationStore.locale, LocalizationConfig.defaultLocale);
    });
  });
}
