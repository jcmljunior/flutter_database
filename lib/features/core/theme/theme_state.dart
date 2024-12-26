import 'package:flutter/material.dart';
import 'theme_config.dart';

@immutable
sealed class ThemeState {
  final ThemeMode? themeMode;
  final Brightness? brightness;

  const ThemeState({
    this.themeMode,
    this.brightness,
  })  : assert(themeMode != null, 'ThemeMode must not be null.'),
        assert(brightness != null, 'Brightness must not be null.');

  ThemeState copyWith({
    ThemeMode? themeMode,
    Brightness? brightness,
  });
}

class ThemeStateData extends ThemeState {
  const ThemeStateData({
    ThemeMode? themeMode,
    Brightness? brightness,
  }) : super(
          themeMode: themeMode ?? ThemeConfig.defaultThemeMode,
          brightness: brightness ?? ThemeConfig.defaultBrightness,
        );

  @override
  ThemeState copyWith({
    ThemeMode? themeMode,
    Brightness? brightness,
  }) =>
      ThemeStateData(
        themeMode: themeMode ?? this.themeMode,
        brightness: brightness ?? this.brightness,
      );
}
