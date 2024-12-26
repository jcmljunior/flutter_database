import 'package:flutter/material.dart';
import '../core/theme/theme_data_source.dart';
import 'shared_preferences_service.dart';

@immutable
class SharedPreferencesDataSource implements ThemeDataSource {
  final SharedPreferencesService _sharedPreferencesService =
      SharedPreferencesService();

  @override
  Future<ThemeMode?> getThemeMode() async {
    final int? themeModeIndex =
        await _sharedPreferencesService.getInt('themeMode');

    if (themeModeIndex != null) {
      return ThemeMode.values[themeModeIndex];
    }

    return null;
  }

  @override
  Future<void> setThemeMode(ThemeMode themeMode) async {
    await _sharedPreferencesService.setInt('themeMode', themeMode.index);
  }

  @override
  Future<Brightness?> getBrightness() async {
    final int? brightnessIndex =
        await _sharedPreferencesService.getInt('brightness');

    if (brightnessIndex != null) {
      return Brightness.values[brightnessIndex];
    }

    return null;
  }

  @override
  Future<void> setBrightness(Brightness brightness) async {
    await _sharedPreferencesService.setInt('brightness', brightness.index);
  }
}
