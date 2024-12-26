import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_database/features/core/localization/localization_data_source.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late LocalizationDataSource localizationDataSource;

  setUp(() async {
    localizationDataSource = LocalizationDataSource();
  });

  group('LocalizationDataSource', () {
    test('should return localized strings', () async {
      const Locale locale = Locale('en_US');
      final localizedStrings =
          await localizationDataSource.loadLocalization(locale);

      expect(localizedStrings, isNotEmpty);
    });
  });
}
