import 'package:flutter/widgets.dart';
import 'localization_data_source.dart';
import 'localization_repository.dart';
import 'localization_state.dart';

class LocalizationStore extends ValueNotifier<LocalizationStateData> {
  final LocalizationRepository _repository =
      LocalizationRepository(LocalizationDataSource());

  LocalizationStore(super.value);

  bool get isLoading => value.isLoading!;

  set isLoading(bool isLoading) {
    if (isLoading == value.isLoading) {
      return;
    }

    value = value.copyWith(
      isLoading: isLoading,
    );
  }

  Locale get locale => value.locale!;

  Locale get currentLocale => locale;

  set locale(Locale locale) {
    if (locale == value.locale) {
      return;
    }

    value = value.copyWith(
      locale: locale,
    );
  }

  Map<String, Map<String, String>> get localizedStrings =>
      value.localizedStrings!;

  set localizedStrings(Map<String, Map<String, String>> localizedStrings) {
    if (localizedStrings == value.localizedStrings) {
      return;
    }

    value = value.copyWith(
      localizedStrings: localizedStrings,
    );
  }

  Future<void> updateLocaleHandler(Locale locale,
      [bool forceUpdate = false]) async {
    if (isLoading) {
      return;
    }

    if (locale == currentLocale && !forceUpdate) {
      return;
    }

    isLoading = true;

    try {
      final Map<String, Map<String, String>> secondaryLocalizedStrings =
          await _repository.getLocalizedStrings(locale);

      localizedStrings = _repository.mergeLocalizedStrings(
          localizedStrings, secondaryLocalizedStrings);

      if (!localizedStrings.containsKey(locale.toString())) {
        return;
      }

      this.locale = locale;
    } catch (e) {
      throw Exception(e);
    } finally {
      isLoading = false;
      localizedStrings =
          _repository.cleanLocalizedStrings(localizedStrings, locale);
    }
  }
}
