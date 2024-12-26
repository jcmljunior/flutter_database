import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_database/features/core/localization/localization_data_source.dart';
import 'package:flutter_database/features/core/localization/localization_repository.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  late LocalizationDataSource localizationDataSource;
  late LocalizationRepository localizationRepository;

  setUp(() async {
    localizationDataSource = LocalizationDataSource();
    localizationRepository = LocalizationRepository(localizationDataSource);
  });

  group('LocalizationRepository', () {
    test('should return localized strings', () async {
      final localizedStrings = await localizationRepository
          .getLocalizedStrings(const Locale('en_US'));
      expect(localizedStrings, isNotEmpty);
    });

    test('should get supported locales ordered by device locale', () {
      const supportedLocales = [
        Locale('en_US'),
        Locale('es_ES'),
        Locale('pt_BR'),
      ];
      const deviceLocale = Locale('es_ES');

      final orderedLocales =
          localizationRepository.getSupportedLocalesOrderedByDeviceLocale(
        supportedLocales,
        deviceLocale,
      );

      expect(orderedLocales, [
        const Locale('es_ES'),
        const Locale('en_US'),
        const Locale('pt_BR'),
      ]);
    });

    test('should merge localized strings', () {
      final Map<String, Map<String, String>> primaryLocalizedStrings = {
        'en_US': {
          'key': 'value',
        },
      };
      final Map<String, Map<String, String>> secondaryLocalizedStrings = {
        'pt_BR': {
          'key': 'value',
        },
      };

      final mergedLocalizedStrings =
          localizationRepository.mergeLocalizedStrings(
              primaryLocalizedStrings, secondaryLocalizedStrings);

      expect(mergedLocalizedStrings.containsKey('en_US'), isTrue);
      expect(mergedLocalizedStrings.containsKey('pt_BR'), isTrue);
    });

    test('should clean localized strings', () {
      const Locale locale = Locale('en_US');
      final Map<String, Map<String, String>> localizedStrings = {
        'en_US': {
          'key': 'value',
        },
        'pt_BR': {
          'key': 'value',
        },
        'es_ES': {
          'key': 'value',
        },
      };
      final cleanedLocalizedStrings = localizationRepository
          .cleanLocalizedStrings(localizedStrings, locale);

      expect(cleanedLocalizedStrings.containsKey(locale.toString()), isTrue);
      expect(cleanedLocalizedStrings.length, equals(2));
    });

    test('should fetch localized strings with replacements', () async {
      final Map<String, Map<String, String>> localizedStrings = {
        'pt_BR': {
          'key': 'Bem-vindo(a), %s!',
        },
      };
      final actual = localizationRepository
          .fetchLocalizedStrings(localizedStrings['pt_BR']!['key']!, ['John']);

      expect(
          actual,
          equals(
              localizedStrings['pt_BR']!['key']!.replaceFirst('%s', 'John')));
    });
  });
}
