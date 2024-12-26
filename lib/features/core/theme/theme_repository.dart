import 'package:flutter/material.dart';
import 'theme_data_source.dart';

abstract class ThemeRepository {
  final ThemeDataSource dataSource;

  ThemeRepository(this.dataSource);

  Future<void> setThemeMode(ThemeMode themeMode);
  Future<void> setBrightness(Brightness brightness);
  Future<ThemeMode?> getThemeMode();
  Future<Brightness?> getBrightness();
}
