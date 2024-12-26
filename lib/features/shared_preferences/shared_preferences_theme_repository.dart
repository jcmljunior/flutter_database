import 'package:flutter/material.dart';
import '../core/theme/theme_data_source.dart';
import '../core/theme/theme_repository.dart';

@immutable
class SharedPreferencesThemeRepository implements ThemeRepository {
  @override
  final ThemeDataSource dataSource;

  const SharedPreferencesThemeRepository(this.dataSource);

  @override
  Future<Brightness?> getBrightness() async {
    return await dataSource.getBrightness();
  }

  @override
  Future<ThemeMode?> getThemeMode() async {
    return await dataSource.getThemeMode();
  }

  @override
  Future<void> setBrightness(Brightness brightness) async {
    await dataSource.setBrightness(brightness);
  }

  @override
  Future<void> setThemeMode(ThemeMode themeMode) async {
    await dataSource.setThemeMode(themeMode);
  }
}
