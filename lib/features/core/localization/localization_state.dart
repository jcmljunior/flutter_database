import 'package:flutter/widgets.dart';
import 'localization_config.dart';

@immutable
sealed class LocalizationState {
  final bool? isLoading;
  final Locale? locale;
  final Map<String, Map<String, String>>? localizedStrings;

  const LocalizationState({
    this.isLoading,
    this.locale,
    this.localizedStrings,
  })  : assert(isLoading != null, 'isLoading must not be null.'),
        assert(locale != null, 'locale must not be null.'),
        assert(localizedStrings != null, 'localizedStrings must not be null.');

  LocalizationState copyWith({
    bool? isLoading,
    Locale? locale,
    Map<String, Map<String, String>>? localizedStrings,
  });
}

class LocalizationStateData extends LocalizationState {
  LocalizationStateData({
    bool? isLoading,
    Locale? locale,
    Map<String, Map<String, String>>? localizedStrings,
  }) : super(
          isLoading: isLoading ?? false,
          locale: locale ?? LocalizationConfig.defaultLocale,
          localizedStrings:
              localizedStrings ?? LocalizationConfig.defaultLocalizedStrings,
        );

  @override
  LocalizationStateData copyWith(
          {bool? isLoading,
          Locale? locale,
          Map<String, Map<String, String>>? localizedStrings}) =>
      LocalizationStateData(
        isLoading: isLoading ?? this.isLoading,
        locale: locale ?? this.locale,
        localizedStrings: localizedStrings ?? this.localizedStrings,
      );
}
